import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/notifications_bloc/notifications_bloc.dart';
import 'package:drivolution/presentation/widgets/login_widget.dart';
import 'package:drivolution/presentation/widgets/notifications_item.dart';
import 'package:drivolution/presentation/widgets/shimmer_notifications.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoaded) {
                if (state.notifications.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ConstrainedBox(
                      //     constraints: BoxConstraints(
                      //       maxHeight: ResponsiveHelper.hp(context, 40),
                      //     ),
                      //     child:
                      //         Image.asset('assets/lottie/notifications.png'),
                      // ),
                      const SizedBox(height: 10),
                      Text(
                        'You have no notifications yet',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.oceanBlue,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                } else {
                  return LiquidPullToRefresh(
                    onRefresh: () async {
                      //?get notifications
                      await Future.delayed(const Duration(seconds: 1));
                      context.read<NotificationsBloc>().add(
                          GetUserNotifications(userID: authState.user.uid));
                    },
                    animSpeedFactor: 1,
                    springAnimationDurationInMilliseconds: 100,
                    showChildOpacityTransition: false,
                    height: 200,
                    color: Colors.transparent,
                    backgroundColor: AppColors.oceanBlue,
                    child: ListView.builder(
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        if (index == state.notifications.length - 1) {
                          //? Return the last item with some padding
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    ResponsiveHelper.getScreenSize(context) ==
                                            ScreenSize.small
                                        ? 70
                                        : 10),
                            child: NotificationItem(
                                notification: state.notifications[index]),
                          );
                        } else {
                          return NotificationItem(
                              notification: state.notifications[index]);
                        }
                      },
                    ),
                  );
                }
              } else {
                return const Column(
                  children: [NotificationLoading()],
                );
              }
            },
          );
        } else {
          return LoginWidget();
        }
      },
    );
  }
}
