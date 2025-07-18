import 'package:fitness_app/core/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../data/auth/models/user_dto.dart';
import '../../data/smart_coach/models/session_dto.dart';

@module
abstract class HiveStorageModule {
  @singleton
  @preResolve
  Future<Box<UserDto>> get userBox async {
    if (!Hive.isBoxOpen(Constants.userBox)) {
      await Hive.openBox<UserDto>(Constants.userBox);
    }
    return Hive.box<UserDto>(Constants.userBox);
  }

  @singleton
  @preResolve
  Future<Box<SessionDto>> get sessionBox async {
    if (!Hive.isBoxOpen(Constants.sessionBox)) {
      await Hive.openBox<SessionDto>(Constants.sessionBox);
    }
    return Hive.box<SessionDto>(Constants.sessionBox);
  }
}
