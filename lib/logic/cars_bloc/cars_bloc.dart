import 'package:bloc/bloc.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/data/services/cars_services.dart';
import 'package:equatable/equatable.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(CarsInitial()) {
    on<GetAllCarsEvent>((event, emit) async {
      try {
        emit(CarsLoading());
        print(state);
        await CarServices().getAllCars().then((cars) {
          emit(CarsLoaded(cars));
          print(state);
        });
      } catch (e) {
        emit(CarsError(e.toString()));
        print(state);
      }
    });

    on<AddCarEvent>((event, emit) async {
      try {
        emit(CarsLoading());
        await CarServices().addCar(event.car);
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
        await CarServices().deleteCar(event.car);
        emit(const CarDeleted('Car Deleted Successfully'));
        add(GetAllCarsEvent());
        print(state);
      } catch (e) {
        emit(CarsError(e.toString()));
        print(state);
      }
    });
  }
}
