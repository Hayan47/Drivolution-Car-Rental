part of 'cars_bloc.dart';

sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

class CarsInitial extends CarsState {}

class CarsLoading extends CarsState {}

class CarsLoaded extends CarsState {
  final List<Car> cars;

  const CarsLoaded(this.cars);
}

class CarsError extends CarsState {
  final String message;

  const CarsError(this.message);
}

class CarAdded extends CarsState {
  final String message;

  const CarAdded(this.message);
}

class CarDeleted extends CarsState {
  final String message;

  const CarDeleted(this.message);
}

class CarSearching extends CarsState {
  final List<Car> searchedForCars;

  const CarSearching({required this.searchedForCars});

  @override
  List<Object> get props => [searchedForCars];
}

class CarLoaded extends CarsState {
  final Car car;

  const CarLoaded(this.car);
}
