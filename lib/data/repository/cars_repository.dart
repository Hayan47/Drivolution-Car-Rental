import 'package:drivolution/data/web_services/cars_web_services.dart';

import '../models/car_model.dart';

class CarsRepository {
  final CarsWebServices carsWebServices;

  CarsRepository(this.carsWebServices);

  Future<List<Car>> getAllCars() async {
    final cars = await carsWebServices.getAllCars();
    //print('AllCarsListReposi');
    //print(cars.toList());
    return cars.map((car) => Car.fromJson(car)).toList();
  }
}
