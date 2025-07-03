import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/features/excercise/view/widgets/background_image_view.dart';
import 'package:fitness_app/features/excercise/view/widgets/excercise_details_body.dart';

import 'package:fitness_app/features/excercise/view_model/cubit/excercise_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/excercise/model/response/muscles_dto.dart';
import '../view_model/cubit/excercise_state.dart';

class ExcerciseDetailsScreen extends StatelessWidget {
  final MusclesDto muscleData;

  const ExcerciseDetailsScreen({Key? key, required this.muscleData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final viewModel = getIt<ExcerciseCubit>()
          ..doIntent(GetDifficultyLevelsAction(muscleId: muscleData.id ?? ""));
        return viewModel;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImageView(),
            ExcerciseDetailsBody(muscleData: muscleData),
          ],
        ),
      ),
    );
  }
}
