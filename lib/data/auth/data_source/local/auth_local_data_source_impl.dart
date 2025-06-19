import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../contract/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _flutterSecureStorage;

  AuthLocalDataSourceImpl(this._flutterSecureStorage);

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
