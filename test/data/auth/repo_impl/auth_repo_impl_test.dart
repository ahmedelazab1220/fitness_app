import 'package:fitness_app/core/utils/constants.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_local_data_source.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/data/auth/models/user_dto.dart';
import 'package:fitness_app/data/auth/models/forget_password/response/forget_password_response_dto.dart';
import 'package:fitness_app/data/auth/models/otp_verification/response/otp_verification_response_dto.dart';
import 'package:fitness_app/data/auth/models/reset_password/response/reset_password_response_dto.dart';
import 'package:fitness_app/data/auth/repo_impl/auth_repo_impl.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:fitness_app/domain/auth/entity/forget_password/forget_password_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/forget_password/forget_password_response_entity.dart';
import 'package:fitness_app/domain/auth/entity/otp_verification/request/otp_verification_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/otp_verification/response/otp_verification_response_entity.dart';
import 'package:fitness_app/domain/auth/entity/reset_password/request/reset_password_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/reset_password/response/reset_password_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_constants.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, AuthLocalDataSource, AuthRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRepoImpl authRepoImpl;
  late MockApiManager mockApiManager;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  const testEmail = 'ahmed@example.com';
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

  late ForgetPasswordResponseDto forgetPasswordSuccessResponseDto;
  late ForgetPasswordRequestEntity forgetPasswordRequestEntity;
  late OtpVerificationResponseDto otpVerificationSuccessResponseDto;
  late OtpVerificationRequestEntity otpVerificationRequestEntity;
  late ResetPasswordRequestEntity resetPasswordRequestEntity;
  late ResetPasswordResponseDto resetPasswordSuccessResponseDto;

  setUp(() {
    mockApiManager = MockApiManager();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(
      mockApiManager,
      mockAuthLocalDataSource,
      mockAuthRemoteDataSource,
    );
  });

  setUpAll(() {
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
  });

  group('AuthRepoImpl Tests', () {
    group('getProfileData', () {
      test('returns SuccessResult<UserEntity> on success', () async {
        // Prepare DTO and expected entity
        final userDto = UserDto(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          gender: 'male',
          age: 30,
          weight: 70,
          height: 175,
          activityLevel: 'level1',
          goal: 'Gain More Flexible',
          photo: 'url',
        );
        final userResponseDto = UserDataResponseDto(
          message: 'OK',
          user: userDto,
        );

        final expectedEntity = userDto.toEntity();

        // Register dummy for generics
        provideDummy<Result<UserEntity>>(
          SuccessResult<UserEntity>(expectedEntity),
        );

        // Stub remote data source
        when(
          mockAuthRemoteDataSource.getProfileData(),
        ).thenAnswer((_) async => userResponseDto);
        // Stub API manager
        when(
          mockApiManager.execute<UserEntity>(any),
        ).thenAnswer((_) async => SuccessResult<UserEntity>(expectedEntity));

        // Act
        final result = await authRepoImpl.getProfileData();

        // Assert
        verify(mockApiManager.execute<UserEntity>(any)).called(1);
        expect(result, isA<SuccessResult<UserEntity>>());
      });

      test('returns FailureResult<UserEntity> on failure', () async {
        final error = Exception('Network error');
        // Register dummy for generics
        provideDummy<Result<UserEntity>>(FailureResult<UserEntity>(error));

        // Stub remote data source
        final userDto = UserDataResponseDto(message: 'OK', user: null);
        when(
          mockAuthRemoteDataSource.getProfileData(),
        ).thenAnswer((_) async => userDto);
        // Stub API manager to return failure
        when(
          mockApiManager.execute<UserEntity>(any),
        ).thenAnswer((_) async => FailureResult<UserEntity>(error));

        // Act
        final result = await authRepoImpl.getProfileData();

        // Assert
        verify(mockApiManager.execute<UserEntity>(any)).called(1);
        expect(result, isA<FailureResult<UserEntity>>());
      });
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
