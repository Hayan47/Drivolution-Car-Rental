part of 'doors_bloc.dart';

class DoorsState extends Equatable {
  final int selectedNumber;

  const DoorsState(this.selectedNumber);

  @override
  List<Object> get props => [selectedNumber];
}
