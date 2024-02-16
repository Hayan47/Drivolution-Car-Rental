import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class ErrorHandling {
  //?show error
  showError(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      MySnackBar(
        icon: const Icon(Icons.error, color: MyColors.myred2, size: 18),
        message: message,
        margin: 0,
      ),
    );
  }
}
