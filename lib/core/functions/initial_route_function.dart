import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/routes/app_routes.dart';

@injectable
class RouteInitializer {
  final FlutterSecureStorage flutterSecureStorage;
  final SharedPreferences sharedPreferences;

  RouteInitializer({
    required this.flutterSecureStorage,
    required this.sharedPreferences,
  });

  Future<String?> computeInitialRoute() async {
    var firstTime = sharedPreferences.getBool(Constants.firstTime);
    var token = await flutterSecureStorage.read(key: Constants.token);
    if (firstTime == null || firstTime == false) {
      return AppRoutes.onBoardingRoute;
    }
    if (token != null) {
      return AppRoutes.mainLayoutRoute;
    } else {
      return AppRoutes.loginRoute;
    }
  }
}
