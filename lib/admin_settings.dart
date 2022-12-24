import 'package:flutter/material.dart';
import 'package:flutter_press/admin_layout.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key? key}) : super(key: key);

  @override
  State<AdminSettings> createState() => AdminSettingsState();
}

class AdminSettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Settings',
      child: Text('Settings'),
    );
  }
}
