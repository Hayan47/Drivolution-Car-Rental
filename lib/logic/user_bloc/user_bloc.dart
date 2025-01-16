import 'dart:io';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/models/user_model.dart';
import 'package:drivolution/data/repositories/user_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    final logger = LoggerService().getLogger('User Bloc Logger');

    on<SignIn>(
      (event, emit) async {
        try {
          emit(UserLoading());
          final User user =
              await userRepository.loginUser(event.email, event.password);
          logger.info(state);
          emit(UserLoaded(userInfo: user, cars: []));
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );

    on<SignOut>(
      (event, emit) async {
        try {
          await userRepository.signOut();
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );

    on<SignUp>(
      (event, emit) async {
        try {
          emit(UserLoading());
          final User user = await userRepository.registerUser(
            event.email,
            event.password,
            event.firstName,
            event.lastName,
            event.phoneNumber,
          );
          emit(UserLoaded(userInfo: user, cars: []));
          logger.info(state);
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );

    on<ResetPassword>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userRepository.resetPassword(event.email);
          emit(UserInitial());
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );

    on<AddUserPhoneNumber>(
      (event, emit) async {
        try {
          emit(UserLoading());
          userRepository.addPhoneNumber(event.phoneNumber, event.userid);
          emit(UserInitial());
          add(GetUserInfo());
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );

    on<AddUserImage>(
      (event, emit) async {
        try {
          await userRepository.addImage(event.image, event.userid);
          add(GetUserInfo());
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );

    on<GetUserInfo>(
      (event, emit) async {
        try {
          emit(UserLoading());
          logger.info(state);
          final userInfo = await userRepository.getUserInfo();
          final userCars = await userRepository.getUserCars();
          emit(UserLoaded(userInfo: userInfo, cars: userCars));
          logger.info(userInfo);
          logger.info(state);
        } catch (e) {
          emit(UserError(errorMessage: e.toString()));
          logger.severe(e);
          logger.severe(state);
        }
      },
    );
  }
}
