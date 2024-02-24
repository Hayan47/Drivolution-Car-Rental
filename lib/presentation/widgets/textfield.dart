// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import '../../constants/my_colors.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction actionType;

  const MyTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.actionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 44,
        width: MediaQuery.sizeOf(context).width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: MyColors.mywhite,
            width: 0.4,
          ),
        ),
        child: SingleChildScrollView(
          child: TextField(
            maxLines: null,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.mywhite,
                ),
            controller: controller,
            decoration: InputDecoration(
              //!hint style
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite.withOpacity(0.5),
                    fontSize: 14,
                  ),
              //!1 enabled border
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(
              //     color: MyColors.mywhite,
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
              hintText: hint,
              floatingLabelStyle: const TextStyle(color: MyColors.myBlue2),
              labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                  ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
            ),
            cursorHeight: 18,
            keyboardType: inputType,
            textInputAction: actionType,
          ),
        ),
      ),
    );
  }
}

class MyTextField2 extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final TextInputAction actionType;
  final TextFieldBloc bloc;

  const MyTextField2({
    Key? key,
    required this.hint,
    required this.inputType,
    required this.actionType,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.sizeOf(context).width * 0.45,
      decoration: BoxDecoration(
        color: MyColors.myGrey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: MyColors.mywhite,
          width: 0.4,
        ),
      ),
      child: SingleChildScrollView(
        child: TextFieldBlocBuilder(
          textColor: MaterialStateProperty.all(MyColors.mywhite),
          textStyle: Theme.of(context).textTheme.bodySmall,
          maxLines: null,
          textAlign: TextAlign.center,
          cursorColor: MyColors.mywhite,
          cursorRadius: const Radius.circular(50),
          cursorWidth: 1,
          clearTextIcon: const Icon(
            Icons.clear,
            color: MyColors.myBlue,
          ),
          suffixButton: SuffixButton.clearText,
          textFieldBloc: bloc,
          decoration: InputDecoration(
            //!hint style
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.mywhite.withOpacity(0.6),
                  fontSize: 14,
                ),
            border: InputBorder.none,
            //!hint
            hintText: hint,
          ),
          keyboardType: inputType,
          textInputAction: actionType,
        ),
      ),
    );
  }
}
