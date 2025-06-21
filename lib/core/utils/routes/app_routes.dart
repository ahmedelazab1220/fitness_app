import 'package:flutter/material.dart';

import '../../../features/meals/presentation/view/screens/meals_screen.dart';

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
  static const String mealsRoute = '/meals';

  static Map<String, Widget Function(BuildContext)> routes = {
    mealsRoute: (context) => MealsScreen(),
  };
}
