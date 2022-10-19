import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const String routeName = '/settings'; 

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Settings'),
      );
  }
}