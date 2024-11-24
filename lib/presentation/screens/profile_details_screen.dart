import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/logic/user_image_cubit/user_image_cubit.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/add_phone_number.dart';
import 'package:drivolution/presentation/widgets/alert_dialog.dart';
import 'package:drivolution/presentation/widgets/shimmer_profile.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.sizeOf(context).height * 0.32,
                flexibleSpace: FlexibleSpaceBar(
                  title: Stack(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.32 * 0.15,
                        color: Colors.black38,
                      ),
                      Positioned(
                        top: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                '${userState.userInfo.firstName} ${userState.userInfo.lastName}',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.pureWhite,
                                  fontSize: 0.4 *
                                      MediaQuery.sizeOf(context).height *
                                      0.32 *
                                      0.15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.call,
                                    size: 12,
                                    color: AppColors.successGreen,
                                  ),
                                  const SizedBox(width: 5),
                                  userState.userInfo.phoneNumber == ""
                                      ? GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              barrierColor: Colors.transparent,
                                              context: context,
                                              builder: (_) {
                                                return BlocProvider.value(
                                                  value:
                                                      BlocProvider.of<UserBloc>(
                                                          context),
                                                  child: AddPhoneNumber(
                                                      id: userState
                                                          .userInfo.userid),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Add Phone Number',
                                            style: AppTypography.labelLarge
                                                .copyWith(
                                              color: AppColors.pureWhite,
                                              fontSize: 0.3 *
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.32 *
                                                  0.15,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          userState.userInfo.phoneNumber,
                                          style:
                                              AppTypography.labelLarge.copyWith(
                                            color: AppColors.pureWhite,
                                            fontSize: 10,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  centerTitle: false,
                  titlePadding: EdgeInsets.zero,
                  background: BlocConsumer<UserImageCubit, UserImageState>(
                    listener: (context, state) {
                      if (state is UserImageChanged) {
                        context.read<UserBloc>().add(AddUserImage(
                            imageUrl: state.imageUrl,
                            userID: userState.userInfo.userid));
                        showToastMessage(
                          context,
                          state.message,
                          const Icon(Icons.done,
                              color: AppColors.successGreen, size: 18),
                        );
                      } else if (state is UserImageError) {
                        showToastMessage(
                          context,
                          state.message,
                          const Icon(Icons.error,
                              color: AppColors.alertRed, size: 18),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is UserImageLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.coralRed),
                        );
                      } else {
                        return CachedNetworkImage(
                          imageUrl: (userState.userInfo.img != null)
                              ? userState.userInfo.img!
                              : 'https://i.imgur.com/sWmIhUZ.png',
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<UserImageCubit>()
                          .pickUserImage(userState.userInfo.email);
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    //! My Cars
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, 'mycarsscreen',
                              arguments: userState.userInfo.userid);
                        },
                        leading: const Icon(
                          FontAwesomeIcons.car,
                          color: Colors.white,
                        ),
                        title: Text(
                          'My Cars',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //! My Reservations
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, 'myreservationsscreen',
                              arguments: userState.userInfo.userid);
                        },
                        leading: const Icon(
                          Icons.library_books_rounded,
                          color: Colors.white,
                        ),
                        title: Text(
                          'My Reservations',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite,
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //! sign out
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                              value: context.read<UserBloc>(),
                              child: MyAlertDialog(
                                  onPressed: () {
                                    context.read<UserBloc>().add(SignOut());
                                    Navigator.pop(context);
                                  },
                                  text: 'Are you sure you want to sign out?'),
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.coralRed),
                      ),
                      child: Text(
                        'Sign out',
                        style: AppTypography.h4.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const ProfileLoading();
        }
      },
    );
  }
}
