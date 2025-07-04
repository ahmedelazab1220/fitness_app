import 'package:fitness_app/domain/auth/repo/auth_repo.dart';
import 'package:fitness_app/domain/auth/use_case/get_profile_data_use_case.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_profile_data_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late GetProfileDataUseCase getProfileDataUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    getProfileDataUseCase = GetProfileDataUseCase(mockAuthRepo);
  });

  group('GetProfileDataUseCase', () {
    test(
      'returns SuccessResult<UserEntity> when repository succeeds',
      () async {
        // Arrange
        final user = UserEntity(
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
        provideDummy<Result<UserEntity>>(SuccessResult<UserEntity>(user));
        when(
          mockAuthRepo.getProfileData(),
        ).thenAnswer((_) async => SuccessResult<UserEntity>(user));

        // Act
        final result = await getProfileDataUseCase.call();

        // Assert
        verify(mockAuthRepo.getProfileData()).called(1);
        expect(result, isA<SuccessResult<UserEntity>>());
      },
    );

    test('returns FailureResult<UserEntity> when repository fails', () async {
      // Arrange
      final exception = Exception('Repo error');
      provideDummy<Result<UserEntity>>(FailureResult<UserEntity>(exception));
      when(
        mockAuthRepo.getProfileData(),
      ).thenAnswer((_) async => FailureResult<UserEntity>(exception));

      // Act
      final result = await getProfileDataUseCase.call();

      // Assert
      verify(mockAuthRepo.getProfileData()).called(1);
      expect(result, isA<FailureResult<UserEntity>>());
    });
  });
}
