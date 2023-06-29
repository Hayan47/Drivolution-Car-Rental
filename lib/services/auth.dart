// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/models/usr_model.dart';

class Auth {
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
      ));
    }
  }

  //? sign up
  Future signUp(BuildContext context, String email, String password,
      String firstName, String lastName, int age) async {
    try {
      //! create user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //! add user details
      addUserDetails(firstName, lastName, email, age, cred);
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
      ));
    }
  }

  //? add user details
  Future addUserDetails(String firstName, String lastName, String email,
      int age, UserCredential cred) async {
    await _store.collection('users').doc(cred.user!.uid).set({
      'first name': firstName,
      'last name': lastName,
      'age': age,
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
      ));
    }
  }

  //? get user info
  Future<Usr?> getUserInfo(String userID) async {
    var data = _store.collection('users').doc(userID).withConverter(
          fromFirestore: Usr.fromFirestore,
          toFirestore: (usr, options) => usr.toFirestore(),
        );
    final snapshot = await data.get();
    final usr = snapshot.data(); // Convert to City object
    if (usr != null) {
      return usr;
    } else {
      // print("No such document.");
    }
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
      ));
    }
  }
}
