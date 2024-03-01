// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';

import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/services/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPhoneNumber extends StatefulWidget {
  final String id;
  const AddPhoneNumber({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AddPhoneNumber> createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserInitial) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar(
              icon: const Icon(Icons.done, color: Colors.green, size: 18),
              message: 'Phone Number has been added',
              margin: 70,
            ),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: MyColors.myred2,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SizedBox(
            height: 120,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Add Your Number',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MyColors.mywhite,
                          fontSize: 19,
                        ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: MyColors.myBlue2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                            ),
                        controller: _phoneController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number...',
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: GestureDetector(
                onTap: () async {
                  context.read<UserBloc>().add(
                        AddUserPhoneNumber(
                            phoneNumber: _phoneController.text,
                            userID: widget.id),
                      );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.myBlue2,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: MyColors.myGrey,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'submit',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: MyColors.mywhite,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
