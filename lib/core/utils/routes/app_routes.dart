import 'package:fitness_app/features/register/presentation/view/register_screen.dart';
import 'package:flutter/material.dart';

import '../../../features/register/presentation/view/screens/complete_register_page_view.dart';

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
  static const String completeRegisterRoute = '/complete-register';

  static Map<String, Widget Function(BuildContext)> routes = {
    registerRoute: (context) => RegisterScreen(),
    completeRegisterRoute: (context) => const CompleteRegisterPageView(),
  };
}
