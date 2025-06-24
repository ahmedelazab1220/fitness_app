import 'package:flutter/material.dart';

import '../../../features/details_food/presentation/view/meal_details_screen.dart';

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
  static const String mealDetailsRoute = '/meals-details';

  static Map<String, Widget Function(BuildContext)> routes = {
    // ignore: prefer_const_constructors
    mealDetailsRoute: (context) => MealDetailsScreen(mealId: '52772'),
  };
}
