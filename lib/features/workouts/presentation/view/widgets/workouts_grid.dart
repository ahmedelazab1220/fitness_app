import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/grid_item.dart';
import '../../../../../domain/workouts/entity/exercise_entity.dart';
import '../../../../../domain/workouts/entity/msucles_group_entity.dart';
import '../../view_model/workouts_cubit.dart';
import '../../view_model/workouts_state.dart';

class WorkoutsGrid extends StatelessWidget {
  const WorkoutsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkoutsCubit>();
    return BlocConsumer<WorkoutsCubit, WorkoutsState>(
      listenWhen: (previous, current) {
        return previous.workoutsState
                is! BaseSuccessState<List<MusclesGroupEntity>> &&
            current.workoutsState is BaseSuccessState<List<MusclesGroupEntity>>;
      },
      listener: (context, state) {
        final muscleGroups =
            (state.workoutsState as BaseSuccessState<List<MusclesGroupEntity>>)
                .data!;
        if (muscleGroups.isNotEmpty) {
          cubit.doIntent(GetAllExercisesAction());
        }
      },
      builder: (context, state) {
        final workoutsState = state.workoutsState;
        final exerciseState = state.exerciseState;
        final isError = exerciseState is BaseErrorState;
        if (isError) {
          return Center(
            child: Text(
              (exerciseState).errorMessage,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        } else {
          final isLoading =
              exerciseState is BaseLoadingState ||
              workoutsState is BaseLoadingState;
          final exercises =
              exerciseState is BaseSuccessState<List<ExerciseEntity>>
              ? state.filteredExercises
              : List.generate(
                  6,
                  (index) => ExerciseEntity(exercise: LocaleKeys.Loading.tr()),
                );
          if (exercises.isEmpty) {
            return Center(child: Text(LocaleKeys.NoExerciseFound.tr()));
          }
          return GridView.builder(
            itemCount: exercises.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final exercise = exercises[index];
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
