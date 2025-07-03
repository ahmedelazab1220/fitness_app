import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/home_cubit.dart';
import 'build_category_list_items.dart';
import 'build_new_list_items.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<HomeCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundThree),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.HeyThere.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      LocaleKeys.LetUsStartYourDay.tr(),
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(fontSize: 18.0),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: CachedNetworkImageProvider(
                    Constants.fakeImage,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return BuildCategoryListItems(
                categories: viewModel.exerciseCategories,
              );
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return BuildNewListItems(
                category: LocaleKeys.RecommendationToDay.tr(),
                listOfItems: viewModel.dailyRecommendation,
              );
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return BuildNewListItems(
                category: LocaleKeys.UpcomingWorkouts.tr(),
                listOfItems: viewModel.upcomingWorkout,
                listOfButtons: true,
                listOfMuscles: viewModel.muscles,
              );
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return BuildNewListItems(
                category: LocaleKeys.RecommendationForYou.tr(),
                listOfItems: viewModel.foodRecommendation,
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 25.0)),
        ],
      ),
    );
  }
}
