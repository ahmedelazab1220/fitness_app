import 'package:fitness_app/data/auth/models/logout_response_dto.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<UserDataResponseDto> getProfileData();

  Future<LogoutResponseDto> logout();
}
