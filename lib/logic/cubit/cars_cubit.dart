// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:drivolution/data/services/cars_services.dart';
import 'package:meta/meta.dart';
import '../../data/models/car_model.dart';
part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  List<Car> cars = [];

  CarsCubit() : super(CarsInitial());

  //? get cars
  Future<List<Car>> getAllCars() async {
    try {
      await CarServices().getAllCars().then((cars) {
        emit(CarsLoaded(cars));
        this.cars = cars;
      });
      return cars;
    } catch (e) {
      emit(CarsError(e.toString()));
      return [];
    }
  }

  //? add car
  Future<void> addCar(Car car) async {
    await CarServices().addCar(car);
    // emit(CarsLoaded(cars));
  }

  //? delete car
  Future<void> deleteCar(Car car) async {
    await CarServices().deleteCar(car);
    // emit(CarsLoaded(cars));
  }
}
