import 'package:dio/dio.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_constants.dart';
import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:fitness_app/data/auth/models/forget_password/request/forget_password_request_dto.dart';
import 'package:fitness_app/data/auth/models/forget_password/response/forget_password_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_constants.dart';
import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRemoteDataSourceImpl authDataSource;
  late MockAuthRetrofitClient mockAuthRetrofitClient;

  // Test constants
  const testEmail = 'ahmed@example.com';
  const successMessage = 'Success';
  const successInfo = 'OTP Send To Your Email';
  const errorMessage = 'There is no account with this email address $testEmail';
  const forbiddenMessage = 'Forbidden Route';
  const unknownErrorMessage = 'Unknown Exception';

  // Test objects
  late ForgetPasswordRequestDto request;
  late ForgetPasswordResponseDto successResponse;
  late Map<String, dynamic> notFoundErrorResponse;
  late Response<dynamic> notFoundDioResponse;
  late Response<dynamic> forbiddenDioResponse;
  late DioException notFoundDioException;
  late DioException forbiddenDioException;

  setUpAll(() {
    request = ForgetPasswordRequestDto(email: testEmail);
    successResponse = ForgetPasswordResponseDto(
      message: successMessage,
      info: successInfo,
    );
    notFoundErrorResponse = {'error': errorMessage};
    notFoundDioResponse = Response(
      requestOptions: RequestOptions(path: ApiConstants.forgetPasswordRoute),
      data: notFoundErrorResponse,
      statusCode: TestConstants.notFoundStatusCode,
    );
    forbiddenDioResponse = Response(
      requestOptions: RequestOptions(path: ApiConstants.forgetPasswordRoute),
      data: forbiddenMessage,
      statusCode: TestConstants.forbiddenStatusCode,
    );
    notFoundDioException = DioException(
      requestOptions: RequestOptions(path: ApiConstants.forgetPasswordRoute),
      response: notFoundDioResponse,
    );
    forbiddenDioException = DioException(
      requestOptions: RequestOptions(path: ApiConstants.forgetPasswordRoute),
      response: forbiddenDioResponse,
      type: DioExceptionType.badResponse,
    );
  });

  setUp(() {
    mockAuthRetrofitClient = MockAuthRetrofitClient();
    authDataSource = AuthRemoteDataSourceImpl(mockAuthRetrofitClient);
  });

  group('forgetPassword', () {
    test(
      'should return ForgetPasswordResponseDto when API call is successful',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(request),
        ).thenAnswer((_) async => successResponse);

        // Act
        final result = await authDataSource.forgetPassword(request);

        // Assert
        expect(result, equals(successResponse));
        verify(mockAuthRetrofitClient.forgetPassword(request)).called(1);
      },
    );

    test(
      'should throw DioException when API call fails with 404 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(request),
        ).thenThrow(notFoundDioException);

        // Act & Assert
        expect(
          () => authDataSource.forgetPassword(request),
          throwsA(isA<DioException>()),
        );
        verify(mockAuthRetrofitClient.forgetPassword(request)).called(1);
      },
    );

    test(
      'should throw Exception when API call fails with unknown error',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(request),
        ).thenThrow(Exception(unknownErrorMessage));

        // Act & Assert
        expect(
          () => authDataSource.forgetPassword(request),
          throwsA(predicate((e) => e.toString().contains(unknownErrorMessage))),
        );
        verify(mockAuthRetrofitClient.forgetPassword(request)).called(1);
      },
    );

    test(
      'should throw DioException with badResponse type when API call fails with 403 status',
      () async {
        // Arrange
        when(
          mockAuthRetrofitClient.forgetPassword(request),
        ).thenThrow(forbiddenDioException);

        // Act & Assert
        expect(
          () => authDataSource.forgetPassword(request),
          throwsA(
            isA<DioException>().having(
              (e) => e.type,
              'type',
              DioExceptionType.badResponse,
            ),
          ),
        );
        verify(mockAuthRetrofitClient.forgetPassword(request)).called(1);
      },
    );
  });
}
