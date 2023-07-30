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
            )
          ],
        ));
  }
}
