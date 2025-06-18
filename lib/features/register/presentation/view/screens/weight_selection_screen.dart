import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/assets/app_images.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/selected_gender_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/wheel_slider_selector.dart';

class WeightSelectionScreen extends StatelessWidget {
  const WeightSelectionScreen({super.key});

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
                LocaleKeys.WhatIsYourWeight.tr(),
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
        WheelSliderSelector(
          label: "Kg",
          initialValue: 90,
          onValueChanged: (value) => print("Selected Weight: $value"),
          buttonText: LocaleKeys.Next.tr(),
          onButtonPressed: () {},
        ),
      ],
    );
  }
}
