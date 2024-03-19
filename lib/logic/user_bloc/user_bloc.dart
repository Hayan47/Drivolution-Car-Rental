import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final usersServices = UserServices();
    UserCredential userCredentials;

    on<SignIn>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          userCredentials =
              await usersServices.signIn(event.email, event.password);
          add(GetUserInfo(userID: userCredentials.user!.uid));
          print(state);
        } catch (e) {
          emit(const UserError('Error Sining In'));
          print(state);
        }
      },
    );

    on<SignInWithGoogle>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          userCredentials = await usersServices.signInWithGoogle();
          add(GetUserInfo(userID: userCredentials.user!.uid));
          print(state);
        } catch (e) {
          emit(const UserError('Error Sining In'));
          print(state);
        }
      },
    );

    on<SignOut>(
      (event, emit) {
        usersServices.signOut();
      },
    );

    on<SignUp>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          userCredentials = await usersServices.signUp(
            event.email,
            event.password,
            event.firstName,
            event.lastName,
            event.phoneNumber,
            event.age,
          );
          add(GetUserInfo(userID: userCredentials.user!.uid));
          print(state);
        } catch (e) {
          emit(const UserError('Error Signing Up'));
          print(state);
        }
      },
    );

    on<ResetPassword>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          usersServices.resetPassword(event.email);
          emit(UserInitial());
          print(state);
        } catch (e) {
          emit(const UserError('Error Resetting Password'));
          print(state);
        }
      },
    );

    on<AddUserPhoneNumber>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          usersServices.addPhoneNumber(event.phoneNumber, event.userID);
          emit(UserInitial());
          add(GetUserInfo(userID: event.userID));
          print(state);
        } catch (e) {
          emit(const UserError('Error Adding Number'));
          print(state);
        }
      },
    );

    on<AddUserImage>(
      (event, emit) async {
        try {
          // emit(UserLoading());
          // print(state);
          usersServices.addImage(event.imageUrl, event.userID);
          add(GetUserInfo(userID: event.userID));
          // emit(UserInitial());
          // print(state);
        } catch (e) {
          emit(const UserError('Error Adding Number'));
          print(state);
        }
      },
    );

    on<GetUserInfo>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          final userInfo = await usersServices.getUserInfo(event.userID);
          final userCars = await usersServices.getUserCars(event.userID);
          emit(UserLoaded(userInfo: userInfo!, cars: userCars));
          print(state);
        } catch (e) {
          emit(const UserError('Failed to load user information'));
          print(state);
        }
      },
    );
  }
}
