// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/services/user_services.dart';

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
    return AlertDialog(
      backgroundColor: MyColors.mywhite,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Container(
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
                      color: MyColors.myred,
                      fontSize: 19,
                    ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: MyColors.myred2,
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
              await UserServices()
                  .addPhoneNumber(_phoneController.text, widget.id, context);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.myred2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: const Color.fromARGB(255, 36, 114, 121), width: 2),
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
  }
}
