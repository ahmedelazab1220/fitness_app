import 'package:fitness_app/data/excercise/model/response/muscles_dto.dart';
import 'package:flutter/material.dart';

import '../../../features/excercise/view/excercise_details_screen.dart';

import '../../../features/onBoarding/presentation/view/on_boarding_screen.dart';
import '../../../features/forget_password/presentation/view/forget_password_screen.dart';
import '../../../features/otp_verification/presentation/view/otp_verification_screen.dart';
import '../../../features/reset_password/presentation/view/reset_password_screen.dart';
import '../constants.dart';
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
  static const String exerciseDetailsRoute = '/exercise-details';
  static const String otpVerificationRoute = '/otp-verification';
  static const String resetPasswordRoute = '/reset-password';
  static const String workoutRoute = '/workout';
  static const String chatBotRoute = 'chat-bot';

  static Map<String, Widget Function(BuildContext)> routes = {
    exerciseDetailsRoute: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments
              as Map<MusclesDto, dynamic>?;
      final muscleData = args?['muscleData'] as MusclesDto?;
      return ExcerciseDetailsScreen(muscleData: musclesDtoo);
    },
    onBoardingRoute: (context) => const OnBoardingScreen(),
    homeRoute: (context) => const HomeScreen(),
    mainLayoutRoute: (context) => const MainLayoutScreen(),
    profileRoute: (context) => const ProfileScreen(),
    workoutRoute: (context) => const WorkoutsScreen(),
    chatBotRoute: (context) => const ChatBotScreen(),
    forgetPasswordRoute: (context) => const ForgetPasswordScreen(),
    otpVerificationRoute: (context) {
      var args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return OtpVerificationScreen(email: args[Constants.email]);
    },
    resetPasswordRoute: (context) {
      var args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ResetPasswordScreen(email: args[Constants.email]);
    },
  };
}

MusclesDto musclesDtoo = MusclesDto(
  id: "67c8499726895f87ce0aa9d0",
  name: "Iliopsoas",
  image: "https://www.lower-back-pain-answers.com/images/Iliopsoas.jpg",
);
