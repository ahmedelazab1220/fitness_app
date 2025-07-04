import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constants.dart';
import '../contract/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _flutterSecureStorage;

  AuthLocalDataSourceImpl(this._sharedPreferences, this._flutterSecureStorage);

  @override
  Future<void> clearAll() async {
    return await _flutterSecureStorage.deleteAll();
  }

  @override
  Future<bool> selectLanguage(String languageCode) async {
    return await _sharedPreferences.setString(
      Constants.selectedLanguageCode,
      languageCode,
    );
  }

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
}
