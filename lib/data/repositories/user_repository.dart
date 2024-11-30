import 'package:drivolution/data/exceptions/auth_exception.dart';
import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final UserServices userServices;

  UserRepository({required this.userServices});

  Future<List<Car>> getFavoriteCars(List<String> favoriteCarsIds) async {
    try {
      return await userServices.getFavoriteCars(favoriteCarsIds);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> addToFavorite(String carid, String userid) async {
    try {
      await userServices.addToFavorite(carid, userid);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> removeFromFavorite(String carid, String userid) async {
    try {
      await userServices.removeFromFavorite(carid, userid);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  //todo firebase messaging exception (FCM Token)
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await userServices.signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  //todo
  Future<UserCredential> signInWithGoogle() async {
    try {
      return await userServices.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  //todo
  Future<void> signOut() async {
    try {
      await userServices.signOut();
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  //todo
  Future<UserCredential> signUp(String email, String password, String firstName,
      String lastName, String phoneNumber, int age) async {
    try {
      return await userServices.signUp(
          email, password, firstName, lastName, phoneNumber, age);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await userServices.resetPassword(email);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> addPhoneNumber(String phoneNumber, String userID) async {
    try {
      await userServices.addPhoneNumber(phoneNumber, userID);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> addImage(String url, String id) async {
    try {
      await userServices.addImage(url, id);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<Usr?> getUserInfo(String userID) async {
    try {
      return await userServices.getUserInfo(userID);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<List<Car>> getUserCars(String userID) async {
    try {
      return await userServices.getUserCars(userID);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }
}
