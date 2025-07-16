import '../../models/user_dto.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String key, String value);

  Future<String?> getToken(String key);

  Future<void> deleteToken(String key);

  Future<void> saveUser(UserDto user);

  Future<UserDto?> getUser();
}
