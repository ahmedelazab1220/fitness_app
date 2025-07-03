import 'package:equatable/equatable.dart';
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
  final GetExercisesDetailsUseCase _getExercisesDetailsUseCase;
  final GetDifficultyLevelsByMuscleIdUseCase
  _getDifficultyLevelsByMuscleIdUseCase;
  List<ExercisesDto>? data = [];
  ExcerciseCubit(
    this._getExercisesDetailsUseCase,
    this._getDifficultyLevelsByMuscleIdUseCase,
  ) : super(
        ExcerciseState(
          excerciseState: BaseInitialState(),
          difficultyState: BaseInitialState(),
        ),
      );

  void doIntent(ExcerciseAction action) {
    switch (action) {
      case GetExcerciseAction():
        _getExercisesByMuscleAndDifficulty(
          action.muscleId,
          action.difficultyId,
        );
      case GetDifficultyLevelsAction():
        _getDifficultyLevelsByMuscleId(action.muscleId);
      case SelectLevelAction():
        _selectLevel(action.index, action.muscleId);
    }
  }

  Future<void> _getExercisesByMuscleAndDifficulty(
    String muscleId,
    String difficultyId,
  ) async {
    emit(state.copyWith(excerciseState: BaseLoadingState()));
    final result = await _getExercisesDetailsUseCase(
      ExerciseRequestDto(muscleId: muscleId, difficultyId: difficultyId),
    );
    switch (result) {
      case SuccessResult<ExercisesResponseDto>():
        emit(state.copyWith(excerciseState: BaseSuccessState()));
        final exercisesResponse = result.data;
        data = exercisesResponse.exercises;
      case FailureResult<ExercisesResponseDto>():
        emit(
          state.copyWith(
            excerciseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _getDifficultyLevelsByMuscleId(String muscleId) async {
    emit(state.copyWith(difficultyState: BaseLoadingState()));
    final result = await _getDifficultyLevelsByMuscleIdUseCase(
      DifficultyLevelsRequestDto(muscleId: muscleId),
    );
    switch (result) {
      case SuccessResult<DifficultyLevelsResponseDto>():
        emit(
          state.copyWith(difficultyState: BaseSuccessState(data: result.data)),
        );
      case FailureResult<DifficultyLevelsResponseDto>():
        emit(
          state.copyWith(
            difficultyState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  void _selectLevel(int index, String muscleId) {
    if (index == state.selectedLevelIndex) return;
    final selectedLevel =
        (state.difficultyState as BaseSuccessState<DifficultyLevelsResponseDto>)
            .data
            ?.difficultyLevels![index];
    _getExercisesByMuscleAndDifficulty(muscleId, selectedLevel?.id ?? '');
    emit(state.copyWith(selectedLevelIndex: index));
  }
}
