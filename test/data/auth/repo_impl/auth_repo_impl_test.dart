import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/data/auth/models/user_dto.dart';
import 'package:fitness_app/data/auth/repo_impl/auth_repo_impl.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, AuthRemoteDataSource])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockApiManager mockApiManager;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockApiManager = MockApiManager();
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepoImpl = AuthRepoImpl(mockApiManager, mockAuthRemoteDataSource);
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
}
