import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/login_response_dto.dart';
import '../entity/login_request_entity.dart';

abstract interface class AuthRepo {
  Future<Result<LoginResponseDto>> login(LoginRequest request);
}
