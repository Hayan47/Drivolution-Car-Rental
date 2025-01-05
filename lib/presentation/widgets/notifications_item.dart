import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppColors.deepNavy,
        child: ListTile(
          title: Row(
            children: [
              const Icon(
                IconlyLight.notification,
                color: AppColors.coralRed,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                'notification.title',
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.coralRed,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'notification.body',
                style: AppTypography.bodyLarge.copyWith(color: AppColors.pearl),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    IconlyLight.time_circle,
                    color: AppColors.pureWhite.withOpacity(0.4),
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '',
                    // DateFormat('EEE, MMM d, yyyy, hh:mm a')
                    //     .format(notification.timestamp.toDate()),
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.pearl,
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
