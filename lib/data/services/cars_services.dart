import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';

class CarServices {
  final FirebaseFirestore firebaseFirestore;

  CarServices({required this.firebaseFirestore});

  //?get all cars
  Future<List<Car>> getAllCars() async {
    List<Car> cars = [];
    var snapshot = await firebaseFirestore
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
  }

  //?add car
  Future<void> addCar(Car car) async {
    await firebaseFirestore
        .collection('cars')
        .withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (car, options) => car.toFirestore(),
        )
        .add(car);
  }

  //?delete car
  Future<void> deleteCar(Car car) async {
    await firebaseFirestore
        .collection('deletedCars')
        .withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (car, options) => car.toFirestore(),
        )
        .add(car);
    await firebaseFirestore
        .collection('cars')
        .withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (car, options) => car.toFirestore(),
        )
        .doc(car.id)
        .delete();
  }

  //?get car info
  Future<List<Car>> getCarsInfo(List<String> carIDs) async {
    List<Car> reservationCars = [];
    var snapshot = await firebaseFirestore
        .collection('cars')
        .where(FieldPath.documentId, whereIn: carIDs)
        .withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (car, options) => car.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var car = doc.data();
      reservationCars.add(car);
    }
    return reservationCars;
  }
}
