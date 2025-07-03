import 'package:fitness_app/features/excercise/view/widgets/tab_bar_and_description.dart';
import 'package:flutter/material.dart';
import '../../../../data/excercise/model/response/muscles_dto.dart';
import 'excercise_image.dart';
import 'excercise_section.dart';

class ExcerciseDetailsBody extends StatelessWidget {
  final MusclesDto muscleData;
  const ExcerciseDetailsBody({super.key, required this.muscleData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExcerciseImage(muscleData: muscleData),
          TabBarAndDescription(muscleData: muscleData),
          const ExcerciseSection(),
        ],
      ),
    );
  }
}
