import 'package:fitness_app/domain/meals/entity/meal_entity.dart';
import 'package:fitness_app/features/details_food/presentation/view/widgets/meal_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../domain/meals/entity/meal_details_entity.dart';
import '../view_model/cubit/meal_details_state.dart';
import '../view_model/cubit/meal_details_cubit.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;
  final List<MealEntity> meals;

  const MealDetailsScreen({
    super.key,
    required this.mealId,
    required this.meals,
  });

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late final MealDetailsCubit viewModel;

  @override
  void initState() {
    viewModel = getIt<MealDetailsCubit>();
    viewModel.doIntent(GetMealDetailsAction(widget.mealId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          final status = state.mealDetailsStatus;
          if (status is BaseLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (status is BaseErrorState) {
            return Scaffold(body: Center(child: Text(status.errorMessage)));
          } else if (status is BaseSuccessState<MealDetailsEntity>) {
            final meal = status.data!;
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.backgroundThree),
                  fit: BoxFit.fill,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: MealDetailsBody(meal: meal, meals: widget.meals),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
