import 'package:fitness_app/features/excercise/view/widgets/video_selector_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import 'image_exercise_selector.dart';

class ExcerciseItem extends StatelessWidget {
  final ex;
  const ExcerciseItem({super.key, this.ex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageExerciseSelector(exercise: ex),
        const SizedBox(width: 17),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ex.exercise.toString(),
                style: AppTheme.appTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                ex.targetMuscleGroup.toString(),
                style: AppTheme.appTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                ex.primaryEquipment.toString(),
                style: AppTheme.appTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        VideoSelectorWidget(exercise: ex),
      ],
    );
  }
}
