import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/assets/app_images.dart';
import '../../view_model/workouts_cubit.dart';
import '../../view_model/workouts_state.dart';
import '../widgets/workouts_body.dart';

class WorkoutsScreen extends StatelessWidget {
  final WorkoutsCubit workoutsCubit = getIt<WorkoutsCubit>();

  WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => workoutsCubit..doIntent(GetAllMuscleGroupsAction()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            LocaleKeys.Workouts.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundThree),
              fit: BoxFit.fill,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 115, left: 16, right: 16, bottom: 16),
            child: WorkoutsBody(),
          ),
        ),
      ),
    );
  }
}
