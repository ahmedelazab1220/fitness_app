import 'package:flutter/material.dart';

import '../../../features/onBoarding/presentation/view/on_boarding_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String home = "/home";
  static const String mainLayoutRoute = '/main-layout';
  static const String profileRoute = '/profile';
  static const String editProfileRoute = '/edit-profile';
  static const String onBoardingRoute = '/on-boarding';

  static Map<String, Widget Function(BuildContext)> routes = {
    onBoardingRoute: (context) => OnBoardingScreen(),
  };
}
