// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:drivolution/services/cars_services.dart';
import 'package:meta/meta.dart';
import '../../data/models/car_model.dart';
part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  List<Car> cars = [];

  CarsCubit() : super(CarsInitial());

  //! get cars
  List<Car> getAllCars() {
    CarServices().getAllCars().then((cars) {
      emit(CarsLoaded(cars));
      this.cars = cars;
    });
    return cars;
  }

  //! add car
  Future<void> addCar(Car car) async {
    await CarServices().addCar(car);
    // emit(CarsLoaded(cars));
  }
}
