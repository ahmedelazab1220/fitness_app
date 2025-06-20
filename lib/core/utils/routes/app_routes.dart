import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/login/presentation/view/login_screen.dart';
import '../../../features/login/presentation/view_model/cubit/login_cubit.dart';
import '../di/di.dart';

import '../../../features/login/presentation/view/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String loginRoute = "/login";
  static const String mainLayoutRoute = '/main-layout';
  static const String onBoardingRoute = '/on-boarding';

  static Map<String, Widget Function(BuildContext)> routes = {
    loginRoute: (context) => BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const LoginScreen(),
    ),
  };
  static Map<String, Widget Function(BuildContext)> routes = {
    loginRoute: (context) => LoginScreen(),
  };
}
