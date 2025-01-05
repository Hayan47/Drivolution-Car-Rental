import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/logic/user_image_cubit/user_image_cubit.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserImage extends StatelessWidget {
  final String? img;
  final int userid;
  const UserImage({
    super.key,
    required this.img,
    required this.userid,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserImageCubit, UserImageState>(
      listener: (context, state) {
        if (state is UserImageChanged) {
          context
              .read<UserBloc>()
              .add(AddUserImage(image: state.image, userid: userid));
          showToastMessage(
            context,
            state.message,
            const Icon(Icons.done, color: AppColors.successGreen, size: 18),
          );
        } else if (state is UserImageError) {
          showToastMessage(
            context,
            state.message,
            const Icon(Icons.error, color: AppColors.alertRed, size: 18),
          );
        }
      },
      builder: (context, state) {
        if (state is UserImageLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.coralRed),
          );
        } else {
          return CachedNetworkImage(
            imageUrl: img ?? 'https://i.imgur.com/sWmIhUZ.png',
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}

class ChangeUserImageIcon extends StatelessWidget {
  final String email;
  const ChangeUserImageIcon({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<UserImageCubit>().pickUserImage(email);
      },
      icon: const Icon(
        Icons.edit,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
