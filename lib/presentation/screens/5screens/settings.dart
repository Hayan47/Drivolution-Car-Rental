import 'package:drivolution/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Sign OUt'),
        ),
        TextButton(
            onPressed: () {
              AppRouter().disposeAddCarBlocs();
              print('Disposed');
            },
            child: const Text('Clear Bloc'))
      ],
    );
  }
}
