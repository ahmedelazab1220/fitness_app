import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/shared_widgets/custom_tab_bar.dart';
import '../../../../../domain/workouts/entity/msucles_group_entity.dart';
import '../../view_model/workouts_cubit.dart';
import '../../view_model/workouts_state.dart';
import 'workouts_grid.dart';

class WorkoutsBody extends StatelessWidget {
  const WorkoutsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutsCubit, WorkoutsState>(
      builder: (context, state) {
        final cubit = context.read<WorkoutsCubit>();
        final workoutsState = state.workoutsState;
        final isError = workoutsState is BaseErrorState;
        if (isError) {
          return Center(
            child: Text(
              workoutsState.errorMessage,
              style: const TextStyle(color: AppColors.red),
            ),
          );
        }
        final isLoading = workoutsState is BaseLoadingState;
        final muscleGroups =
            workoutsState is BaseSuccessState<List<MusclesGroupEntity>>
            ? workoutsState.data!
            : List.generate(
                6,
                (index) => MusclesGroupEntity(name: LocaleKeys.Loading.tr()),
              );
        final tabs = muscleGroups.map((group) => group.name ?? '').toList();
        return Column(
          children: [
            Skeletonizer(
              enabled: isLoading,
              child: CustomTabBar(
                tabs: tabs,
                selectedIndex: state.selectedIndex,
                onTap: (index) => cubit.doIntent(SelectWorkoutTabAction(index)),
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(child: WorkoutsGrid()),
          ],
        );
      },
    );
  }
}
