import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/repositories/car_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final logger = LoggerService().getLogger('Car Bloc Logger');
  final CarRepository  carRepository;
  List<Car> cars = [];
  CarsBloc({required this.carRepository}) : super(CarsInitial()) {
    on<GetAllCarsEvent>((event, emit) async {
      try {
        emit(CarsLoading());
        logger.info(state);
        cars = await carRepository.getAllCars();
        emit(CarsLoaded(cars));
        logger.info(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        logger.info(state);
        logger.severe(e);
      }
    });

    on<AddCarEvent>((event, emit) async {
      try {
        emit(CarsLoading());
        await carRepository.addCar(event.car);
        emit(const CarAdded('Car Added Successfully'));
        add(GetAllCarsEvent());
        logger.info(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        logger.info(state);
        logger.severe(e);
      }
    });

    on<DeleteCarEvent>((event, emit) async {
      try {
        await carRepository.deleteCar(event.car);
        emit(const CarDeleted('Car Deleted Successfully'));
        add(GetAllCarsEvent());
        logger.info(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        logger.info(state);
        logger.severe(e);
      }
    });

    on<SearchForCarEvent>((event, emit) {
      List<Car> searchedForCars = carRepository.searchForCars(cars, event.text);
      emit(CarSearching(searchedForCars: searchedForCars));
      logger.info(state);
    });

    on<CloseSearchForCarEvent>((event, emit) {
      emit(CarsLoaded(cars));
      logger.info(state);
    });

    on<GetCarsInfo>((event, emit) async {
      try {
        final cars = await carRepository.getCarsInfo(event.carIDs);
        emit(CarsLoaded(cars));
        logger.info(state);
      } catch (e) {
        emit(const CarsError('Cars Not Found'));
        logger.info(state);
        logger.severe(e);
      }
    });
  }
}
