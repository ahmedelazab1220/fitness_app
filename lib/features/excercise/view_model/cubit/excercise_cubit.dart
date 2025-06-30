import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/excercise/model/response/exercises_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/excercise/model/request/exercise_request_dto.dart';
import '../../../../data/excercise/model/response/exercises_dto.dart';
import '../../../../domain/excercise/use_case/get_exercises_details_use_case.dart';

part 'excercise_state.dart';

class ExcerciseCubit extends Cubit<ExcerciseState> {
  final GetExercisesDetailsUseCase _getExercisesDetailsUseCase;
  List<ExercisesDto>? data = [];
  ExcerciseCubit(this._getExercisesDetailsUseCase)
    : super(ExcerciseState(excerciseState: BaseInitialState()));

  void doIntent(ExcerciseAction action) {
    switch (action) {
      case GetExcerciseAction():
        _getExercisesByMuscleAndDifficulty(
          action.muscleId,
          action.difficultyId,
        );
    }
  }

  Future<void> _getExercisesByMuscleAndDifficulty(
    String muscleId,
    String difficultyId,
  ) async {
    emit(ExcerciseState(excerciseState: BaseLoadingState()));
    final result = await _getExercisesDetailsUseCase(
      ExerciseRequestDto(muscleId: muscleId, difficultyId: difficultyId),
    );
    switch (result) {
      case SuccessResult<ExercisesResponseDto>():
        final exercisesResponse = result.data;
        data = exercisesResponse.exercises;
        emit(ExcerciseState(excerciseState: BaseSuccessState(data: data)));
      case FailureResult<ExercisesResponseDto>():
        emit(
          ExcerciseState(
            excerciseState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }
}
