import 'package:collection/collection.dart';
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
    final route =
        _routes.keys.firstWhereOrNull((pattern) => text.startsWith(pattern));
    if (route == null) {
      throw Exception("Route not found: $text");
    }
    final widgetBuilder = _routes[route]!;
    final queryParamMap = getQueryParamMap(text, route);

    print("queryParamMap: $queryParamMap");

    final widget = widgetBuilder();
    print("after widgetBuilder");
    _routeHistory.add(RouteItem(
      name: text,
      widget: widget,
      queryParamMap: queryParamMap,
    ));
    onNavigate(widget);
    final fullRoute = _routeHistory.map((e) => e.name).join('/');
    print('Route: $fullRoute');
  }

  void registerRoutes({
    required Map<String, StatefulWidget Function()> routes,
    required String initialRoute,
  }) {
    _routes = routes;
    goTo(initialRoute);
    // _routeHistory.add(RouteItem(name: '/', widget: routes['/']!()));
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

  Map<String, String> getQueryParamMap(String fullPath, String routeName) {
    final queryParam = fullPath.substring(routeName.length);
    final queryParamElements = queryParam.split("/");
    print("fullPath: $fullPath, routeName $routeName");
    if (queryParamElements.isEmpty) {
      return {};
    }
    if (queryParamElements.first != "") {
      throw Exception("Invalid query param: $queryParam");
    }
    queryParamElements.removeAt(0);
    if (queryParamElements.length % 2 != 0) {
      throw Exception("Invalid query param: $queryParam");
    }
    final queryParamMap = <String, String>{};
    for (var i = 0; i < queryParamElements.length; i += 2) {
      final key = queryParamElements[i];
      final value = queryParamElements[i + 1];
      queryParamMap[key] = value;
    }
    return queryParamMap;
  }
}
