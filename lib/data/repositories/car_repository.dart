import 'package:dio/dio.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/cars_service.dart';
import 'package:drivolution/data/services/logger_service.dart';

class CarRepository {
  final logger = LoggerService().getLogger("Car Repo Logger");
  final CarService carService;

  CarRepository({required this.carService});

  Future<List<Car>> getAllCars() async {
    try {
      List<Car> cars = [];
      final response = await carService.getAllCars();
      cars = response
          .map(
            (car) => Car.fromJson(car),
          )
          .toList();
      return cars;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<void> addCar(Car car) async {
    try {
      Map<String, dynamic> carData = car.toJson();
      await carService.addCar(carData, car.images, car.location);
    } on DioException catch (dioException) {
      // rethrow;
      // logger.severe("Dio Error");
      logger.severe(dioException.error);
      throw dioException.error!;
    }
  }

  Future<void> deleteCar(int carid) async {
    try {
      await carService.deleteCar(carid);
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  Future<List<Car>> searchForCars(String text) async {
    // List<Car> searchedForCars =
    //     cars.where((car) => car.name.toLowerCase().contains(text)).toList();
    // return searchedForCars;
    try {
      List<Car> cars = [];
      final response = await carService.searchForCars(text);
      cars = response
          .map(
            (car) => Car.fromJson(car),
          )
          .toList();
      return cars;
    } on DioException catch (dioException) {
      throw dioException.error!;
    }
  }

  // Future<List<Car>> getCarsInfo(List<String> carIDs) async {
  //   try {
  //     return await carService.getCarsInfo(carIDs);
  //   } catch (e) {
  //     throw NetworkException.connectionFailed();
  //   }
  // }
}
