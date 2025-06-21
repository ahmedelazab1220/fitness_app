import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/workouts/view_model/workouts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../domain/workouts/entity/exercise_entity.dart';
import '../../view_model/workouts_cubit.dart';
import '../../../../core/utils/shared_widgets/grid_item.dart';

class WorkoutsGrid extends StatelessWidget {
  const WorkoutsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkoutsCubit>();
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      builder: (context, state) {
        final exerciseState = state.exerciseState;
        final isError = exerciseState is BaseErrorState;
        if (isError) {
          return Center(
            child: Text(
              (exerciseState).errorMessage,
              style: const TextStyle(color: AppColors.red),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          final isLoading = exerciseState is BaseLoadingState;
          final exercises =
              exerciseState is BaseSuccessState<List<ExerciseEntity>>
              ? exerciseState.data!
              : List.generate(
                  6,
                  (index) => ExerciseEntity(exercise: LocaleKeys.Loading.tr()),
                );
          final filteredExercises = state.filteredExercises;
          if (filteredExercises.isEmpty && !isLoading) {
            return Center(child: Text(LocaleKeys.NoExerciseFound.tr()));
          }
          return GridView.builder(
            itemCount: isLoading ? 6 : filteredExercises.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final exercise = isLoading
                  ? exercises[index]
                  : filteredExercises[index];
              final thumbnailUrl = cubit.getYoutubeThumbnail(
                exercise.shortYoutubeDemonstrationLink,
              );
              return Skeletonizer(
                enabled: isLoading,
                child: GridItem(
                  title: exercise.exercise!,
                  imageUrl: thumbnailUrl,
                  onTap: () {},
                ),
              );
            },
          );
        }
      },
    );
  }
}
