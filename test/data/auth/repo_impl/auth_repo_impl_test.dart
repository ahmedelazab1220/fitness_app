import 'package:fitness_app/core/utils/constants.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/core/utils/datasource_excution/app_exception.dart';
import 'package:fitness_app/data/auth/data_source/local/auth_local_data_source_impl.dart';
import 'package:fitness_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:fitness_app/data/auth/models/forget_password/response/forget_password_response_dto.dart';
import 'package:fitness_app/data/auth/models/otp_verification/response/otp_verification_response_dto.dart';
import 'package:fitness_app/data/auth/models/register/request/register_request_dto.dart';
import 'package:fitness_app/data/auth/models/reset_password/response/reset_password_response_dto.dart';
import 'package:fitness_app/data/auth/models/register/response/register_response_dto.dart';
import 'package:fitness_app/data/auth/repo_impl/auth_repo_impl.dart';
import 'package:fitness_app/domain/auth/entity/forget_password/forget_password_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/forget_password/forget_password_response_entity.dart';
import 'package:fitness_app/domain/auth/entity/otp_verification/request/otp_verification_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/otp_verification/response/otp_verification_response_entity.dart';
import 'package:fitness_app/domain/auth/entity/register/register_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/reset_password/request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/reset_password/response/reset_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_constants.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceImpl, AuthLocalDataSourceImpl, ApiManager])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDataSourceImpl mockAuthRemoteDataSource;
  late MockAuthLocalDataSourceImpl mockAuthLocalDataSource;
  late MockApiManager mockApiManager;

  const testEmail = 'ahmed@example.com';
  const testPassword = 'Aa12@com';
  const successMessage = 'Success';
  const successInfo = 'OTP Send To Your Email';
  const networkError = 'Network Error';
  const invalidOrNullResponse = 'Invalid or null response from server';
  const unexcpctedError = 'API Manager unexpected failure';
  const testResetCode = '456213';
  const testNewPassword = 'Aa12@com';
  const storageError = 'Storage Error';
  final networkException = Exception(networkError);
  final unexpectedException = Exception(unexcpctedError);
  final invalidOrNullException = Exception(invalidOrNullResponse);
  final storageException = Exception(storageError);

  late RegisterRequestEntity registerRequestDto;
  late RegisterResponseDto registerResponseDto;
  late ForgetPasswordResponseDto forgetPasswordSuccessResponseDto;
  late ForgetPasswordRequestEntity forgetPasswordRequestEntity;
  late OtpVerificationResponseDto otpVerificationSuccessResponseDto;
  late OtpVerificationRequestEntity otpVerificationRequestEntity;
  late ResetPasswordRequestEntity resetPasswordRequestEntity;
  late ResetPasswordResponseDto resetPasswordSuccessResponseDto;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSourceImpl();
    mockApiManager = MockApiManager();
    mockAuthLocalDataSource = MockAuthLocalDataSourceImpl();
    authRepoImpl = AuthRepoImpl(
      mockApiManager,
      mockAuthRemoteDataSource,
      mockAuthLocalDataSource,
    );
  });

  setUpAll(() {
    registerRequestDto = RegisterRequestEntity(
      email: testEmail,
      password: testPassword,
      rePassword: testPassword,
    );
    registerResponseDto = RegisterResponseDto(
      message: successMessage,
      token: TestConstants.fakeToken,
    );
    forgetPasswordSuccessResponseDto = ForgetPasswordResponseDto(
      message: successMessage,
      info: successInfo,
    );
    forgetPasswordRequestEntity = ForgetPasswordRequestEntity(email: testEmail);
    otpVerificationSuccessResponseDto = OtpVerificationResponseDto(
      status: successMessage,
    );
    otpVerificationRequestEntity = OtpVerificationRequestEntity(
      resetCode: testResetCode,
    );
    resetPasswordRequestEntity = ResetPasswordRequestEntity(
      email: testEmail,
      newPassword: testNewPassword,
    );
    resetPasswordSuccessResponseDto = ResetPasswordResponseDto(
      message: successMessage,
      token: TestConstants.fakeToken,
    );
    provideDummy<Result<void>>(SuccessResult<void>(null));
  });

  group("Auth Repo Test", () {
    test("should return SuccessResult when register is successful", () async {
      provideDummy<Result<RegisterResponseDto>>(
        SuccessResult<RegisterResponseDto>(registerResponseDto),
      );

      when(
        mockAuthRemoteDataSource.register(any),
      ).thenAnswer((_) async => registerResponseDto);

      when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer((
        invocation,
      ) async {
        final function =
            invocation.positionalArguments.first
                as Future<RegisterResponseDto> Function();
        final result = await function();
        return SuccessResult<RegisterResponseDto>(result);
      });

      // Act
      final result = await authRepoImpl.register(registerRequestDto);

      // Assert
      expect(result, isA<SuccessResult<void>>());
    });

    test(
      "should return InternetConnectionException when SocketException is thrown",
      () async {
        // Arrange
        const internetConnectionException = InternetConnectionException(
          message: "No Internet",
        );
        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(internetConnectionException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(internetConnectionException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async =>
              FailureResult<RegisterResponseDto>(internetConnectionException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test(
      "should return ApiTimeoutException when connection times out",
      () async {
        // Arrange
        const apiTimeoutException = ApiTimeoutException(
          message: "Connection timed out",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(apiTimeoutException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(apiTimeoutException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async => FailureResult<RegisterResponseDto>(apiTimeoutException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test("should return BadRequestException when server returns 400", () async {
      // Arrange
      const badRequestException = BadRequestException(message: "Bad Request");

      provideDummy<Result<RegisterResponseDto>>(
        FailureResult<RegisterResponseDto>(badRequestException),
      );

      when(
        mockAuthRemoteDataSource.register(
          RegisterRequestDto.fromDomain(registerRequestDto),
        ),
      ).thenThrow(badRequestException);

      when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
        (_) async => FailureResult<RegisterResponseDto>(badRequestException),
      );

      // Act
      final result = await authRepoImpl.register(registerRequestDto);

      // Assert
      expect(result, isA<FailureResult<RegisterResponseDto>>());
    });

    test(
      "should return UnauthorizedException when server returns 401",
      () async {
        // Arrange
        const unauthorizedException = UnauthorizedException(
          message: "Unauthorized",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(unauthorizedException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(unauthorizedException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async =>
              FailureResult<RegisterResponseDto>(unauthorizedException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test("should return ForbiddenException when server returns 403", () async {
      // Arrange
      const forbiddenException = ForbiddenException(message: "Forbidden");

      provideDummy<Result<RegisterResponseDto>>(
        FailureResult<RegisterResponseDto>(forbiddenException),
      );

      when(
        mockAuthRemoteDataSource.register(
          RegisterRequestDto.fromDomain(registerRequestDto),
        ),
      ).thenThrow(forbiddenException);

      when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
        (_) async => FailureResult<RegisterResponseDto>(forbiddenException),
      );

      // Act
      final result = await authRepoImpl.register(registerRequestDto);

      // Assert
      expect(result, isA<FailureResult<RegisterResponseDto>>());
    });

    test("should return NotFoundException when server returns 404", () async {
      // Arrange
      const notFoundException = NotFoundException(message: "Not Found");

      provideDummy<Result<RegisterResponseDto>>(
        FailureResult<RegisterResponseDto>(notFoundException),
      );

      when(
        mockAuthRemoteDataSource.register(
          RegisterRequestDto.fromDomain(registerRequestDto),
        ),
      ).thenThrow(notFoundException);

      when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
        (_) async => FailureResult<RegisterResponseDto>(notFoundException),
      );

      // Act
      final result = await authRepoImpl.register(registerRequestDto);

      // Assert
      expect(result, isA<FailureResult<RegisterResponseDto>>());
    });

    test(
      "should return InternalServerErrorException when server returns 500",
      () async {
        // Arrange
        const internalServerErrorException = InternalServerErrorException(
          message: "Internal Server Error",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(internalServerErrorException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(internalServerErrorException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async =>
              FailureResult<RegisterResponseDto>(internalServerErrorException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test(
      "should return UnknownApiException when server returns unknown status code",
      () async {
        // Arrange
        const unknownApiException = UnknownApiException(
          message: "Unknown API Error",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(unknownApiException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(unknownApiException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async => FailureResult<RegisterResponseDto>(unknownApiException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test(
      "should return CertificateException when bad certificate is encountered",
      () async {
        // Arrange
        const certificateException = CertificateException(
          message: "Invalid Certificate",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(certificateException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(certificateException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async => FailureResult<RegisterResponseDto>(certificateException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test(
      "should return RequestCancelledException when request is cancelled",
      () async {
        // Arrange
        const requestCancelledException = RequestCancelledException(
          message: "Request Cancelled",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(requestCancelledException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(requestCancelledException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async =>
              FailureResult<RegisterResponseDto>(requestCancelledException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test(
      "should return DataParsingException when FormatException is thrown",
      () async {
        // Arrange
        const dataParsingException = DataParsingException(
          message: "Data Parsing Error",
        );

        provideDummy<Result<RegisterResponseDto>>(
          FailureResult<RegisterResponseDto>(dataParsingException),
        );

        when(
          mockAuthRemoteDataSource.register(
            RegisterRequestDto.fromDomain(registerRequestDto),
          ),
        ).thenThrow(dataParsingException);

        when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
          (_) async => FailureResult<RegisterResponseDto>(dataParsingException),
        );

        // Act
        final result = await authRepoImpl.register(registerRequestDto);

        // Assert
        expect(result, isA<FailureResult<RegisterResponseDto>>());
      },
    );

    test("should return UnknownApiException for unexpected errors", () async {
      // Arrange
      const unknownApiException = UnknownApiException(
        message: "Unknown API Error",
      );

      provideDummy<Result<RegisterResponseDto>>(
        FailureResult<RegisterResponseDto>(unknownApiException),
      );

      when(
        mockAuthRemoteDataSource.register(
          RegisterRequestDto.fromDomain(registerRequestDto),
        ),
      ).thenThrow(unknownApiException);

      when(mockApiManager.execute<RegisterResponseDto>(any)).thenAnswer(
        (_) async => FailureResult<RegisterResponseDto>(unknownApiException),
      );

      // Act
      final result = await authRepoImpl.register(registerRequestDto);

      // Assert
      expect(result, isA<FailureResult<RegisterResponseDto>>());
    });
  });

  group('forgetPassword', () {
    test(
      'should return SuccessResult when forgetPassword is successful',
      () async {
        // Arrange
        provideDummy<Result<ForgetPasswordResponseEntity>>(
          SuccessResult<ForgetPasswordResponseEntity>(
            forgetPasswordSuccessResponseDto.toEntity(),
          ),
        );

        when(
          mockAuthRemoteDataSource.forgetPassword(any),
        ).thenAnswer((_) async => forgetPasswordSuccessResponseDto);

        when(
          mockApiManager.execute<ForgetPasswordResponseEntity>(any),
        ).thenAnswer((invocation) async {
          final function =
              invocation.positionalArguments.first
                  as Future<ForgetPasswordResponseEntity> Function();
          final result = await function();
          return SuccessResult(result);
        });

        // Act
        final result = await authRepoImpl.forgetPassword(
          forgetPasswordRequestEntity,
        );

        // Assert
        expect(result, isA<SuccessResult<ForgetPasswordResponseEntity>>());
        expect((result as SuccessResult).data.message, equals(successMessage));
        expect((result as SuccessResult).data.info, equals(successInfo));
      },
    );

    test(
      'should return FailureResult when forgetPassword throws an exception',
      () async {
        // Arrange
        provideDummy<Result<ForgetPasswordResponseEntity>>(
          FailureResult<ForgetPasswordResponseEntity>(networkException),
        );

        when(
          mockAuthRemoteDataSource.forgetPassword(any),
        ).thenThrow(networkException);

        when(
          mockApiManager.execute<ForgetPasswordResponseEntity>(any),
        ).thenAnswer((_) async {
          return FailureResult<ForgetPasswordResponseEntity>(networkException);
        });

        // Act
        final result = await authRepoImpl.forgetPassword(
          forgetPasswordRequestEntity,
        );

        // Assert
        expect(result, isA<FailureResult<ForgetPasswordResponseEntity>>());
        expect(
          (result as FailureResult).exception.toString(),
          contains(networkError),
        );
      },
    );

    test(
      'should return FailureResult when forgetPassword returns null or invalid response',
      () async {
        // Arrange
        provideDummy<Result<ForgetPasswordResponseEntity>>(
          FailureResult<ForgetPasswordResponseEntity>(invalidOrNullException),
        );

        when(
          mockAuthRemoteDataSource.forgetPassword(any),
        ).thenThrow(Exception(invalidOrNullResponse));

        when(
          mockApiManager.execute<ForgetPasswordResponseEntity>(any),
        ).thenAnswer((_) async {
          return FailureResult<ForgetPasswordResponseEntity>(
            invalidOrNullException,
          );
        });

        // Act
        final result = await authRepoImpl.forgetPassword(
          forgetPasswordRequestEntity,
        );

        // Assert
        expect(result, isA<FailureResult<ForgetPasswordResponseEntity>>());
        expect(
          (result as FailureResult).exception.toString(),
          contains(invalidOrNullResponse),
        );
      },
    );

    test(
      'should throw exception when apiManager.execute throws unexpected exception',
      () async {
        // Arrange
        provideDummy<Result<ForgetPasswordResponseEntity>>(
          FailureResult<ForgetPasswordResponseEntity>(unexpectedException),
        );

        when(
          mockAuthRemoteDataSource.forgetPassword(any),
        ).thenAnswer((_) async => forgetPasswordSuccessResponseDto);

        when(
          mockApiManager.execute<ForgetPasswordResponseEntity>(any),
        ).thenThrow(unexpectedException);

        // Act & Assert
        expect(
          () async =>
              await authRepoImpl.forgetPassword(forgetPasswordRequestEntity),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains(unexcpctedError),
            ),
          ),
        );
      },
    );
  });

  group('verifyOtp', () {
    test('should return SuccessResult when verifyOtp is successful', () async {
      // Arrange
      provideDummy<Result<OtpVerificationResponseEntity>>(
        SuccessResult<OtpVerificationResponseEntity>(
          otpVerificationSuccessResponseDto.toEntity(),
        ),
      );

      when(
        mockAuthRemoteDataSource.verifyOtp(any),
      ).thenAnswer((_) async => otpVerificationSuccessResponseDto);

      when(
        mockApiManager.execute<OtpVerificationResponseEntity>(any),
      ).thenAnswer((invocation) async {
        final function =
            invocation.positionalArguments.first
                as Future<OtpVerificationResponseEntity> Function();
        final result = await function();
        return SuccessResult(result);
      });

      // Act
      final result = await authRepoImpl.verifyOtp(otpVerificationRequestEntity);

      // Assert
      expect(result, isA<SuccessResult<OtpVerificationResponseEntity>>());
      expect((result as SuccessResult).data.status, equals(successMessage));
    });

    test(
      'should return FailureResult when verifyOtp throws an exception',
      () async {
        // Arrange
        provideDummy<Result<OtpVerificationResponseEntity>>(
          FailureResult<OtpVerificationResponseEntity>(networkException),
        );

        when(
          mockAuthRemoteDataSource.verifyOtp(any),
        ).thenThrow(networkException);

        when(
          mockApiManager.execute<OtpVerificationResponseEntity>(any),
        ).thenAnswer((_) async {
          return FailureResult<OtpVerificationResponseEntity>(networkException);
        });

        // Act
        final result = await authRepoImpl.verifyOtp(
          otpVerificationRequestEntity,
        );

        // Assert
        expect(result, isA<FailureResult<OtpVerificationResponseEntity>>());
        expect(
          (result as FailureResult).exception.toString(),
          contains(networkError),
        );
      },
    );

    test(
      'should return FailureResult when verifyOtp returns null or invalid response',
      () async {
        // Arrange
        provideDummy<Result<OtpVerificationResponseEntity>>(
          FailureResult<OtpVerificationResponseEntity>(invalidOrNullException),
        );

        when(
          mockAuthRemoteDataSource.verifyOtp(any),
        ).thenThrow(Exception(invalidOrNullResponse));

        when(
          mockApiManager.execute<OtpVerificationResponseEntity>(any),
        ).thenAnswer((_) async {
          return FailureResult<OtpVerificationResponseEntity>(
            invalidOrNullException,
          );
        });

        // Act
        final result = await authRepoImpl.verifyOtp(
          otpVerificationRequestEntity,
        );

        // Assert
        expect(result, isA<FailureResult<OtpVerificationResponseEntity>>());
        expect(
          (result as FailureResult).exception.toString(),
          contains(invalidOrNullResponse),
        );
      },
    );

    test(
      'should throw exception when apiManager.execute throws unexpected exception',
      () async {
        // Arrange
        provideDummy<Result<OtpVerificationResponseEntity>>(
          FailureResult<OtpVerificationResponseEntity>(unexpectedException),
        );

        when(
          mockAuthRemoteDataSource.verifyOtp(any),
        ).thenAnswer((_) async => otpVerificationSuccessResponseDto);

        when(
          mockApiManager.execute<OtpVerificationResponseEntity>(any),
        ).thenThrow(unexpectedException);

        // Act & Assert
        expect(
          () async =>
              await authRepoImpl.verifyOtp(otpVerificationRequestEntity),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains(unexcpctedError),
            ),
          ),
        );
      },
    );
  });

  group('resetPassword', () {
    test(
      'should return SuccessResult when resetPassword is successful',
      () async {
        // Arrange
        provideDummy<Result<ResetPasswordResponseEntity>>(
          SuccessResult<ResetPasswordResponseEntity>(
            resetPasswordSuccessResponseDto.toEntity(),
          ),
        );

        when(
          mockAuthRemoteDataSource.resetPassword(any),
        ).thenAnswer((_) async => resetPasswordSuccessResponseDto);

        when(
          mockAuthLocalDataSource.saveToken(any, any),
        ).thenAnswer((_) async {});

        when(
          mockApiManager.execute<ResetPasswordResponseEntity>(any),
        ).thenAnswer((invocation) async {
          final function =
              invocation.positionalArguments.first
                  as Future<ResetPasswordResponseEntity> Function();
          final result = await function();
          return SuccessResult(result);
        });

        // Act
        final result = await authRepoImpl.resetPassword(
          resetPasswordRequestEntity,
        );

        // Assert
        expect(result, isA<SuccessResult<ResetPasswordResponseEntity>>());
        expect((result as SuccessResult).data.message, equals(successMessage));
        verify(
          mockAuthLocalDataSource.saveToken(
            Constants.token,
            TestConstants.fakeToken,
          ),
        ).called(1);
      },
    );

    test('should return failure if saving token throws', () async {
      // Arrange
      provideDummy<Result<ResetPasswordResponseEntity>>(
        SuccessResult<ResetPasswordResponseEntity>(
          resetPasswordSuccessResponseDto.toEntity(),
        ),
      );

      when(
        mockAuthRemoteDataSource.resetPassword(any),
      ).thenAnswer((_) async => resetPasswordSuccessResponseDto);

      when(
        mockAuthLocalDataSource.saveToken(any, any),
      ).thenThrow(storageException);

      when(mockApiManager.execute<ResetPasswordResponseEntity>(any)).thenAnswer(
        (invocation) async {
          final function =
              invocation.positionalArguments.first
                  as Future<ResetPasswordResponseEntity> Function();
          try {
            final result = await function();
            return SuccessResult(result);
          } catch (e) {
            return FailureResult(Exception(e.toString()));
          }
        },
      );

      // Act
      final result = await authRepoImpl.resetPassword(
        resetPasswordRequestEntity,
      );

      // Assert
      expect(result, isA<FailureResult<ResetPasswordResponseEntity>>());
      verify(
        mockAuthLocalDataSource.saveToken(
          Constants.token,
          TestConstants.fakeToken,
        ),
      ).called(1);
    });

    test(
      'should return FailureResult when resetPassword throws an exception',
      () async {
        // Arrange
        provideDummy<Result<ResetPasswordResponseEntity>>(
          FailureResult<ResetPasswordResponseEntity>(networkException),
        );

        when(
          mockAuthRemoteDataSource.resetPassword(any),
        ).thenThrow(networkException);

        when(
          mockApiManager.execute<ResetPasswordResponseEntity>(any),
        ).thenAnswer((_) async {
          return FailureResult<ResetPasswordResponseEntity>(networkException);
        });

        // Act
        final result = await authRepoImpl.resetPassword(
          resetPasswordRequestEntity,
        );

        // Assert
        expect(result, isA<FailureResult<ResetPasswordResponseEntity>>());
        expect(
          (result as FailureResult).exception.toString(),
          contains(networkError),
        );
      },
    );

    test(
      'should return FailureResult when resetPassword returns null or invalid response',
      () async {
        // Arrange
        provideDummy<Result<ResetPasswordResponseEntity>>(
          FailureResult<ResetPasswordResponseEntity>(invalidOrNullException),
        );

        when(
          mockAuthRemoteDataSource.resetPassword(any),
        ).thenThrow(Exception(invalidOrNullResponse));

        when(
          mockApiManager.execute<ResetPasswordResponseEntity>(any),
        ).thenAnswer((_) async {
          return FailureResult<ResetPasswordResponseEntity>(
            invalidOrNullException,
          );
        });

        // Act
        final result = await authRepoImpl.resetPassword(
          resetPasswordRequestEntity,
        );

        // Assert
        expect(result, isA<FailureResult<ResetPasswordResponseEntity>>());
        expect(
          (result as FailureResult).exception.toString(),
          contains(invalidOrNullResponse),
        );
      },
    );

    test(
      'should throw exception when apiManager.execute throws unexpected exception',
      () async {
        // Arrange
        provideDummy<Result<ResetPasswordResponseEntity>>(
          FailureResult<ResetPasswordResponseEntity>(unexpectedException),
        );

        when(
          mockAuthRemoteDataSource.resetPassword(any),
        ).thenAnswer((_) async => resetPasswordSuccessResponseDto);

        when(
          mockApiManager.execute<ResetPasswordResponseEntity>(any),
        ).thenThrow(unexpectedException);

        // Act & Assert
        expect(
          () async =>
              await authRepoImpl.resetPassword(resetPasswordRequestEntity),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains(unexcpctedError),
            ),
          ),
        );
      },
    );
  });
}
