import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';

class CarServices {
  final _store = FirebaseFirestore.instance;

  //?get all cars
  Future<List<Car>> getAllCars() async {
    print("HAYANNNNNNNNNNNNNNNNNNN");
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
}
