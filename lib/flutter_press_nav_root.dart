library flutter_press;

import 'package:flutter/material.dart';
import 'package:flutter_press/admin_app.dart';
import 'package:flutter_press/admin_post.dart';
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
    super.initState();
    NavigationService.instance.registerRoutes({
      '/': () => const AdminApp(),
      'Post': () => const AdminPost(),
      'Settings': () => const AdminSettings(),
    });
    NavigationService.instance.onChange((route) {
      setState(() {
        currentWidget = route;
      });
    });
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
