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
    return Scaffold(
        //app bar
        appBar: AppBar(
          title: Text(
            'Settings',
          ),
        ),
        //body
        body: ListView(
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    currentTheme.toggleTheme();
                  },
                  icon: Icon(
                    Icons.toggle_off_outlined,
                    color: MyColors.myred,
                  )),
              title: Text('Change Theme'),
            )
          ],
        ));
  }
}
