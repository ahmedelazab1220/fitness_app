import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/main_layout/presentation/view_model/cubit/main_layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../domain/home/entity/muscle_group_entity.dart';

class BuildListOfButtonsItem extends StatelessWidget {
  const BuildListOfButtonsItem({super.key, required this.listOfMuscles});

  final List<MuscleGroupEntity>? listOfMuscles;

  @override
  Widget build(BuildContext context) {
    final isLoading = listOfMuscles == null;
    final itemCount = isLoading ? 5 : listOfMuscles!.length;

    return SizedBox(
      height: 35.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final muscleName = isLoading
              ? LocaleKeys.Loading.tr()
              : listOfMuscles![index].name;
          return ElevatedButton(
            onPressed: () {
              context.read<MainLayoutCubit>().doIntent(
                ChangeTabWithWorkoutIndex(MainLayoutTabs.workouts, index),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: index == 0
                  ? AppColors.orange
                  : AppColors.darkgrey.withAlpha(25),
              padding: const EdgeInsets.all(8.0),
              textStyle: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
            child: Text(muscleName ?? ''),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        itemCount: itemCount,
      ),
    );
  }
}
