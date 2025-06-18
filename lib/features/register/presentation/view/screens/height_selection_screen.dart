import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../widgets/selected_height_widget.dart';

class HeightSelectionScreen extends StatelessWidget {
  const HeightSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Texts with horizontal padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.WhatIsYourHight.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        const SelectedHeightWidget(),
      ],
    );
  }
}
