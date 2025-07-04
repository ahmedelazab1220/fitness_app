import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/shared_widgets/blured_container.dart';
import '../../../../core/utils/shared_widgets/custom_tab_bar.dart';
import '../../../../data/excercise/model/response/difficulty_level_dto.dart';
import '../../../../data/excercise/model/response/difficulty_levels_response_dto.dart';
import '../../view_model/cubit/excercise_cubit.dart';
import '../../view_model/cubit/excercise_state.dart';

class TabBarAndDescription extends StatelessWidget {
  final muscleData;
  const TabBarAndDescription({super.key, this.muscleData});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: BluredContainer(
        child: Column(
          children: [
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              textAlign: TextAlign.center,
              style: AppTheme.appTheme.textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<ExcerciseCubit, ExcerciseState>(
              builder: (context, state) {
                final difficultyState = state.difficultyState;
                final isError = difficultyState is BaseErrorState;
                if (isError) {
                  return Center(
                    child: Text(
                      difficultyState.errorMessage,
                      style: const TextStyle(color: AppColors.red),
                    ),
                  );
                }
                final isLoading = difficultyState is BaseLoadingState;
                final levels =
                    difficultyState
                        is BaseSuccessState<DifficultyLevelsResponseDto>
                    ? difficultyState.data!.difficultyLevels
                    : List.generate(
                        3,
                        (index) =>
                            DifficultyLevelsDto(name: LocaleKeys.Loading.tr()),
                      );
                final tabs = levels?.map((l) => l.name ?? '').toList() ?? [];
                return Skeletonizer(
                  enabled: isLoading,
                  child: CustomTabBar(
                    tabs: tabs,
                    selectedIndex: state.selectedLevelIndex,
                    onTap: (i) => context.read<ExcerciseCubit>().doIntent(
                      SelectLevelAction(i, muscleData.id ?? ""),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
