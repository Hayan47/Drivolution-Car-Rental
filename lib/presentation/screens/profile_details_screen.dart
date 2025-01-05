import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/shimmer_profile.dart';
import 'package:drivolution/presentation/widgets/user_image.dart';
import 'package:drivolution/presentation/widgets/user_name_and_phone.dart';
import 'package:drivolution/presentation/widgets/user_profile_menu.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return ResponsiveWidget(
            //! MOBILE LAYOUT
            mobile: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: ResponsiveHelper.hp(context, 32),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Stack(
                      //! User Name + Phone
                      children: [
                        Container(
                          height: ResponsiveHelper.hp(context, 32) * 0.15,
                          color: Colors.black38,
                        ),
                        Positioned(
                          top: 0,
                          child: UserNameAndPhone(
                            username: userState.userInfo.username,
                            phoneNumber: userState.userInfo.phoneNumber,
                            userid: userState.userInfo.id!,
                          ),
                        ),
                      ],
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsets.zero,
                    //! User Image
                    background: UserImage(
                      img: userState.userInfo.profilePicture,
                      userid: userState.userInfo.id!,
                    ),
                  ),
                  actions: [
                    ChangeUserImageIcon(
                      email: userState.userInfo.email,
                    ),
                  ],
                ),
                //! User Menu
                SliverToBoxAdapter(
                  child: UserProfileMenu(
                    userid: userState.userInfo.id!,
                  ),
                ),
              ],
            ),
            //! TABLET LAYOUT
            tablet: SafeArea(
              child: Row(
                children: [
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: ResponsiveHelper.wp(context, 35),
                          maxWidth: ResponsiveHelper.wp(context, 35),
                        ),
                        child: Stack(
                          children: [
                            //! User Image
                            ClipRRect(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(12),
                              ),
                              child: UserImage(
                                img: userState.userInfo.profilePicture,
                                userid: userState.userInfo.id!,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: ChangeUserImageIcon(
                                email: userState.userInfo.email,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //! User Name + Phone
                      UserNameAndPhone(
                        username: userState.userInfo.username,
                        phoneNumber: userState.userInfo.phoneNumber,
                        userid: userState.userInfo.id!,
                      ),
                    ],
                  ),
                  //! User Menu
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: UserProfileMenu(
                        userid: userState.userInfo.id!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const ProfileLoading();
        }
      },
    );
  }
}
