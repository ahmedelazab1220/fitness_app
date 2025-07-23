import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth/models/user_dto.dart';
import '../../data/smart_coach/models/message_dto.dart';
import '../../data/smart_coach/models/session_dto.dart';
import 'constants.dart';
import 'di/di.dart';

abstract class AppStrater {
  static Locale? startLocale;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDtoAdapter());
    Hive.registerAdapter(SessionDtoAdapter());
    Hive.registerAdapter(MessageDtoAdapter());
    await Future.wait([
      EasyLocalization.ensureInitialized(),
      configureDependencies(),
    ]);

    final sharedPreferences = getIt<SharedPreferences>();

    final langCode = selectedLanguageCode(sharedPreferences);
    startLocale = Locale(langCode);
  }

  static String selectedLanguageCode(SharedPreferences sharedPreferences) {
    return sharedPreferences.getString(Constants.selectedLanguageCode) ??
        Constants.en;
  }
}
