import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/excercise/model/request/difficulty_levels_request_dto.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/excercise/model/request/exercise_request_dto.dart';
import '../../../../data/excercise/model/response/difficulty_levels_response_dto.dart';
import '../../../../data/excercise/model/response/exercises_dto.dart';
import '../../../../domain/excercise/use_case/get_difficulty_levels_by_muscle_id_use_case.dart';
import '../../../../domain/excercise/use_case/get_exercises_details_use_case.dart';
import 'excercise_state.dart';

@injectable
class ExcerciseCubit extends Cubit<ExcerciseState> {
  final GetDifficultyLevelsByMuscleIdUseCase _getLevelsUseCase;
  final GetExercisesDetailsUseCase _getExercisesUseCase;

  List<ExercisesDto>? data = [];

  ExcerciseCubit(this._getLevelsUseCase, this._getExercisesUseCase)
    : super(
        ExcerciseState(
          difficultyState: BaseInitialState(),
          exerciseState: BaseInitialState(),
          selectedLevelIndex: 0,
        ),
      );

  void doIntent(ExcerciseAction action) {
    switch (action.runtimeType) {
      case GetDifficultyLevelsAction:
        _loadLevels((action as GetDifficultyLevelsAction).muscleId);
        break;
      case GetExcerciseAction:
        final a = action as GetExcerciseAction;
        _loadExercises(a.muscleId, a.difficultyId);
        break;
      case SelectLevelAction:
        final a = action as SelectLevelAction;
        _onLevelSelected(a.index, a.muscleId);
        break;
    }
  }

  Future<void> _loadLevels(String muscleId) async {
    emit(state.copyWith(difficultyState: BaseLoadingState()));
    final result = await _getLevelsUseCase(
      DifficultyLevelsRequestDto(muscleId: muscleId),
    );

    if (result is SuccessResult<DifficultyLevelsResponseDto>) {
      final dto = result.data;
      emit(
        state.copyWith(
          difficultyState: BaseSuccessState(data: dto),
          selectedLevelIndex: 0,
        ),
      );
      final defaultId = dto.difficultyLevels!.first.id ?? '';
      await _loadExercises(muscleId, defaultId);
    } else if (result is FailureResult<DifficultyLevelsResponseDto>) {
      emit(
        state.copyWith(
          difficultyState: BaseErrorState(
            errorMessage: result.exception.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _loadExercises(String muscleId, String difficultyId) async {
    emit(state.copyWith(exerciseState: BaseLoadingState()));
    final result = await _getExercisesUseCase(
      ExerciseRequestDto(muscleId: muscleId, difficultyId: difficultyId),
    );

    if (result is SuccessResult<ExercisesResponseDto>) {
      data = result.data.exercises;
      emit(state.copyWith(exerciseState: BaseSuccessState()));
    } else if (result is FailureResult<ExercisesResponseDto>) {
      emit(
        state.copyWith(
          exerciseState: BaseErrorState(
            errorMessage: result.exception.toString(),
          ),
        ),
      );
    }
  }

  void _onLevelSelected(int index, String muscleId) {
    if (state.difficultyState
        is! BaseSuccessState<DifficultyLevelsResponseDto>) {
      return;
    }

    final dto =
        (state.difficultyState as BaseSuccessState<DifficultyLevelsResponseDto>)
            .data!;
    final selectedId = dto.difficultyLevels![index].id ?? '';

    if (index != state.selectedLevelIndex) {
      emit(state.copyWith(selectedLevelIndex: index));
      _loadExercises(muscleId, selectedId);
    }
  }
}
