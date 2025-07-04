import 'package:flutter/material.dart';

import '../../../features/workouts/presentation/view/screens/workouts_screen.dart';

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
  static const String workoutsRoute = '/workouts';
  static const String exerciseDetailsRoute = '/exercise-details';

  static Map<String, Widget Function(BuildContext)> routes = {
    workoutsRoute: (context) => WorkoutsScreen(),
  };
}
