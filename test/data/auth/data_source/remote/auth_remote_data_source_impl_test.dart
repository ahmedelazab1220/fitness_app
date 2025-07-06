import 'package:dio/dio.dart';
import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:fitness_app/data/auth/models/forget_password/request/forget_password_request_dto.dart';
import 'package:fitness_app/data/auth/models/forget_password/response/forget_password_response_dto.dart';
import 'package:fitness_app/data/auth/models/otp_verification/request/otp_verification_request_dto.dart';
import 'package:fitness_app/data/auth/models/otp_verification/response/otp_verification_response_dto.dart';
import 'package:fitness_app/data/auth/models/request/register_request_dto.dart';
import 'package:fitness_app/data/auth/models/reset_password/request/reset_password_request_dto.dart';
import 'package:fitness_app/data/auth/models/reset_password/response/reset_password_response_dto.dart';
import 'package:fitness_app/data/auth/models/response/register_response_dto.dart';
import 'package:fitness_app/data/auth/models/response/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_constants.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthRetrofitClient mockAuthRetrofitClient;

  // Test constants
  const testEmail = 'ahmed@example.com';
  const testNewPassword = 'Aa12@com';
  const successMessage = 'Success';
  const successInfo = 'OTP Send To Your Email';
  const resetPasswordSuccessInfo = 'Reset Password Successfully';
  const errorMessage = 'There is no account with this email address $testEmail';
  const forbiddenMessage = 'Forbidden Route';
  const unknownErrorMessage = 'Unknown Exception';
  const timeoutMessage = 'Timeout: Waiting for Response...';
  const testResetCode = '456213';

  // Test objects
  late ForgetPasswordRequestDto forgetPasswordRequest;
  late ForgetPasswordResponseDto forgetPasswordSuccessResponse;
  late OtpVerificationRequestDto otpVerificationRequest;
  late OtpVerificationResponseDto otpVerificationSuccessResponse;
  late ResetPasswordRequestDto resetPasswordRequest;
  late ResetPasswordResponseDto resetPasswordSuccessResponse;
  late Map<String, dynamic> notFoundErrorResponse;
  late Response<dynamic> notFoundDioResponse;
  late Response<dynamic> forbiddenDioResponse;
  late Response<dynamic> timeoutDioResponse;
  late DioException notFoundDioException;
  late DioException forbiddenDioException;
  late DioException timeoutException;

  setUpAll(() {
    forgetPasswordRequest = ForgetPasswordRequestDto(email: testEmail);
    forgetPasswordSuccessResponse = ForgetPasswordResponseDto(
      message: successMessage,
      info: successInfo,
    );
    otpVerificationRequest = OtpVerificationRequestDto(
      resetCode: testResetCode,
    );
    otpVerificationSuccessResponse = OtpVerificationResponseDto(
      status: successMessage,
    );
    resetPasswordRequest = ResetPasswordRequestDto(
      email: testEmail,
      newPassword: testNewPassword,
    );
    resetPasswordSuccessResponse = ResetPasswordResponseDto(
      message: resetPasswordSuccessInfo,
      token: TestConstants.fakeToken,
    );
    notFoundErrorResponse = {'error': errorMessage};
    notFoundDioResponse = Response(
      requestOptions: RequestOptions(path: TestConstants.notFoundRoute),
      data: notFoundErrorResponse,
      statusCode: TestConstants.notFoundStatusCode,
    );
    forbiddenDioResponse = Response(
      requestOptions: RequestOptions(path: TestConstants.notFoundRoute),
      data: forbiddenMessage,
      statusCode: TestConstants.forbiddenStatusCode,
    );
    timeoutDioResponse = Response(
      requestOptions: RequestOptions(path: TestConstants.notFoundRoute),
      data: timeoutMessage,
      statusCode: TestConstants.timeoutStatusCode,
    );
    notFoundDioException = DioException(
      requestOptions: RequestOptions(path: TestConstants.notFoundRoute),
      response: notFoundDioResponse,
    );
    forbiddenDioException = DioException(
      requestOptions: RequestOptions(path: TestConstants.notFoundRoute),
      response: forbiddenDioResponse,
      type: DioExceptionType.badResponse,
    );
    timeoutException = DioException(
      requestOptions: RequestOptions(path: TestConstants.notFoundRoute),
      response: timeoutDioResponse,
      type: DioExceptionType.badResponse,
    );
  });

  setUp(() {
    mockAuthRetrofitClient = MockAuthRetrofitClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthRetrofitClient);
  });

  group("AuthRemoteDataSourceImpl Tests", () {
    test(
      "register should call AuthRetrofitClient.register with correct data and return response",
      () async {
        // Arrange
        final requestDto = RegisterRequestDto(
          firstName: "Ahmed",
          lastName: "Abdelghany",
          email: "Ahmed.Abdelghany@example.com",
          password: "Ahmed@123",
          rePassword: "Ahmed@123",
          gender: "male",
          height: 180,
          weight: 75,
          age: 25,
          goal: "Lose Weight",
          activityLevel: "Active",
        );

        final responseDto = RegisterResponseDto(
          message: "Registration successful",
          token: "fake_token_123",
          user: User(
            firstName: "Ahmed",
            lastName: "Abdelghany",
            email: "Ahmed.Abdelghany@example.com",
            gender: "male",
            age: 25,
            weight: 75,
            height: 180,
            activityLevel: "Active",
            goal: "Lose Weight",
            photo: "user_photo_url",
            id: "user_id_123",
            createdAt: "2025-06-18T00:00:00Z",
          ),
        );

        when(
          mockAuthRetrofitClient.register(requestDto),
        ).thenAnswer((_) async => responseDto);

        // Act
        final result = await authRemoteDataSourceImpl.register(requestDto);

        // Assert
        verify(mockAuthRetrofitClient.register(requestDto)).called(1);
        expect(result, isA<RegisterResponseDto>());
        expect(result.message, equals("Registration successful"));
        expect(result.user?.email, equals("Ahmed.Abdelghany@example.com"));
        expect(result.token, equals("fake_token_123"));
      },
    );
  });

  group('forgetPassword', () {
    test(
      'should return ForgetPasswordResponseDto when API call is successful',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).thenAnswer((_) async => forgetPasswordSuccessResponse);

        // Act
        final result = await authRemoteDataSourceImpl.forgetPassword(
          forgetPasswordRequest,
        );

        // Assert
        expect(result, equals(forgetPasswordSuccessResponse));
        verify(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).called(1);
      },
    );

    test(
      'should throw DioException when API call fails with 404 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).thenThrow(notFoundDioException);

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.forgetPassword(forgetPasswordRequest),
          throwsA(isA<DioException>()),
        );
        verify(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).called(1);
      },
    );

    test(
      'should throw Exception when API call fails with unknown error',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).thenThrow(Exception(unknownErrorMessage));

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.forgetPassword(forgetPasswordRequest),
          throwsA(predicate((e) => e.toString().contains(unknownErrorMessage))),
        );
        verify(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).called(1);
      },
    );

    test(
      'should throw DioException with badResponse type when API call fails with 403 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).thenThrow(forbiddenDioException);

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.forgetPassword(forgetPasswordRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.type,
              'type',
              DioExceptionType.badResponse,
            ),
          ),
        );
        verify(
          mockAuthRetrofitClient.forgetPassword(forgetPasswordRequest),
        ).called(1);
      },
    );
  });

  group('verifyOtp', () {
    test(
      'should return OtpVerificationResponseDto when API call is successful',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).thenAnswer((_) async => otpVerificationSuccessResponse);

        // Act
        final result = await authRemoteDataSourceImpl.verifyOtp(
          otpVerificationRequest,
        );

        // Assert
        expect(result, equals(otpVerificationSuccessResponse));
        verify(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).called(1);
      },
    );

    test(
      'should throw DioException when API call fails with 404 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).thenThrow(notFoundDioException);

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.verifyOtp(otpVerificationRequest),
          throwsA(isA<DioException>()),
        );
        verify(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).called(1);
      },
    );

    test(
      'should throw Exception when API call fails with unknown error',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).thenThrow(Exception(unknownErrorMessage));

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.verifyOtp(otpVerificationRequest),
          throwsA(predicate((e) => e.toString().contains(unknownErrorMessage))),
        );
        verify(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).called(1);
      },
    );

    test(
      'should throw DioException with badResponse type when API call fails with 403 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).thenThrow(forbiddenDioException);

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.verifyOtp(otpVerificationRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.type,
              'type',
              DioExceptionType.badResponse,
            ),
          ),
        );
        verify(
          mockAuthRetrofitClient.verifyOtp(otpVerificationRequest),
        ).called(1);
      },
    );
  });

  group('resetPassword', () {
    test(
      'should return ResetPasswordResponseDto when API call is successful',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).thenAnswer((_) async => resetPasswordSuccessResponse);

        // Act
        final result = await authRemoteDataSourceImpl.resetPassword(
          resetPasswordRequest,
        );

        // Assert
        expect(result, equals(resetPasswordSuccessResponse));
        verify(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).called(1);
      },
    );

    test(
      'should throw DioException(Timeout) when API call fails with 408 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).thenThrow(timeoutException);

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.resetPassword(resetPasswordRequest),
          throwsA(isA<DioException>()),
        );
        verify(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).called(1);
      },
    );

    test(
      'should throw Exception when API call fails with unknown error',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).thenThrow(Exception(unknownErrorMessage));

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.resetPassword(resetPasswordRequest),
          throwsA(predicate((e) => e.toString().contains(unknownErrorMessage))),
        );
        verify(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).called(1);
      },
    );

    test(
      'should throw DioException(Forbidden) with badResponse type when API call fails with 403 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).thenThrow(forbiddenDioException);

        // Act & Assert
        expect(
          () => authRemoteDataSourceImpl.resetPassword(resetPasswordRequest),
          throwsA(
            isA<DioException>().having(
              (e) => e.type,
              'type',
              DioExceptionType.badResponse,
            ),
          ),
        );
        verify(
          mockAuthRetrofitClient.resetPassword(resetPasswordRequest),
        ).called(1);
      },
    );
  });
}
