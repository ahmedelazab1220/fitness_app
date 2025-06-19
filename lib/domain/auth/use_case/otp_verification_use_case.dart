import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/otp_verification/request/otp_verification_request_entity.dart';
import '../entity/otp_verification/response/otp_verification_response_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class OtpVerificationUseCase {
  final AuthRepo _authRepo;

  OtpVerificationUseCase(this._authRepo);

  Future<Result<OtpVerificationResponseEntity>> call(
    OtpVerificationRequestEntity request,
  ) async => await _authRepo.otpVerification(request);
}
