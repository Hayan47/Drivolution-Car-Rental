import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/cars_services.dart';

class CarRepository {
  final CarServices carServices;

  CarRepository({required this.carServices});

  Future<List<Car>> getAllCars() async {
    try {
      return await carServices.getAllCars();
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> addCar(Car car) async {
    try {
      await carServices.addCar(car);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  Future<void> deleteCar(Car car) async {
    try {
      await carServices.deleteCar(car);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }

  List<Car> searchForCars(List<Car> cars, String text) {
    List<Car> searchedForCars =
        cars.where((car) => car.name.toLowerCase().contains(text)).toList();
    return searchedForCars;
  }

  Future<List<Car>> getCarsInfo(List<String> carIDs) async {
    try {
      return await carServices.getCarsInfo(carIDs);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirebaseException(e);
    } catch (e) {
      throw NetworkException.connectionFailed();
    }
  }
}
