part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCarsEvent extends CarsEvent {}

class AddCarEvent extends CarsEvent {
  final Car car;

  const AddCarEvent({required this.car});
}

class DeleteCarEvent extends CarsEvent {
  final Car car;

  const DeleteCarEvent({required this.car});
}

class SearchForCarEvent extends CarsEvent {
  final String text;

  const SearchForCarEvent({required this.text});
}

class CloseSearchForCarEvent extends CarsEvent {}

class GetCarInfo extends CarsEvent {
  final String carID;

  const GetCarInfo({required this.carID});
}
