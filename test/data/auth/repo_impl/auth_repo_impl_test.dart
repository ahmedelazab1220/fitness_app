import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/data/auth/models/request/register_request_dto.dart';
import 'package:fitness_app/data/auth/models/response/register_response_dto.dart';
import 'package:fitness_app/data/auth/models/response/user.dart';
import 'package:fitness_app/data/auth/repo_impl/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, AuthRemoteDataSource])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockApiManager mockApiManager;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  // Provide dummy for generic dynamic results
  provideDummy<Result<dynamic>>(SuccessResult(null));
  provideDummy<Result<RegisterResponseDto>>(
    SuccessResult(
      RegisterResponseDto(
        message: "",
        token: "",
        user: User(
          firstName: "",
          lastName: "",
          email: "",
          gender: "",
          age: 0,
          weight: 0,
          height: 0,
          activityLevel: "",
          goal: "",
          photo: "",
          id: "",
          createdAt: "",
        ),
      ),
    ),
  );

  setUp(() {
    mockApiManager = MockApiManager();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDataSource, mockApiManager);
  });

  group("Auth Repo Test", () {
    test("Register Test", () async {
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

      when(mockAuthRemoteDataSource.register(requestDto)).thenAnswer(
        (_) async => RegisterResponseDto(
          message: "Registration successful",
          token: "dummy_token",
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
        ),
      );

      when(mockApiManager.execute(any)).thenAnswer((invocation) async {
        final fn =
            invocation.positionalArguments.first
                as Future<RegisterResponseDto> Function();
        final responseDto = await fn();
        return SuccessResult<RegisterResponseDto>(responseDto);
      });

      // Act
      final result = await authRepoImpl.register(requestDto);

      // Assert
      expect(result, isA<SuccessResult<RegisterResponseDto>>());
      if (result is SuccessResult<RegisterResponseDto>) {
        final data = result.data;
        expect(data.token, "dummy_token");
        expect(data.user?.email, "Ahmed.Abdelghany@example.com");
      }
    });
  });
}
