import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hint;
  final String initialValue;
  final TextInputType inputType;
  final TextInputAction actionType;
  final void Function(String)? onChanged;

  const MyTextField({
    super.key,
    required this.hint,
    required this.initialValue,
    required this.inputType,
    required this.actionType,
    this.onChanged,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(MyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.initialValue.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 44,
        width: MediaQuery.sizeOf(context).width * 0.4,
        decoration: BoxDecoration(
          color: AppColors.steelGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.pureWhite,
            width: 0.4,
          ),
        ),
        child: SingleChildScrollView(
          child: TextField(
            onChanged: widget.onChanged,
            maxLines: null,
            textAlign: TextAlign.center,
            style:
                AppTypography.labelLarge.copyWith(color: AppColors.pureWhite),
            controller: _controller,
            decoration: InputDecoration(
              //!hint style
              hintStyle: AppTypography.labelMedium
                  .copyWith(color: AppColors.pureWhite.withOpacity(0.5)),
              //!1 enabled border
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(
              //     color: AppColors.pureWhite,
              //     width: 0.2,
              //   ),
              // ),
              //!2 focused border
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(
              //     color: Colors.blue,
              //     width: 1,
              //   ),
              // ),
              //!hint
              hintText: widget.hint,
              // floatingLabelStyle: const TextStyle(color: AppColors.deepNavy),
              labelStyle:
                  AppTypography.labelLarge.copyWith(color: AppColors.pureWhite),
              floatingLabelAlignment: FloatingLabelAlignment.start,
            ),
            cursorHeight: 18,
            keyboardType: widget.inputType,
            textInputAction: widget.actionType,
          ),
        ),
      ),
    );
  }
}
