import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:fitness_app/data/auth/models/request/register_request_dto.dart';
import 'package:fitness_app/data/auth/models/response/register_response_dto.dart';
import 'package:fitness_app/data/auth/models/response/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthRetrofitClient])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthRetrofitClient mockAuthRetrofitClient;

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
}
