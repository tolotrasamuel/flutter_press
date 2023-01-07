library flutter_press;

import 'package:flutter/material.dart';
import 'package:flutter_press/flutter_press_nav_root.dart';

class FlutterPressApp extends StatefulWidget {
  const FlutterPressApp({Key? key}) : super(key: key);

  @override
  State<FlutterPressApp> createState() => _FlutterPressAppState();
}

class _FlutterPressAppState extends State<FlutterPressApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Press Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //dark theme
        brightness: Brightness.dark,
      ),
      // routes: {
      //   '/Admin': (context) => const AdminPost(),
      // },
      home: Container(
        child: FlutterPressNavRoot(),
      ),
    );
  }
}
