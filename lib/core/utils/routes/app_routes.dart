import 'package:fitness_app/data/excercise/model/response/muscles_dto.dart';
import 'package:flutter/material.dart';

import '../../../features/excercise/view/excercise_details_screen.dart';

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
  static const String exerciseDetailsRoute = '/exercise-details';

  static Map<String, Widget Function(BuildContext)> routes = {
    exerciseDetailsRoute: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments
              as Map<MusclesDto, dynamic>?;
      final muscleData = args?['muscleData'] as MusclesDto?;
      return ExcerciseDetailsScreen(muscleData: musclesDtoo);
    },
  };
}

MusclesDto musclesDtoo = MusclesDto(
  id: "67c8499726895f87ce0aa9d0",
  name: "Iliopsoas",
  image: "https://www.lower-back-pain-answers.com/images/Iliopsoas.jpg",
);
