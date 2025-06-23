import 'package:flutter/material.dart';

import '../../../features/meal_details/presentation/view/meal_details_screen.dart';

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
  static const String mealDetailsRoute = '/meal-details';

  static Map<String, Widget Function(BuildContext)> routes = {
    mealDetailsRoute: (context) => const MealDetailsScreen(mealId: '52772'),
  };
}
