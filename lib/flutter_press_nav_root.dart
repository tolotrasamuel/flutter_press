library flutter_press;

import 'package:flutter/material.dart';
import 'package:flutter_press/admin_post_list.dart';
import 'package:flutter_press/admin_post_new.dart';
import 'package:flutter_press/admin_settings.dart';
import 'package:flutter_press/services/navigator.dart';

class FlutterPressNavRoot extends StatefulWidget {
  const FlutterPressNavRoot({Key? key}) : super(key: key);

  @override
  State<FlutterPressNavRoot> createState() => _FlutterPressNavRootState();
}

class _FlutterPressNavRootState extends State<FlutterPressNavRoot> {
  late Widget currentWidget;
  bool initialized = false;
  @override
  void initState() {
    print("FlutterPressNavRoot.initState()");
    super.initState();

    NavigationService.instance.onChange((route) {
      setState(() {
        currentWidget = route;
      });
    });
    NavigationService.instance.registerRoutes(routes: {
      'Post': () => const AdminPostList(),
      'All Posts': () => const AdminPostList(),
      'Add New': () => const AdminPostNew(),
      'Settings': () => const AdminSettings(),
    }, initialRoute: 'All Posts');
    // final routes = [RouteItem(
    //   icon: Icons.push_pin_outlined,
    //   name: 'Post',
    //   builder: () => const AdminPost(),
    // ),
    // RouteItem(
    // icon: Icons.copy_all,
    // name: 'Pages',
    //   builder: () => const AdminPost(),
    //
    // ),
    // RouteItem(
    // icon: Icons.settings,
    // name: 'Settings',
    //   builder: () => const AdminPost(),
    //
    // ),
    // RouteItem(
    // icon: Icons.format_paint,
    // name: 'Admin',
    //   builder: () => const AdminPost(),
    //
    // ),
    // RouteItem(
    // icon: Icons.arrow_circle_left,
    // name: "Collapse menu",
    //   builder: () => const AdminPost(),
    //
    // ),];
    // setState(() {
    currentWidget = NavigationService.instance.currentRoute;
    initialized = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        NavigationService.instance.goBack();
        return Future.value(false);
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            child: currentWidget,
          ),
        ),
        // body: AdminLayoutCoordinator(
        //   navigatorWidget: AdminNavigatorApp(),
        //   content: AdminApp(),
        // ),
      ),
    );
  }
}
