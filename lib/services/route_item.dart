import 'package:flutter/material.dart';

class RouteItem {
  const RouteItem({
    required this.name,
    required this.widget,
  });
  final String name;
  final Widget widget;
}
