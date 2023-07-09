import 'package:bloc/bloc.dart';
import 'package:drivolution/services/auth.dart';
import 'package:meta/meta.dart';

import '../../data/models/usr_model.dart';

part 'usr_state.dart';

class UsrCubit extends Cubit<UsrState> {
  UsrCubit() : super(UsrInitial());

  Future<void> getUserInfo(String userID) async {
    try {
      final userInfo = await Auth().getUserInfo(userID);
      emit(UsrLoaded(userInfo!));
    } catch (e) {
      emit(UsrError('Failed to load user information'));
    }
  }
}
