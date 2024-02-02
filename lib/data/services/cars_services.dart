import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/error_handling.dart';

class CarServices {
  final _store = FirebaseFirestore.instance;
  final ErrorHandling _errorHandling = ErrorHandling();

  //?get all cars
  Future<List<Car>> getAllCars() async {
    try {
      List<Car> cars = [];
      var snapshot = await _store
          .collection('cars')
          .withConverter<Car>(
            fromFirestore: Car.fromFirestore,
            toFirestore: (car, options) => car.toFirestore(),
          )
          .get();

      for (var doc in snapshot.docs) {
        var car = doc.data();
        cars.add(car);
      }
      return cars;
    } catch (e) {
      return [];
    }
  }

  //?add car
  Future<void> addCar(Car car) async {
    try {
      await _store
          .collection('cars')
          .withConverter<Car>(
            fromFirestore: Car.fromFirestore,
            toFirestore: (car, options) => car.toFirestore(),
          )
          .add(car);
    } catch (e) {
      print(e);
    }
  }

  //?delete car
  Future<void> deleteCar(Car car) async {
    try {
      await _store
          .collection('deletedCars')
          .withConverter<Car>(
            fromFirestore: Car.fromFirestore,
            toFirestore: (car, options) => car.toFirestore(),
          )
          .add(car);
      await _store
          .collection('cars')
          .withConverter<Car>(
            fromFirestore: Car.fromFirestore,
            toFirestore: (car, options) => car.toFirestore(),
          )
          .doc(car.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
