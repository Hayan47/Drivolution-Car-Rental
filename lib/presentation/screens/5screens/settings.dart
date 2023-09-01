import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/themes.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff1E1E24),
            Color(0xff243B55),
            Color(0xff1E1E24),
          ],
        ),
      ),
      child: ListView(
        children: [
          AppBar(
            title: Row(
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                const Text(
                  'Settings',
                ),
              ],
            ),
          ),
          ListTile(
            leading: IconButton(
                onPressed: () {
                  currentTheme.toggleTheme();
                },
                icon: const Icon(
                  Icons.toggle_off_outlined,
                  color: MyColors.myred,
                )),
            title: Text(
              'Change Theme',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                    fontSize: 18,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.transparent,
                builder: (context) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: ClipRRect(
                      child: Container(
                        height: 200,
                        color: MyColors.mywhite,
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: MyColors.myred2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Material(
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                      ),
                                  // controller: _phonecontroller,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.length < 10) {
                                      return 'phone number is short';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Phone...',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Container(
              height: 100,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
