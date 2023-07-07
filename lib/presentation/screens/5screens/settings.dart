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
          image: DecorationImage(
            image: AssetImage('assets/img/background2.jpg'),
            fit: BoxFit.fill,
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
              title: const Text(
                'Change Theme',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
