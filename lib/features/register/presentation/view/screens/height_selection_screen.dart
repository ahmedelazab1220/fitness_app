import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/step_widget.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/wheel_slider_selector.dart';

class HeightSelectionScreen extends StatelessWidget {
  const HeightSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StepWidget(
      title: LocaleKeys.WhatIsYourHeight.tr(),
      subtitle: LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final viewModel = context.read<RegisterCubit>();
          final height = state.height ?? 170;
          return WheelSliderSelector(
            label: LocaleKeys.Cm.tr(),
            initialValue: height,
            onValueChanged: (value) =>
                viewModel.doIntent(SetHeightAction(value)),
            buttonText: LocaleKeys.Next.tr(),
            onButtonPressed: () => viewModel.doIntent(NextStepAction()),
          );
        },
      ),
    );
  }
}
