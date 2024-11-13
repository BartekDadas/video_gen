import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/auth_screen/auth_screen.dart';
import '../presentation/gen_screen/gen_screen.dart';

class AppRoutes {
  static const String authScreen = '/auth_screen';

  static const String genScreen = '/gen_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        authScreen: AuthScreen.builder,
        genScreen: GenScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: AuthScreen.builder
      };
}
