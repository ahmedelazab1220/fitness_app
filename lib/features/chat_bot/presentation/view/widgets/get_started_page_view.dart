import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_images.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../../../main_layout/presentation/view_model/cubit/main_layout_cubit.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';

class GetStartedPageView extends StatelessWidget {
  const GetStartedPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundFive),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.orange,
                  radius: 14,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      size: 28,
                      Icons.arrow_left_rounded,
                      color: AppColors.white,
                    ),
                    onPressed: () => context.read<MainLayoutCubit>().doIntent(
                      ChangeSelectedTab(MainLayoutTabs.home),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Hi Ahmed,\n",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextSpan(
                      text: LocaleKeys.IAmYourSmartCoach.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          Expanded(child: Image.asset(AppImages.smartCoachImage)),
          SharedBluredContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocaleKeys.HowCanIAssistYouToday.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    viewModel.doIntent(
                      ChangePageAction(
                        index: viewModel.state.currentPageIndex! + 1,
                      ),
                    );
                  },
                  child: Text(LocaleKeys.GetStarted.tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
