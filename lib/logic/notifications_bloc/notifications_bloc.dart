import 'package:drivolution/data/models/notification_model.dart';
import 'package:drivolution/data/services/notifications_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final notificationServices = FirebaseNotifications();
  List<Notification> notifications = [];
  NotificationsBloc() : super(NotificationsInitial()) {
    FirebaseMessaging.onMessage.listen((message) {
      // emit(NotificationsLoaded(notifications: notifications));
      add(GetUserNotifications(userID: message.data['ownerID']));
    });
    on<GetUserNotifications>((event, emit) async {
      try {
        emit(NotificationsLoading());
        print(state);
        notifications =
            await notificationServices.getUserNotifications(event.userID);
        emit(NotificationsLoaded(notifications: notifications));
        print(state);
      } catch (e) {
        emit(const NotificationsError(message: 'Error Fetching Notifications'));
        print(state);
      }
    });
  }
}