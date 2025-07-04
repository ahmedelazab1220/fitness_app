import 'package:fitness_app/core/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../models/user_dto.dart';
import '../contract/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _flutterSecureStorage;
  final Box<UserDto> _userBox;

  AuthLocalDataSourceImpl(this._flutterSecureStorage, this._userBox);

  @override
  Future<void> deleteToken(String key) async {
    return await _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<String?> getToken(String key) async {
    return await _flutterSecureStorage.read(key: key) ?? '';
  }

  @override
  Future<void> saveToken(String key, String value) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> saveUser(UserDto user) async {
    await _userBox.put(Constants.userBox, user);
  }

  @override
  Future<UserDto?> getUser() async => _userBox.get(Constants.userBox);
}
