import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../domain/meals/entity/meal_details_entity.dart';
import '../view_model/cubit/meal_details_state.dart';
import '../view_model/cubit/meals_details_cubit.dart';
import 'widgets/ingredient_body.dart';
import 'widgets/meal_header_video.dart';
import 'widgets/nutrient_body.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;

  const MealDetailsScreen({super.key, required this.mealId});

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
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    if (meal.hasYoutubeVideo)
                      MealHeaderVideo(
                        videoUrl: meal.strYoutube!,
                        fallbackImage: meal.strMealThumb,
                      )
                    else
                      Image.network(meal.strMealThumb),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              meal.strMeal,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              meal.strInstructions,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            NutrientBody(nutrients: meal.nutrients),
                            const SizedBox(height: 24),
                            IngredientBody(meal: meal),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
