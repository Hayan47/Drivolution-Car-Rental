import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/notifications_bloc/notifications_bloc.dart';
import 'package:drivolution/presentation/widgets/notifications_item.dart';
import 'package:drivolution/presentation/widgets/shimmer_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

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
                      // Image.asset('assets/lottie/notifications.png'),
                      const SizedBox(height: 10),
                      Text(
                        'You have no notifications yet',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.myBlue,
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
                    backgroundColor: MyColors.mywhite,
                    child: ListView.builder(
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        if (index == state.notifications.length - 1) {
                          //? Return the last item with some padding
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 70),
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    child: Lottie.asset('assets/lottie/register.zip'),
                  ),
                  Text(
                    'Make Your Account Now!',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 26,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, 'loginscreen');
                  },
                  backgroundColor: MyColors.myBlue,
                  label: const Text("log in"),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
