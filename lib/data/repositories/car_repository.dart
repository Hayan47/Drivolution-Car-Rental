import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/cars_services.dart';

class CarRepository {
  final CarServices carServices;

  CarRepository({required this.carServices});

  Future<List<Car>> getAllCars() async {
    return await carServices.getAllCars();
  }

  Future<void> addCar(Car car) async {
    await carServices.addCar(car);
  }

  Future<void> deleteCar(Car car) async {
    await carServices.deleteCar(car);
  }

  List<Car> searchForCars (List<Car> cars, String text) {
    List<Car> searchedForCars = cars
          .where((car) => car.name.toLowerCase().contains(text))
          .toList();
    return searchedForCars;
  }

  Future<List<Car>> getCarsInfo(List<String> carIDs) async {
    return await carServices.getCarsInfo(carIDs);
  }
}