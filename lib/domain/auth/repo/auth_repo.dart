import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/login_request_entity.dart';

abstract interface class AuthRepo {
  Future<Result<void>> login(LoginRequest request);
}
