// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/usr_model.dart';

class UserServices {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  //? sign in
  Future signIn(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: e.message.toString(),
        margin: 0, //MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? sign in with Google
  Future signInWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      //! begin interactive sign in process
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
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
      UserCredential cred = await _auth.signInWithCredential(credential);

      //! add google details
      addGoogleDetails(
        firstName: firstName,
        lastName: lastName,
        email: googleSignInAccount.email,
        id: cred.user!.uid,
      );
      //! add img
      if (googleSignInAccount.photoUrl != null) {
        addImage(context, googleSignInAccount.photoUrl!, cred.user!.uid);
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: e.message.toString(),
        margin: 0, //MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? add phone number
  Future addPhoneNumber(
      String phoneNumber, String id, BuildContext context) async {
    try {
      await _store.collection('users').doc(id).update({
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: e.toString(),
        margin: 0, //MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? sign up
  Future signUp(BuildContext context, String email, String password,
      String firstName, String lastName, String phoneNumber, int age) async {
    try {
      //! create user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //! add user details
      addUserDetails(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          email: email,
          age: age,
          id: cred.user!.uid);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: e.message.toString(),
        margin: 0, //MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
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
    });
  }

  //? add img
  Future addImage(BuildContext context, String url, String id) async {
    try {
      await _store.collection('users').doc(id).update({
        'image': url,
      });
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.done,
          color: Colors.green,
          size: 20,
        ),
        title: 'Done',
        message: 'Image Edited',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'Image not edited',
        margin: 0, //MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? get user info
  Future<Usr?> getUserInfo(String userID) async {
    try {
      var data = _store.collection('users').doc(userID).withConverter(
            fromFirestore: Usr.fromFirestore,
            toFirestore: (usr, options) => usr.toFirestore(),
          );
      final snapshot = await data.get();
      final usr = snapshot.data(); // Convert to City object
      return usr;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //? reset password
  Future resetPassword(BuildContext context, String email) async {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: e.message.toString(),
        margin: 0, //MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? add to favorite
  Future addToFavorite(String carid, String userid) async {
    try {
      await _store.collection('users').doc(userid).update({
        'favoriteCars': FieldValue.arrayUnion([carid])
      });
    } catch (e) {
      print(e);
    }
  }

  //? remove from favorite
  Future removeFromFavorite(String carid, String userid) async {
    try {
      await _store.collection('users').doc(userid).update({
        'favoriteCars': FieldValue.arrayRemove([carid])
      });
    } catch (e) {
      print(e);
    }
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
    print(favoriteCars);

    return favoriteCars;
  }
}
