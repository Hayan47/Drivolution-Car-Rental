import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/user_image_cubit/user_image_cubit.dart';
import 'package:drivolution/presentation/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../profile_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<UserImageCubit>()),
            ],
            child: const ProfileDetailsScreen(),
          );
        } else {
          return LoginWidget();
        }
      },
    );
  }
}
