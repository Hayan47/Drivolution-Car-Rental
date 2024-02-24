part of 'doors_bloc.dart';

sealed class DoorsEvent extends Equatable {
  const DoorsEvent();

  @override
  List<Object> get props => [];
}

class SelectDoorsNumberEvent extends DoorsEvent {
  final int selectedNumber;

  const SelectDoorsNumberEvent(this.selectedNumber);
}
