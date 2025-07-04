import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/forget_password/forget_password_request_entity.dart';
import '../entity/forget_password/forget_password_response_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<Result<ForgetPasswordResponseEntity>> call(
    ForgetPasswordRequestEntity request,
  ) async => await _authRepo.forgetPassword(request);
}
