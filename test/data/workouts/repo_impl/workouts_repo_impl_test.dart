import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/workouts/data_source/contract/workouts_remote_data_source.dart';
import 'package:fitness_app/data/workouts/models/muscles_group_dto.dart';
import 'package:fitness_app/data/workouts/models/muscles_dto.dart';
import 'package:fitness_app/data/workouts/models/muscles_response_dto.dart';
import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';
import 'package:fitness_app/data/workouts/repo_impl/workouts_repo_impl.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workouts_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, WorkoutsRemoteDataSource])
void main() {
  late WorkoutsRepoImpl workoutsRepoImpl;
  late MockWorkoutsRemoteDataSource mockWorkoutsRemoteDataSource;
  late MockApiManager mockApiManager;

  setUp(() {
    mockWorkoutsRemoteDataSource = MockWorkoutsRemoteDataSource();
    mockApiManager = MockApiManager();
    workoutsRepoImpl = WorkoutsRepoImpl(
      mockWorkoutsRemoteDataSource,
      mockApiManager,
    );
  });

  group('WorkoutsRepoImpl Tests', () {
    group('getAllMuscleGroups', () {
      test(
        'returns SuccessResult<List<MusclesGroupEntity>> on success',
        () async {
          // prepare dto & expected data
          final dto = WorkoutsResponseDto(
            musclesGroup: [MusclesGroupDto(id: '1', name: 'Arms')],
          );
          final expectedEntities = [MusclesGroupEntity(id: '1', name: 'Arms')];

          // Register dummy for generics
          provideDummy<Result<List<MusclesGroupEntity>>>(
            SuccessResult<List<MusclesGroupEntity>>(expectedEntities),
          );

          // Stub ApiManager to return success
          when(
            mockApiManager.execute<List<MusclesGroupEntity>>(any),
          ).thenAnswer(
            (_) async =>
                SuccessResult<List<MusclesGroupEntity>>(expectedEntities),
          );

          // Stub Remote Data Source to return DTO
          when(
            mockWorkoutsRemoteDataSource.getAllMuscleGroups(),
          ).thenAnswer((_) async => dto);

          // Act
          final result = await workoutsRepoImpl.getAllMuscleGroups();

          // Assert
          verify(
            mockApiManager.execute<List<MusclesGroupEntity>>(any),
          ).called(1);
          expect(result, isA<SuccessResult<List<MusclesGroupEntity>>>());
        },
      );

      test(
        'returns FailureResult<List<MusclesGroupEntity>> on failure',
        () async {
          final error = Exception('API error');

          // Register dummy for generics
          provideDummy<Result<List<MusclesGroupEntity>>>(
            FailureResult<List<MusclesGroupEntity>>(error),
          );

          // Stub ApiManager to return failure
          when(
            mockApiManager.execute<List<MusclesGroupEntity>>(any),
          ).thenAnswer(
            (_) async => FailureResult<List<MusclesGroupEntity>>(error),
          );

          // Stub Remote Data Source to still return a DTO
          when(mockWorkoutsRemoteDataSource.getAllMuscleGroups()).thenAnswer(
            (_) async => WorkoutsResponseDto(
              musclesGroup: [MusclesGroupDto(id: '1', name: 'Arms')],
            ),
          );

          // Act
          final result = await workoutsRepoImpl.getAllMuscleGroups();

          // Assert
          verify(
            mockApiManager.execute<List<MusclesGroupEntity>>(any),
          ).called(1);
          expect(result, isA<FailureResult<List<MusclesGroupEntity>>>());
        },
      );
    });

    group('getAllMusclesByMuscleGroup', () {
      const muscleGroupId = 'group-123';

      test('returns SuccessResult<List<MusclesEntity>> on success', () async {
        // prepare dto & expected data
        final dto = MusclesResponseDto(
          muscles: [MusclesDto(id: 'm1', name: 'Biceps')],
        );
        final expectedEntities = [MusclesEntity(id: 'm1', name: 'Biceps')];

        // Register dummy for generics
        provideDummy<Result<List<MusclesEntity>>>(
          SuccessResult<List<MusclesEntity>>(expectedEntities),
        );

        // Stub ApiManager to return success
        when(mockApiManager.execute<List<MusclesEntity>>(any)).thenAnswer(
          (_) async => SuccessResult<List<MusclesEntity>>(expectedEntities),
        );

        // Stub Remote Data Source to return DTO
        when(
          mockWorkoutsRemoteDataSource.getAllMusclesByMuscleGroup(
            muscleGroupId,
          ),
        ).thenAnswer((_) async => dto);

        // Act
        final result = await workoutsRepoImpl.getAllMusclesByMuscleGroup(
          muscleGroupId,
        );

        // Assert
        verify(mockApiManager.execute<List<MusclesEntity>>(any)).called(1);
        expect(result, isA<SuccessResult<List<MusclesEntity>>>());
      });

      test('returns FailureResult<List<MusclesEntity>> on failure', () async {
        final error = Exception('API error');

        // Register dummy for generics
        provideDummy<Result<List<MusclesEntity>>>(
          FailureResult<List<MusclesEntity>>(error),
        );

        // Stub ApiManager to return failure
        when(
          mockApiManager.execute<List<MusclesEntity>>(any),
        ).thenAnswer((_) async => FailureResult<List<MusclesEntity>>(error));

        // Stub Remote Data Source to still return a DTO
        when(
          mockWorkoutsRemoteDataSource.getAllMusclesByMuscleGroup(
            muscleGroupId,
          ),
        ).thenAnswer(
          (_) async => MusclesResponseDto(
            muscles: [MusclesDto(id: 'm1', name: 'Biceps')],
          ),
        );

        // Act
        final result = await workoutsRepoImpl.getAllMusclesByMuscleGroup(
          muscleGroupId,
        );

        // Assert
        verify(mockApiManager.execute<List<MusclesEntity>>(any)).called(1);
        expect(result, isA<FailureResult<List<MusclesEntity>>>());
      });
    });
  });
}
