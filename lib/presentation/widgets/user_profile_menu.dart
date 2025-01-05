import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfileMenu extends StatelessWidget {
  final int userid;
  const UserProfileMenu({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! My Cars
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'mycarsscreen', arguments: userid);
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
                  arguments: userid);
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
                        context.read<AuthCubit>().emit(NotAuthenticated());
                      },
                      text: 'Are you sure you want to sign out?'),
                );
              },
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.coralRed),
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
    );
  }
}
