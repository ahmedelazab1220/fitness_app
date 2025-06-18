import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/core/utils/shared_widgets/blured_container.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/wheel_slider_selector.dart';

class AgeSelectionScreen extends StatelessWidget {
  const AgeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.HowOldAreYou.tr(),
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
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final cubit = context.read<RegisterCubit>();
              return WheelSliderSelector(
                label: LocaleKeys.Year.tr(),
                initialValue: state.age ?? 25,
                onValueChanged: (value) {
                  cubit.setAge(value);
                },
                buttonText: LocaleKeys.Done.tr(),
                onButtonPressed: cubit.nextStep,
              );
            },
          ),
        ),
      ],
    );
  }
}
