import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/data/models/notification_model.dart'
    as mynotification;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final mynotification.Notification notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: MyColors.myBlue2,
        child: ListTile(
          title: Row(
            children: [
              const Icon(
                IconlyLight.notification,
                color: MyColors.myred2,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                notification.title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.myred2,
                    ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.body,
                style: GoogleFonts.karla(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    IconlyLight.time_circle,
                    color: MyColors.mywhite.withOpacity(0.4),
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('EEE, MMM d, yyyy, hh:mm a')
                        .format(notification.timestamp.toDate()),
                    style: GoogleFonts.karla(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
