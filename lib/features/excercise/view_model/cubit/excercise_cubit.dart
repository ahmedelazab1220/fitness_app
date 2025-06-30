import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'excercise_state.dart';

class ExcerciseCubit extends Cubit<ExcerciseState> {
  ExcerciseCubit() : super(ExcerciseState(excerciseState: BaseInitialState()));
}
