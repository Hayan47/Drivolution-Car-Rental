import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/presentation/widgets/add_car_widget.dart';
import 'package:drivolution/presentation/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is NotAuthenticated) {
          return LoginWidget();
        } else {
          return AddCarWidget(uid: (state as Authenticated).user.uid);
        }
      },
    );
  }
}
