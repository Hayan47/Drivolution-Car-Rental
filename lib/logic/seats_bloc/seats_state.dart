part of 'seats_bloc.dart';

class SeatsState extends Equatable {
  final int selectedNumber;

  const SeatsState(this.selectedNumber);

  @override
  List<Object> get props => [selectedNumber];
}
