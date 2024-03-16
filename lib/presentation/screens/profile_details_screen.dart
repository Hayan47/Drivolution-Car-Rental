import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/upload_bloc/upload_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/add_phone_number.dart';
import 'package:drivolution/presentation/widgets/alert_dialog.dart';
import 'package:drivolution/presentation/widgets/shimmer_profile.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/my_colors.dart';

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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.mywhite,
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
                                    color: Colors.green,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyColors.mywhite,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: MyColors.mywhite,
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
                  background: BlocListener<ImageBloc, ImageState>(
                    listener: (context, state) {
                      if (state is ImageChanged) {
                        context.read<UploadBloc>().add(
                              UploadImagesEvent(
                                images: [state.image],
                                path:
                                    'profile pictures/${userState.userInfo.email}',
                              ),
                            );
                      }
                    },
                    child: BlocConsumer<UploadBloc, UploadState>(
                      listener: (context, state) {
                        if (state is UploadFailedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            MySnackBar(
                              icon: const Icon(Icons.error,
                                  color: MyColors.myred2, size: 18),
                              message: state.message,
                              margin: 70,
                            ),
                          );
                        } else if (state is UploadSuccessState) {
                          context.read<UserBloc>().add(AddUserImage(
                              imageUrl: state.imageUrls.first,
                              userID: userState.userInfo.userid));
                          ScaffoldMessenger.of(context).showSnackBar(
                            MySnackBar(
                              icon: const Icon(Icons.done,
                                  color: Colors.green, size: 18),
                              message: state.message,
                              margin: 70,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is UploadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: MyColors.myred2),
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
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<ImageBloc>()
                          .add(const AddImageEvent(removeBackground: false));
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
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
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
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
                            MaterialStateProperty.all(MyColors.myred2),
                      ),
                      child: Text(
                        'Sign out',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: MyColors.mywhite,
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
