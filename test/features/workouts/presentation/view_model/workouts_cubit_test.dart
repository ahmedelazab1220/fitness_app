import 'package:fitness_app/domain/workouts/use_case/get_all_muscle_groups_use_case.dart';
import 'package:fitness_app/domain/workouts/use_case/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workouts_cubit.dart';
import 'package:fitness_app/features/workouts/presentation/view_model/workouts_state.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/workouts/entity/msucles_group_entity.dart';
import 'package:fitness_app/domain/workouts/entity/muscles_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'workouts_cubit_test.mocks.dart';

@GenerateMocks([GetAllMuscleGroupsUseCase, GetAllMusclesByMuscleGroupUseCase])
void main() {
  late MockGetAllMuscleGroupsUseCase mockGetAllMuscleGroupsUseCase;
  late MockGetAllMusclesByMuscleGroupUseCase
  mockGetAllMusclesByMuscleGroupUseCase;
  late WorkoutsCubit workoutsCubit;

  setUp(() {
    mockGetAllMuscleGroupsUseCase = MockGetAllMuscleGroupsUseCase();
    mockGetAllMusclesByMuscleGroupUseCase =
        MockGetAllMusclesByMuscleGroupUseCase();
    workoutsCubit = WorkoutsCubit(
      mockGetAllMuscleGroupsUseCase,
      mockGetAllMusclesByMuscleGroupUseCase,
    );
  });

  tearDown(() => workoutsCubit.close());

  test(
    'initial state has BaseInitialState for both muscleGroups and muscles',
    () {
      expect(workoutsCubit.state.muscleGroupsState, isA<BaseInitialState>());
      expect(workoutsCubit.state.musclesState, isA<BaseInitialState>());
    },
  );

  group('GetAllMuscleGroupsAction', () {
    test('emits loading then success on use case success', () async {
      provideDummy<Result<List<MusclesGroupEntity>>>(
        SuccessResult<List<MusclesGroupEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final groups = [MusclesGroupEntity(id: '1', name: 'Arms')];
      when(
        mockGetAllMuscleGroupsUseCase(),
      ).thenAnswer((_) async => SuccessResult(groups));

      final expected = [
        predicate<WorkoutsState>(
          (state) => state.muscleGroupsState is BaseLoadingState,
        ),
        predicate<WorkoutsState>(
          (state) =>
              state.muscleGroupsState is BaseSuccessState &&
              (state.muscleGroupsState
                          as BaseSuccessState<List<MusclesGroupEntity>>)
                      .data ==
                  groups,
        ),
      ];
      expectLater(workoutsCubit.stream, emitsInOrder(expected));

      workoutsCubit.doIntent(GetAllMuscleGroupsAction());
    });

    test('emits loading then error on use case failure', () async {
      provideDummy<Result<List<MusclesGroupEntity>>>(
        SuccessResult<List<MusclesGroupEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final exception = Exception('Use case error');
      when(mockGetAllMuscleGroupsUseCase()).thenAnswer(
        (_) async => FailureResult<List<MusclesGroupEntity>>(exception),
      );

      final expected = [
        predicate<WorkoutsState>(
          (state) => state.muscleGroupsState is BaseLoadingState,
        ),
        predicate<WorkoutsState>(
          (state) =>
              state.muscleGroupsState is BaseErrorState &&
              (state.muscleGroupsState as BaseErrorState).errorMessage.contains(
                'Exception',
              ),
        ),
      ];
      expectLater(workoutsCubit.stream, emitsInOrder(expected));

      workoutsCubit.doIntent(GetAllMuscleGroupsAction());
    });
  });

  group('GetAllMusclesByMuscleGroupAction', () {
    const muscleGroupId = 'group-123';

    test('emits loading then success on use case success', () async {
      provideDummy<Result<List<MusclesEntity>>>(
        SuccessResult<List<MusclesEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final muscles = [MusclesEntity(id: 'm1', name: 'Biceps')];
      when(
        mockGetAllMusclesByMuscleGroupUseCase(muscleGroupId),
      ).thenAnswer((_) async => SuccessResult(muscles));

      final expected = [
        predicate<WorkoutsState>(
          (state) => state.musclesState is BaseLoadingState,
        ),
        predicate<WorkoutsState>(
          (state) =>
              state.musclesState is BaseSuccessState &&
              (state.musclesState as BaseSuccessState<List<MusclesEntity>>)
                      .data ==
                  muscles,
        ),
      ];
      expectLater(workoutsCubit.stream, emitsInOrder(expected));

      workoutsCubit.doIntent(GetAllMusclesByMuscleGroupAction(muscleGroupId));
    });

    test('emits loading then error on use case failure', () async {
      provideDummy<Result<List<MusclesEntity>>>(
        SuccessResult<List<MusclesEntity>>([]),
      );
      provideDummy<Result<dynamic>>(SuccessResult<void>(null));

      final exception = Exception('Use case error');
      when(
        mockGetAllMusclesByMuscleGroupUseCase(muscleGroupId),
      ).thenAnswer((_) async => FailureResult<List<MusclesEntity>>(exception));

      final expected = [
        predicate<WorkoutsState>(
          (state) => state.musclesState is BaseLoadingState,
        ),
        predicate<WorkoutsState>(
          (state) =>
              state.musclesState is BaseErrorState &&
              (state.musclesState as BaseErrorState).errorMessage.contains(
                'Exception',
              ),
        ),
      ];
      expectLater(workoutsCubit.stream, emitsInOrder(expected));

      workoutsCubit.doIntent(GetAllMusclesByMuscleGroupAction(muscleGroupId));
    });
  });

  // group('SelectWorkoutTabAction', () {
  //   const muscleGroupId = 'group-123';
  //
  //   test(
  //     'triggers getAllMusclesByMuscleGroup and updates selectedIndex',
  //     () async {
  //       // Provide dummy for generics
  //       provideDummy<Result<List<MusclesGroupEntity>>>(
  //         SuccessResult<List<MusclesGroupEntity>>([]),
  //       );
  //       provideDummy<Result<dynamic>>(SuccessResult<void>(null));
  //       provideDummy<Result<List<MusclesEntity>>>(
  //         SuccessResult<List<MusclesEntity>>([]),
  //       );
  //
  //       // stub initial muscle groups
  //       final groups = [MusclesGroupEntity(id: muscleGroupId, name: 'Arms')];
  //       when(
  //         mockGetAllMuscleGroupsUseCase(),
  //       ).thenAnswer((_) async => SuccessResult(groups));
  //
  //       // stub muscles fetch
  //       final muscles = [MusclesEntity(id: 'm1', name: 'Biceps')];
  //       when(
  //         mockGetAllMusclesByMuscleGroupUseCase(muscleGroupId),
  //       ).thenAnswer((_) async => SuccessResult(muscles));
  //
  //       final expected = <dynamic>[
  //         // muscleGroups load
  //         predicate<WorkoutsState>(
  //           (state) => state.muscleGroupsState is BaseLoadingState,
  //         ),
  //         predicate<WorkoutsState>(
  //           (state) => state.muscleGroupsState is BaseSuccessState,
  //         ),
  //         // on select
  //         predicate<WorkoutsState>(
  //           (state) => state.musclesState is BaseLoadingState,
  //         ),
  //         predicate<WorkoutsState>(
  //           (state) => state.musclesState is BaseSuccessState,
  //         ),
  //         predicate<WorkoutsState>((state) => state.selectedIndex == 0),
  //       ];
  //       expectLater(workoutsCubit.stream, emitsInOrder(expected));
  //
  //       // 1) load groups
  //       workoutsCubit.doIntent(GetAllMuscleGroupsAction());
  //       await untilCalled(mockGetAllMuscleGroupsUseCase());
  //
  //       // 2) select tab 0
  //       workoutsCubit.doIntent(SelectWorkoutTabAction(0));
  //     },
  //   );
  // });
}
