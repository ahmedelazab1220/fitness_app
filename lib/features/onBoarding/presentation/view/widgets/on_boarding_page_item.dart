import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/on_boarding_model.dart';

class OnBoardingPageItem extends StatelessWidget {
  final OnBoardingModel item;
  final bool isLast;
  final VoidCallback onSkip;

  const OnBoardingPageItem({
    super.key,
    required this.item,
    required this.isLast,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLast)
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: onSkip,
              child: Text(
                LocaleKeys.Skip.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.white[AppColors.colorCode20],
                ),
              ),
            ),
          ),
        Expanded(
          flex: 4,
          child: Image.asset(
            item.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
