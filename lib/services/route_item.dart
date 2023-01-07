import 'package:flutter/material.dart';

class RouteItem {
  const RouteItem({
    required this.name,
    required this.widget,
  });
  final String name;
  final Widget widget;
}

// import 'package:flutter/material.dart';
//
// class RouteItem extends RouteItemChild {
//   final List<RouteItemChild>? children;
//   RouteItem({
//     required String name,
//     Widget? widget,
//     required Widget Function() builder,
//     required IconData icon,
//     this.children,
//   }) : super(
//     name: name,
//     widget: widget,
//     icon: icon,
//     builder: builder,
//   );
// }
//
// class RouteItemChild {
//   RouteItemChild({
//     required this.name,
//     this.widget,
//     required this.icon,
//     required this.builder,
//   });
//   final IconData icon;
//   final String name;
//   final Widget Function() builder;
//   Widget? widget;
// }
