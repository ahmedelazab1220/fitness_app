import 'package:flutter/material.dart';

import '../../../features/login/presentation/view/login_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String mainLayoutRoute = '/main-layout';
  static const String onBoardingRoute = '/on-boarding';

  static Map<String, Widget Function(BuildContext)> routes = {
    loginRoute: (context) => LoginScreen(),
    mainLayoutRoute: (context) => const MainLayoutScreen(),
  };
}

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Layout')),
      body: const Center(child: Text('Welcome to the Main Layout!')),
    );
  }
}
