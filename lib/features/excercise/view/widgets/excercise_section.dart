import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../view_model/cubit/excercise_cubit.dart';
import '../../view_model/cubit/excercise_state.dart';
import 'excercises.dart';

class ExcerciseSection extends StatelessWidget {
  const ExcerciseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExcerciseCubit, ExcerciseState>(
      builder: (context, state) {
        final exState = state.exerciseState;
        if (exState is BaseLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (exState is BaseErrorState) {
          return Center(
            child: Text(
              exState.errorMessage,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        }
        final list = exState is BaseSuccessState
            ? context.read<ExcerciseCubit>().data
            : [];
        return Excercises(list: list);
      },
    );
  }
}
