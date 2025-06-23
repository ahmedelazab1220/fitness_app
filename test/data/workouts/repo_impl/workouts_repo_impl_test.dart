import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/workouts/models/muscles_dto.dart';
import 'package:fitness_app/data/workouts/models/muscles_group_dto.dart';
import 'package:fitness_app/data/workouts/models/workouts_response_dto.dart';
import 'package:fitness_app/data/workouts/models/muscles_response_dto.dart';
import 'package:fitness_app/data/workouts/repo_impl/workouts_repo_impl.dart';
import 'package:fitness_app/data/workouts/data_source/contract/workouts_remote_data_source.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workouts_repo_impl_test.mocks.dart';

@GenerateMocks([ApiManager, WorkoutsRemoteDataSource])
void main() {
  late WorkoutsRepoImpl workoutsRepo;
  late MockWorkoutsRemoteDataSource mockRemote;
  late MockApiManager mockApiManager;

  setUp(() {
    mockRemote = MockWorkoutsRemoteDataSource();
    mockApiManager = MockApiManager();
    workoutsRepo = WorkoutsRepoImpl(mockRemote, mockApiManager);
  });

  group("WorkoutsRepoImpl Tests", () {
    group("getAllMuscleGroups", () {
      test("success Test", () async {
        provideDummy<Result<void>>(SuccessResult<void>(null));
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        // Arrange
        final dto = WorkoutsResponseDto(
          message: 'ok',
          musclesGroup: [MusclesGroupDto(id: '1', name: 'Chest')],
        );
        when(mockRemote.getAllMuscleGroups()).thenAnswer((_) async => dto);
        when(
          mockApiManager.execute(any),
        ).thenAnswer((_) async => SuccessResult<void>(null));

        // Act
        final result = await workoutsRepo.getAllMuscleGroups();

        // Assert
        expect(result, isA<SuccessResult<void>>());
      });

      test("failure Test", () async {
        provideDummy<Result<void>>(SuccessResult<void>(null));
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        // Arrange
        when(mockRemote.getAllMuscleGroups()).thenAnswer(
          (_) async => WorkoutsResponseDto(message: null, musclesGroup: []),
        );
        when(mockApiManager.execute(any)).thenAnswer(
          (_) async =>
              FailureResult<List<MusclesGroupEntity>>(Exception('API error')),
        );

        // Act
        final result = await workoutsRepo.getAllMuscleGroups();

        // Assert
        expect(result, isA<FailureResult<void>>());
      });
    });

    group("getAllMusclesByMuscleGroup", () {
      const muscleGroupId = '1';

      test("success Test", () async {
        provideDummy<Result<void>>(SuccessResult<void>(null));
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        // Arrange
        final dto = MusclesResponseDto(
          message: 'ok',
          muscleGroup: MusclesGroupDto(id: '1', name: 'Chest'),
          muscles: [MusclesDto(id: '10', name: 'Biceps', image: 'url')],
        );
        when(
          mockRemote.getAllMusclesByMuscleGroup(muscleGroupId),
        ).thenAnswer((_) async => dto);
        when(
          mockApiManager.execute(any),
        ).thenAnswer((_) async => SuccessResult<void>(null));

        // Act
        final result = await workoutsRepo.getAllMusclesByMuscleGroup(
          muscleGroupId,
        );

        // Assert
        expect(result, isA<SuccessResult<void>>());
      });

      test("failure Test", () async {
        provideDummy<Result<void>>(SuccessResult<void>(null));
        provideDummy<Result<dynamic>>(SuccessResult<void>(null));

        // Arrange
        when(mockRemote.getAllMusclesByMuscleGroup(muscleGroupId)).thenAnswer(
          (_) async =>
              MusclesResponseDto(message: null, muscleGroup: null, muscles: []),
        );
        when(mockApiManager.execute(any)).thenAnswer(
          (_) async =>
              FailureResult<List<MusclesEntity>>(Exception('API error')),
        );

        // Act
        final result = await workoutsRepo.getAllMusclesByMuscleGroup(
          muscleGroupId,
        );

        // Assert
        expect(result, isA<FailureResult<void>>());
      });
    });
  });
}
