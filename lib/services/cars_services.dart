import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/models/car_model.dart';

class CarServices {
  final _store = FirebaseFirestore.instance;

  Future<List<Car>> getAllCars() async {
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
    print(cars[0].interiorColor);
    return cars;
  }
}
