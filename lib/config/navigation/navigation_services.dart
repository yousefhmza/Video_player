import 'package:flutter/widgets.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Future<dynamic> push(String route, {Map<String, dynamic>? arguments}) async {
    return await Navigator.pushNamed(navigationKey.currentContext!, route, arguments: arguments);
  }

  static Future<dynamic> pushReplacement(String route, {Map<String, dynamic>? arguments}) async {
    return await Navigator.pushReplacementNamed(navigationKey.currentContext!, route, arguments: arguments);
  }

  static Future<dynamic> pushReplacementAll(
    String route, {
    BuildContext? context,
    Map<String, dynamic>? arguments,
  }) async {
    return await Navigator.pushNamedAndRemoveUntil(
      context ?? navigationKey.currentContext!,
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static dynamic goBack([Object? result]) => Navigator.pop(navigationKey.currentContext!, result);

  static void popUntil(String path) =>
      Navigator.popUntil(navigationKey.currentContext!, (route) => route.settings.name == path);
}
