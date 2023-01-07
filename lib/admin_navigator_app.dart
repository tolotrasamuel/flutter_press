import 'package:flutter/material.dart';
import 'package:flutter_press/widgets/navigation_item.dart';

class AdminNavigatorApp extends StatefulWidget {
  AdminNavigatorApp({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminNavigatorApp> createState() => AdminNavigatorAppState();
}

class AdminNavigatorAppState extends State<AdminNavigatorApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              // color: 23282D,
              color: Color(0xFF23282D),

              child: Column(
                children: <Widget>[
                  NavigationItem(
                    icon: Icons.push_pin_outlined,
                    text: 'Post',
                    children: [
                      "All Posts",
                      "Add New",
                      "Categories",
                      "Tags",
                    ],
                  ),
                  NavigationItem(
                    icon: Icons.copy_all,
                    text: 'Pages',
                  ),
                  NavigationItem(
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                  NavigationItem(
                    icon: Icons.format_paint,
                    text: 'Admin',
                  ),
                  NavigationItem(
                    icon: Icons.arrow_circle_left,
                    text: "Collapse menu",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setCurrentlySelected(String text) {}
}
