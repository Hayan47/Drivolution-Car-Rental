part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetUserNotifications extends NotificationsEvent {
  final String userID;

  const GetUserNotifications({required this.userID});
}
