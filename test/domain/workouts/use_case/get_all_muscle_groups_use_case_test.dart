import 'package:fitness_app/domain/workouts/use_case/get_all_muscle_groups_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/repo/workouts_repo.dart';

import 'get_all_muscle_groups_use_case_test.mocks.dart';

@GenerateMocks([WorkoutsRepo])
void main() {
  late MockWorkoutsRepo mockWorkoutsRepo;
  late GetAllMuscleGroupsUseCase getAllMuscleGroupsUseCase;

  setUp(() {
    mockWorkoutsRepo = MockWorkoutsRepo();
    getAllMuscleGroupsUseCase = GetAllMuscleGroupsUseCase(mockWorkoutsRepo);
  });

  group('GetAllMuscleGroupsUseCase', () {
    test(
      'returns SuccessResult<List<MusclesGroupEntity>> when repository succeeds',
      () async {
        // Provide dummy for generics
        provideDummy<Result<List<MusclesGroupEntity>>>(
          SuccessResult<List<MusclesGroupEntity>>([]),
        );

        final muscleGroups = [MusclesGroupEntity(id: '1', name: 'Arms')];
        when(
          mockWorkoutsRepo.getAllMuscleGroups(),
        ).thenAnswer((_) async => SuccessResult(muscleGroups));

        final result = await getAllMuscleGroupsUseCase.call();

        verify(mockWorkoutsRepo.getAllMuscleGroups()).called(1);
        expect(result, isA<SuccessResult<List<MusclesGroupEntity>>>());
      },
    );

    test(
      'returns FailureResult<List<MusclesGroupEntity>> when repository fails',
      () async {
        final exception = Exception('Repo error');

        // Provide dummy for generics
        provideDummy<Result<List<MusclesGroupEntity>>>(
          FailureResult<List<MusclesGroupEntity>>(exception),
        );

        when(mockWorkoutsRepo.getAllMuscleGroups()).thenAnswer(
          (_) async => FailureResult<List<MusclesGroupEntity>>(exception),
        );

        final result = await getAllMuscleGroupsUseCase.call();

        verify(mockWorkoutsRepo.getAllMuscleGroups()).called(1);
        expect(result, isA<FailureResult<List<MusclesGroupEntity>>>());
      },
    );
  });
}
