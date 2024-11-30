import 'package:drivolution/data/exceptions/auth_exception.dart';
import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/data/repositories/user_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    final logger = LoggerService().getLogger('User Bloc Logger');
    UserCredential userCredentials;

    on<SignIn>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userCredentials = await userRepository.signInWithEmailAndPassword(
              event.email, event.password);
          add(GetUserInfo(userID: userCredentials.user!.uid));
        } on AuthException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<SignInWithGoogle>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userCredentials = await userRepository.signInWithGoogle();
          add(GetUserInfo(userID: userCredentials.user!.uid));
        } on AuthException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<SignOut>(
      (event, emit) {
        try {
          userRepository.signOut();
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<SignUp>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userCredentials = await userRepository.signUp(
            event.email,
            event.password,
            event.firstName,
            event.lastName,
            event.phoneNumber,
            event.age,
          );
          add(GetUserInfo(userID: userCredentials.user!.uid));
        } on AuthException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<ResetPassword>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userRepository.resetPassword(event.email);
          emit(UserInitial());
        } on AuthException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<AddUserPhoneNumber>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userRepository.addPhoneNumber(event.phoneNumber, event.userID);
          emit(UserInitial());
          add(GetUserInfo(userID: event.userID));
        } on FirestoreException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<AddUserImage>(
      (event, emit) async {
        try {
          userRepository.addImage(event.imageUrl, event.userID);
          add(GetUserInfo(userID: event.userID));
        } on FirestoreException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<GetUserInfo>(
      (event, emit) async {
        try {
          emit(UserLoading());
          final userInfo = await userRepository.getUserInfo(event.userID);
          final userCars = await userRepository.getUserCars(event.userID);
          emit(UserLoaded(userInfo: userInfo!, cars: userCars));
        } on FirestoreException catch (e) {
          emit(UserError(errorMessage: e.message));
        } on NetworkException catch (e) {
          emit(UserError(errorMessage: e.message));
        } catch (e) {
          emit(const UserError(errorMessage: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );
  }
}
