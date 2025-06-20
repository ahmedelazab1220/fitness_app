import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/login_request_entity.dart';

abstract class AuthRepo {
  Future<Result<void>> login(LoginRequest request);
}
import 'package:fitness_app/data/auth/models/response/login_response_dto.dart';


import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/request/login_request_dto.dart';

abstract interface class AuthRepo {
  Future<Result<LoginResponseDto>> login(LoginRequestDto request);
}

