import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';

class HandleHistoryFetchError extends StatelessWidget {
  const HandleHistoryFetchError({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 72,
                    color: AppColors.orange.withAlpha(150),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              LocaleKeys.SomethingWentWrong.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FadeInLeft(
              child: Text(
                LocaleKeys.WeCouldNotLoadYourConversationsLetUsTryAgain.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white.withAlpha(150),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            FadeInRightBig(
              child: ElevatedButton.icon(
                onPressed: () {
                  viewModel.doIntent(GetAllConversationsAction());
                },
                label: Text(LocaleKeys.TryAgain.tr()),
                icon: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
