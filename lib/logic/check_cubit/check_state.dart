part of 'check_cubit.dart';

sealed class CheckState extends Equatable {
  const CheckState();

  @override
  List<Object> get props => [];
}

final class PageControllerInitial extends CheckState {}

final class Valid extends CheckState {}

final class NotValid extends CheckState {
  final String message;
  final DateTime dateTime;

  const NotValid({required this.message, required this.dateTime});

  @override
  List<Object> get props => [message, dateTime];
}
