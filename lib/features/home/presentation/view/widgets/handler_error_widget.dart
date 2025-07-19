import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_lotties.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';

class HandlerErrorWidget extends StatelessWidget {
  const HandlerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Lottie.asset(AppLotties.warningAnimation, height: 55.0, width: 55.0),
          const SizedBox(height: 8.0),
          Text(
            LocaleKeys.SomethingWentWrongPleaseTryAgainLater.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
