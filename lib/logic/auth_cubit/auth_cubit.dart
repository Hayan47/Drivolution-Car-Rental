import 'dart:async';

import 'package:drivolution/data/services/logger_service.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final logger = LoggerService().getLogger('Auth Cubit Logger');
  final UserServices userServices;
  late StreamSubscription authStreamSubscription;
  AuthCubit({required this.userServices}) : super(NotAuthenticated()) {
    authStreamSubscription =
        userServices.auth.authStateChanges().listen((user) {
      emit(user != null ? Authenticated(user: user) : NotAuthenticated());
      logger.info(state);
    });
  }

  @override
  Future<void> close() {
    authStreamSubscription.cancel();
    return super.close();
  }
}
