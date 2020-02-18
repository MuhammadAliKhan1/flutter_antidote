import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateToPushNamed(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToPushReplacement(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  bool goBack() {
    return navigatorKey.currentState.pop();
  }
}
