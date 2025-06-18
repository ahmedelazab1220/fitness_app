import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';
import '../widgets/radio_tile_item.dart';

class ActivitySelectionScreen extends StatelessWidget {
  ActivitySelectionScreen({super.key});

  final List<String> goals = [
    'Gain Weight',
    'Lose Weight',
    'Get Fitter',
    'Gain More Flexible',
    'Learn The Basic',
  ];

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
                LocaleKeys.YourRegularPhysicalActivityLevel.tr(),
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
        BluredContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Spread the mapped RadioTileItems
              ...goals.map((goal) {
                return RadioTileItem(
                  goal: goal,
                  selectedGoal: '',
                  onSelected: () {
                    // viewmodel.addGoal(goal);
                  },
                  onChanged: (value) {
                    // viewmodel.addGoal(value);
                  },
                );
              }), // ← don't forget toList() if you need it
              // 2. Then the spacing and button
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle registration logic here
                  },
                  child: Text(LocaleKeys.Register.tr()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
