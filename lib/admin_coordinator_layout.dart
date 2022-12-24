import 'package:flutter/material.dart';
import 'package:flutter_press/admin_app.dart';
import 'package:flutter_press/admin_navigator_app.dart';

class AdminLayoutCoordinator extends StatefulWidget {
  final AdminNavigatorApp navigatorWidget;
  final AdminApp content;
  const AdminLayoutCoordinator({
    Key? key,
    required this.navigatorWidget,
    required this.content,
  }) : super(key: key);

  @override
  State<AdminLayoutCoordinator> createState() => _AdminLayoutCoordinatorState();
}

class _AdminLayoutCoordinatorState extends State<AdminLayoutCoordinator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.navigatorWidget,
        Expanded(child: widget.content),
      ],
    );
  }
}
