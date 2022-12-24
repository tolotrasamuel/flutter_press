import 'package:flutter/material.dart';
import 'package:flutter_press/admin_post.dart';
import 'package:flutter_press/admin_settings.dart';

class AdminApp extends StatefulWidget {
  const AdminApp({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminApp> createState() => AdminAppState();
}

class AdminAppState extends State<AdminApp> {
  @override
  Widget build(BuildContext context) {
    return AdminPost();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //dark theme
        brightness: Brightness.dark,
      ),
      routes: {
        '/Post': (context) => AdminPost(),
        '/Settings': (context) => AdminSettings(),
      },
      home: AdminPost(),
      // initialRoute: "/Post",
      // home: Scaffold(
      //   body: Center(
      //     child: ElevatedButton(
      //         onPressed: () {
      //           navigateTo("Post");
      //         },
      //         child: Text("Do")),
      //   ),
      // ),
    );
  }

// void navigateTo(String text) {
//   final currentRoute = ModalRoute.of(context)!.settings.name;
//   print('currentRoute: $currentRoute');
//   Navigator.of(context).pushNamed('/$text');
//   widget.navKey.currentState!.setCurrentlySelected(text);
// }
}
