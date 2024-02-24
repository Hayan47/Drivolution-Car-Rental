part of 'seats_bloc.dart';

sealed class SeatsEvent extends Equatable {
  const SeatsEvent();

  @override
  List<Object> get props => [];
}

class SelectSeatsNumberEvent extends SeatsEvent {
  final int selectedNumber;

  const SelectSeatsNumberEvent(this.selectedNumber);
}
