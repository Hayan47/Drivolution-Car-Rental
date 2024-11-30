import 'package:drivolution/data/exceptions/firestore_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/models/notification_model.dart';
import 'package:drivolution/data/repositories/notification_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final logger = LoggerService().getLogger('Notifications Bloc Logger');
  final NotificationRepository notificationRepository;
  List<Notification> notifications = [];
  NotificationsBloc({required this.notificationRepository})
      : super(NotificationsInitial()) {
    FirebaseMessaging.onMessage.listen((message) {
      add(GetUserNotifications(userID: message.data['ownerID']));
    });

    on<GetUserNotifications>((event, emit) async {
      try {
        emit(NotificationsLoading());
        notifications =
            await notificationRepository.getUserNotifications(event.userID);
        emit(NotificationsLoaded(notifications: notifications));
      } on FirestoreException catch (e) {
        emit(NotificationsError(message: e.message));
      } on NetworkException catch (e) {
        emit(NotificationsError(message: e.message));
      } catch (e) {
        emit(NotificationsError(message: 'An unexpected error occurred'));
        logger.severe(e);
      }
    });
  }
}
