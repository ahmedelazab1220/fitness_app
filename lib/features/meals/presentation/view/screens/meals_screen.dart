import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/utils/di/di.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/meals_cubit.dart';
import '../../view_model/meals_state.dart';
import '../widgets/meals_body.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  late final MealsCubit viewModel;

  @override
  void initState() {
    viewModel = getIt<MealsCubit>();
    viewModel.doIntent(GetCategoriesAction());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            LocaleKeys.FoodRecommendation.tr(),
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
            child: MealsBody(),
          ),
        ),
      ),
    );
  }
}
