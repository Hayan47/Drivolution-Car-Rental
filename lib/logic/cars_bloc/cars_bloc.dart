import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/cars_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final carServices = CarServices();
  List<Car> cars = [];
  CarsBloc() : super(CarsInitial()) {
    on<GetAllCarsEvent>((event, emit) async {
      try {
        emit(CarsLoading());
        print(state);
        cars = await carServices.getAllCars();
        emit(CarsLoaded(cars));
        print(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        print(state);
      }
    });

    on<AddCarEvent>((event, emit) async {
      try {
        emit(CarsLoading());
        await carServices.addCar(event.car);
        emit(const CarAdded('Car Added Successfully'));
        add(GetAllCarsEvent());
        print(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        print(state);
      }
    });

    on<DeleteCarEvent>((event, emit) async {
      try {
        await carServices.deleteCar(event.car);
        emit(const CarDeleted('Car Deleted Successfully'));
        add(GetAllCarsEvent());
        print(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        print(state);
      }
    });

    on<SearchForCarEvent>((event, emit) {
      List<Car> searchedForCars = cars
          .where((car) => car.name.toLowerCase().contains(event.text))
          .toList();
      emit(CarSearching(searchedForCars: searchedForCars));
      print(state);
    });

    on<CloseSearchForCarEvent>((event, emit) {
      emit(CarsLoaded(cars));
      print(state);
    });

    on<GetCarInfo>((event, emit) async {
      try {
        final car = await carServices.getCarInfo(event.carID);
        if (car != null) {
          emit(CarLoaded(car));
        }
        print(state);
      } catch (e) {
        emit(const CarsError('Car Not Found'));
        print(state);
      }
    });
  }
}
