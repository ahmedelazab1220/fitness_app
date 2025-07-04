import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/grid_item.dart';
import '../../../../../domain/workouts/entity/msucles_group_entity.dart';
import '../../../../../domain/workouts/entity/muscles_entity.dart';
import '../../view_model/workouts_cubit.dart';
import '../../view_model/workouts_state.dart';

class WorkoutsGrid extends StatelessWidget {
  const WorkoutsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkoutsCubit>();
    return BlocConsumer<WorkoutsCubit, WorkoutsState>(
      listenWhen: (previous, current) {
        return previous.muscleGroupsState
                is! BaseSuccessState<List<MusclesGroupEntity>> &&
            current.muscleGroupsState
                is BaseSuccessState<List<MusclesGroupEntity>>;
      },
      listener: (context, state) {
        final muscleGroups =
            (state.muscleGroupsState
                    as BaseSuccessState<List<MusclesGroupEntity>>)
                .data!;
        if (muscleGroups.isNotEmpty) {
          cubit.doIntent(
            GetAllMusclesByMuscleGroupAction(
              muscleGroups[state.selectedIndex].id!,
            ),
          );
        }
      },
      builder: (context, state) {
        final muscleGroupsState = state.muscleGroupsState;
        final musclesState = state.musclesState;
        final isError = musclesState is BaseErrorState;
        if (isError) {
          return Center(
            child: Text(
              (musclesState).errorMessage,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        } else {
          final isLoading =
              musclesState is BaseLoadingState ||
              muscleGroupsState is BaseLoadingState;
          final muscles = musclesState is BaseSuccessState<List<MusclesEntity>>
              ? musclesState.data!
              : List.generate(
                  6,
                  (index) => MusclesEntity(name: LocaleKeys.Loading.tr()),
                );
          if (muscles.isEmpty) {
            return Center(child: Text(LocaleKeys.NoMusclesFound.tr()));
          }
          return GridView.builder(
            itemCount: muscles.length,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final muscle = muscles[index];
              return Skeletonizer(
                enabled: isLoading,
                child: GridItem(
                  title: muscle.name!,
                  imageUrl: muscle.image,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.exerciseDetailsRoute,
                      arguments: {'muscleData': muscle},
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
