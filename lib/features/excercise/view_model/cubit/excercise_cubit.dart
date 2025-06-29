import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'excercise_state.dart';

class ExcerciseCubit extends Cubit<ExcerciseState> {
  ExcerciseCubit() : super(ExcerciseInitial());
}
