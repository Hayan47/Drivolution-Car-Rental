import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/usr_model.dart';

class UserServices {
  final auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  final _googleSignin = GoogleSignIn();

  //? sign in
  Future<UserCredential> signIn(String email, String password) async {
    final cred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return cred;
  }

  //? sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    await _googleSignin.signOut();
    //! begin interactive sign in process
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignin.signIn();
    //! obtain auth details from requests
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    //! create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final fullname = googleSignInAccount.displayName;
    final firstName = fullname!.split(' ')[0];
    final lastName = fullname.split(' ')[1];

    //! finaly sign in
    UserCredential cred = await auth.signInWithCredential(credential);

    //! add google details
    if (cred.user!.metadata.creationTime ==
        cred.user!.metadata.lastSignInTime) {
      addGoogleDetails(
        firstName: firstName,
        lastName: lastName,
        email: googleSignInAccount.email,
        id: cred.user!.uid,
      );
    }
    //! add img
    if (googleSignInAccount.photoUrl != null) {
      addImage(googleSignInAccount.photoUrl!, cred.user!.uid);
    }

    return cred;
  }

  signOut() {
    auth.signOut();
    _googleSignin.signOut();
  }

  //? add phone number
  Future addPhoneNumber(String phoneNumber, String userID) async {
    await _store.collection('users').doc(userID).update({
      'phoneNumber': phoneNumber,
    });
  }

  //? sign up
  Future<UserCredential> signUp(String email, String password, String firstName,
      String lastName, String phoneNumber, int age) async {
    //! create user
    UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //! add user details
    addUserDetails(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      age: age,
      id: cred.user!.uid,
    );

    return cred;
  }

  //? add user details
  Future addUserDetails({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    required String email,
    int? age,
    required String id,
  }) async {
    await _store.collection('users').doc(id).set({
      'first name': firstName,
      'last name': lastName,
      'age': age,
      'email': email,
      'phoneNumber': phoneNumber,
      'favoriteCars': [],
    });
  }

  //? add google details
  Future addGoogleDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String id,
  }) async {
    await _store.collection('users').doc(id).update({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'favoriteCars': [],
    });
  }

  //? add img
  Future addImage(String url, String id) async {
    await _store.collection('users').doc(id).update({
      'image': url,
    });
  }

  //? get user info
  Future<Usr?> getUserInfo(String userID) async {
    var data = _store.collection('users').doc(userID).withConverter(
        fromFirestore: Usr.fromFirestore,
        toFirestore: (usr, options) => usr.toFirestore());
    final snapshot = await data.get();
    final usr = snapshot.data();
    return usr;
  }

  //? reset password
  Future resetPassword(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  //? add to favorite
  Future addToFavorite(String carid, String userid) async {
    await _store.collection('users').doc(userid).update({
      'favoriteCars': FieldValue.arrayUnion([carid])
    });
  }

  //? remove from favorite
  Future removeFromFavorite(String carid, String userid) async {
    await _store.collection('users').doc(userid).update({
      'favoriteCars': FieldValue.arrayRemove([carid])
    });
  }

  //?get favorite cars
  Future<List<Car>> getFavoriteCars(List<String> favoriteCarsIds) async {
    List<Car> favoriteCars = [];
    var snapshot = await _store
        .collection('cars')
        .where(FieldPath.documentId, whereIn: favoriteCarsIds)
        .withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (car, options) => car.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var car = doc.data();
      favoriteCars.add(car);
    }
    return favoriteCars;
  }

  //?get user cars
  Future<List<Car>> getUserCars(String userID) async {
    List<Car> userCars = [];
    var snapshot = await _store
        .collection('cars')
        .where('ownerid', isEqualTo: userID)
        .withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (car, options) => car.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var car = doc.data();
      userCars.add(car);
    }
    return userCars;
  }
}
