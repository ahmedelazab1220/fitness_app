import 'package:flutter/material.dart';

import '../../../features/home/presentation/view/home_screen.dart';

import '../../../features/chat_bot/presentation/view/chat_bot_screen.dart';
import '../../../features/main_layout/presentation/view/main_layout_screen.dart';
import '../../../features/profile/presentation/view/profile_screen.dart';
import '../../../features/workouts/presentation/view/workouts_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String homeRoute = "/home";
  static const String mainLayoutRoute = '/main-layout';
  static const String profileRoute = '/profile';
  static const String editProfileRoute = '/edit-profile';
  static const String onBoardingRoute = '/on-boarding';
  static const String workoutRoute = '/workout';
  static const String chatBotRoute = 'chat-bot';

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRoute: (context) => const HomeScreen(),
    mainLayoutRoute: (context) => const MainLayoutScreen(),
    profileRoute: (context) => const ProfileScreen(),
    workoutRoute: (context) => const WorkoutsScreen(),
    chatBotRoute: (context) => const ChatBotScreen(),
  };
}
