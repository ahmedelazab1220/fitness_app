import 'package:fitness_app/domain/workouts/use_case/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';

import 'get_all_muscles_by_muscle_group_use_case_test.mocks.dart';

@GenerateMocks([WorkoutsRepo])
void main() {
  late MockWorkoutsRepo mockWorkoutsRepo;
  late GetAllMusclesByMuscleGroupUseCase getAllMusclesByMuscleGroupUseCase;

  setUp(() {
    mockWorkoutsRepo = MockWorkoutsRepo();
    getAllMusclesByMuscleGroupUseCase = GetAllMusclesByMuscleGroupUseCase(
      mockWorkoutsRepo,
    );
  });

  group('GetAllMusclesByMuscleGroupUseCase', () {
    const muscleGroupId = 'group-123';

    test(
      'returns SuccessResult<List<MusclesEntity>> when repository succeeds',
      () async {
        // Provide dummy for generics
        provideDummy<Result<List<MusclesEntity>>>(
          SuccessResult<List<MusclesEntity>>([]),
        );

        final muscles = [MusclesEntity(id: 'm1', name: 'Biceps')];
        when(
          mockWorkoutsRepo.getAllMusclesByMuscleGroup(muscleGroupId),
        ).thenAnswer((_) async => SuccessResult(muscles));

        final result = await getAllMusclesByMuscleGroupUseCase.call(
          muscleGroupId,
        );

        verify(
          mockWorkoutsRepo.getAllMusclesByMuscleGroup(muscleGroupId),
        ).called(1);
        expect(result, isA<SuccessResult<List<MusclesEntity>>>());
      },
    );

    test(
      'returns FailureResult<List<MusclesEntity>> when repository fails',
      () async {
        final exception = Exception('Repo error');

        // Provide dummy for generics
        provideDummy<Result<List<MusclesEntity>>>(
          FailureResult<List<MusclesEntity>>(exception),
        );

        when(
          mockWorkoutsRepo.getAllMusclesByMuscleGroup(muscleGroupId),
        ).thenAnswer(
          (_) async => FailureResult<List<MusclesEntity>>(exception),
        );

        final result = await getAllMusclesByMuscleGroupUseCase.call(
          muscleGroupId,
        );

        verify(
          mockWorkoutsRepo.getAllMusclesByMuscleGroup(muscleGroupId),
        ).called(1);
        expect(result, isA<FailureResult<List<MusclesEntity>>>());
      },
    );
  });
}
