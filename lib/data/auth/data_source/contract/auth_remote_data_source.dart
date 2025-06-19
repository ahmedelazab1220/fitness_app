import 'package:fitness_app/data/auth/models/response/login_response_dto.dart';

import '../../models/request/login_request_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseDto> login(LoginRequestDto request);
}
