import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showToastMessage(
  BuildContext context,
  String message,
  Icon icon,
) {
  showToastWidget(
    Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.charcoal,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.pureWhite,
              ),
            ),
          ),
        ],
      ),
    ),
    context: context,
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    position: const StyledToastPosition(
      offset: 100,
      align: Alignment.bottomCenter,
    ),
    animDuration: const Duration(milliseconds: 400),
    duration: const Duration(seconds: 4),
    curve: Curves.linear,
    reverseCurve: Curves.linear,
    dismissOtherToast: true,
    isHideKeyboard: true,
  );
}
