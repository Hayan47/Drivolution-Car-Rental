part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCarsEvent extends CarsEvent {}

// class AddCarEvent extends CarsEvent {
//   final Car car;
//
//   const AddCarEvent({required this.car});
// }

class DeleteCarEvent extends CarsEvent {
  final int carid;

  const DeleteCarEvent({required this.carid});
}

class SearchForCarEvent extends CarsEvent {
  final String text;

  const SearchForCarEvent({required this.text});
}

class CloseSearchForCarEvent extends CarsEvent {}

class GetCarsInfo extends CarsEvent {
  final List<String> carIDs;

  const GetCarsInfo({required this.carIDs});

  @override
  List<Object> get props => [carIDs];
}
