import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_press/services/route_item.dart';

class NavigationService {
  // instance
  static NavigationService? _instance;

  late Map<String, StatefulWidget Function()> _routes = {};

  // constructor
  NavigationService._();

  // get instance
  static NavigationService get instance {
    _instance ??= NavigationService._();
    return _instance!;
  }

  // route histor
  final List<RouteItem> _routeHistory = [];

  Widget get currentRoute => currentRouteItem.widget;
  RouteItem get currentRouteItem => _routeHistory.last;
  void goTo(String text) {
    final widgetBuilder = _routes[text];
    if (widgetBuilder == null) {
      throw Exception("Route not found: $text");
    }
    final widget = widgetBuilder();
    _routeHistory.add(RouteItem(name: text, widget: widget));
    onNavigate(widget);
    final fullRoute = _routeHistory.map((e) => e.name).join('/');
    print('Route: $fullRoute');
  }

  void registerRoutes(Map<String, StatefulWidget Function()> routes) {
    _routes = routes;
    _routeHistory.add(RouteItem(name: '/', widget: routes['/']!()));
  }

  late Null Function(Widget route) onNavigate;
  void onChange(Null Function(Widget route) onNavigate) {
    this.onNavigate = onNavigate;
  }

  void goBack() {
    if (_routeHistory.length > 1) {
      _routeHistory.removeLast();
      onNavigate(_routeHistory.last.widget);
    }
  }
}
