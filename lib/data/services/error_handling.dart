import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class ErrorHandling {
  //?show error
  showError(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      color: MyColors.myred,
      icon: const Icon(Icons.error, color: Colors.white, size: 18),
      title: 'Error',
      message: message,
      margin: 5,
    ));
  }
}
