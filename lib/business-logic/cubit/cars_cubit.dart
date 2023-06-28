// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:drivolution/data/repository/cars_repository.dart';
import '../../data/models/car_model.dart';
part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  final CarsRepository carsRepository;
  List<Car> cars = [];

  CarsCubit(this.carsRepository) : super(CarsInitial());

  List<Car> getAllCars() {
    carsRepository.getAllCars().then((cars) {
      emit(CarsLoaded(cars));
      this.cars = cars;
    });
    return cars;
  }
}
