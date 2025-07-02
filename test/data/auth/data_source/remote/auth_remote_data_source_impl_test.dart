import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import 'package:fitness_app/data/auth/models/user_dto.dart';
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

  group('Auth Remote Data Source Test', () {
    group('getProfileData', () {
      test(
        'should return UserDataResponseDto when API call is successful',
        () async {
          // Arrange
          final user = UserDto(
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
          final expectedResponse = UserDataResponseDto(
            message: 'Success',
            user: user,
          );
          when(
            mockAuthRetrofitClient.getProfileData(),
          ).thenAnswer((_) async => expectedResponse);

          // Act
          final result = await authRemoteDataSourceImpl.getProfileData();

          // Assert
          verify(mockAuthRetrofitClient.getProfileData()).called(1);
          expect(result, isA<UserDataResponseDto>());
        },
      );

      test('should throw exception when API fails', () {
        // Arrange
        final exception = Exception('API error');
        when(
          mockAuthRetrofitClient.getProfileData(),
        ).thenAnswer((_) async => throw exception);

        // Act
        final result = authRemoteDataSourceImpl.getProfileData();

        // Assert
        verify(mockAuthRetrofitClient.getProfileData()).called(1);
        expect(result, throwsA(isA<Exception>()));
      });
    });
  });
}
