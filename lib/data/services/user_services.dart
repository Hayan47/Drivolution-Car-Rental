import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/usr_model.dart';

class UserServices {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;
  final FirebaseMessaging firebaseMessaging;

  UserServices({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
    required this.firebaseMessaging,
  });

  //? sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    final cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    addFCMToken(cred.user!.uid);
    return cred;
  }

  //? sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    await googleSignIn.signOut();
    //! begin interactive sign in process
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
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
    UserCredential cred = await firebaseAuth.signInWithCredential(credential);

    //! add google details
    DateTime c = cred.user!.metadata.creationTime!;
    DateTime l = cred.user!.metadata.lastSignInTime!;
    if (c.year == l.year &&
        c.month == l.month &&
        c.day == l.day &&
        c.hour == l.hour &&
        c.minute == l.minute) {
      addGoogleDetails(
        firstName: firstName,
        lastName: lastName,
        email: googleSignInAccount.email,
        id: cred.user!.uid,
      );
      //! add img
      if (googleSignInAccount.photoUrl != null) {
        addImage(googleSignInAccount.photoUrl!, cred.user!.uid);
      }
    }
    //! add fcm token
    addFCMToken(cred.user!.uid);

    return cred;
  }

  signOut() async {
    await removeFCMToken();
    firebaseAuth.signOut();
    googleSignIn.signOut();
  }

  //? add phone number
  Future addPhoneNumber(String phoneNumber, String userID) async {
    await firebaseFirestore.collection('users').doc(userID).update({
      'phoneNumber': phoneNumber,
    });
  }

  //? sign up
  Future<UserCredential> signUp(String email, String password, String firstName,
      String lastName, String phoneNumber, int age) async {
    //! create user
    UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    //! add fcm token
    addFCMToken(cred.user!.uid);

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
    await firebaseFirestore.collection('users').doc(id).set({
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
    await firebaseFirestore.collection('users').doc(id).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'favoriteCars': [],
    });
  }

  //? add img
  Future addImage(String url, String id) async {
    await firebaseFirestore.collection('users').doc(id).update({
      'image': url,
    });
  }

  //? get user info
  Future<Usr?> getUserInfo(String userID) async {
    var data = firebaseFirestore.collection('users').doc(userID).withConverter(
          fromFirestore: Usr.fromFirestore,
          toFirestore: (usr, options) => usr.toFirestore(),
        );
    final snapshot = await data.get();
    final usr = snapshot.data();
    return usr;
  }

  //? reset password
  Future resetPassword(String email) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //? add to favorite
  Future addToFavorite(String carid, String userid) async {
    await firebaseFirestore.collection('users').doc(userid).update({
      'favoriteCars': FieldValue.arrayUnion([carid])
    });
  }

  //? remove from favorite
  Future removeFromFavorite(String carid, String userid) async {
    await firebaseFirestore.collection('users').doc(userid).update({
      'favoriteCars': FieldValue.arrayRemove([carid])
    });
  }

  //?get favorite cars
  Future<List<Car>> getFavoriteCars(List<String> favoriteCarsIds) async {
    List<Car> favoriteCars = [];
    var snapshot = await firebaseFirestore
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
    var snapshot = await firebaseFirestore
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

  //?add user FCM Token
  Future<void> addFCMToken(String uid) async {
    final fCMToken = await firebaseMessaging.getToken();
    if (fCMToken != null) {
      firebaseFirestore.collection('users').doc(uid).update({
        'FCM': fCMToken,
      });
    }
  }

  //?remove user FCM Token
  Future<void> removeFCMToken() async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .update({
      'FCM': '',
    });
  }
}
