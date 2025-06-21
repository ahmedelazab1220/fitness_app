import 'package:flutter/material.dart';

import '../../../features/login/presentation/view/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String mainLayoutRoute = '/main-layout';
  static const String onBoardingRoute = '/on-boarding';

  static Map<String, Widget Function(BuildContext)> routes = {
    loginRoute: (context) => LoginScreen(),
  };
}
