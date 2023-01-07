import 'package:flutter/material.dart';
import 'package:flutter_press/admin_navigator_app.dart';
import 'package:flutter_press/constants.dart';

class AdminLayout extends StatefulWidget {
  final Widget child;
  const AdminLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xFF101517),
            height: 32,
          ),
          // line
          Container(
            height: 1,
            color: Colors.white,
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  child: AdminNavigatorApp(),
                  width: kNavigationWidth,
                ),
                Expanded(
                  child: Container(
                    child: widget.child,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
