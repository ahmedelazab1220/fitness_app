import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/login_response_dto.dart';
import '../entity/login_request_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRep;

  LoginUseCase(this._authRep);

  Future<Result<LoginResponseDto>> call(LoginRequest request) async {
    return await _authRep.login(request);
  }
}
