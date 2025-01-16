part of 'car_owner_bloc.dart';

sealed class CarOwnerEvent extends Equatable {
  const CarOwnerEvent();

  @override
  List<Object> get props => [];
}

class GetCarOwnerInfo extends CarOwnerEvent {
  final String userid;

  const GetCarOwnerInfo({required this.userid});

  @override
  List<Object> get props => [userid];
}
