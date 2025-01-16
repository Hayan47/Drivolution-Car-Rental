import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/data/repositories/user_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_owner_event.dart';
part 'car_owner_state.dart';

class CarOwnerBloc extends Bloc<CarOwnerEvent, CarOwnerState> {
  final logger = LoggerService().getLogger("Car Owner Bloc Logger");
  final UserRepository userRepository;
  CarOwnerBloc({required this.userRepository}) : super(CarOwnerInitial()) {
    on<GetCarOwnerInfo>(
      (event, emit) async {
        try {
          emit(CarOwnerLoading());
          final userInfo = await userRepository.getUserInfo(event.userid);
          emit(CarOwnerLoaded(userInfo: userInfo!));
        } on FirestoreException catch (e) {
          emit(CarOwnerError(message: e.message));
        } on NetworkException catch (e) {
          emit(CarOwnerError(message: e.message));
        } catch (e) {
          emit(const CarOwnerError(message: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );
  }
}
