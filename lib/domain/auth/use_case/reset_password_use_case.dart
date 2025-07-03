import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/reset_password/request/reset_password_request_entity.dart';
import '../entity/reset_password/response/reset_password_response_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<Result<ResetPasswordResponseEntity>> call(
    ResetPasswordRequestEntity request,
  ) async => await _authRepo.resetPassword(request);
}
