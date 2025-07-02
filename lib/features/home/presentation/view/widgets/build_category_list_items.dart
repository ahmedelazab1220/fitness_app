import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/home_cubit.dart';
import 'category_item.dart';
import 'handler_error_widget.dart';

class BuildCategoryListItems extends StatelessWidget {
  const BuildCategoryListItems({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<HomeCubit>();
    var locale = context.locale;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.Category.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.darkgrey,
                ),
                child: state.getExerciseCategoriesState is BaseErrorState
                    ? const HandlerErrorWidget()
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final category = viewModel.exerciseCategories[index];
                          final title = locale.languageCode == Constants.en
                              ? category.titleEn ?? ''
                              : category.titleAr ?? '';
                          return CategoryItem(
                            title: title,
                            imageUrl: category.imageUrl ?? '',
                          );
                        },
                        separatorBuilder: (context, index) => VerticalDivider(
                          width: 2.0,
                          thickness: 1.5,
                          color: AppColors.white[AppColors.colorCode100],
                          indent: 10.0,
                          endIndent: 15.0,
                        ),
                        itemCount: viewModel.exerciseCategories.length,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
