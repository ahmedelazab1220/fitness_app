import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/selected_gender_widget.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/step_widget.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionScreen extends StatelessWidget {
  const GenderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StepWidget(
      title: LocaleKeys.TellUsAboutYourself.tr(),
      subtitle: LocaleKeys.WeNeedToKnowYourGender.tr(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final viewModel = context.read<RegisterCubit>();
          return SelectedGenderWidget(
            selectedGender: state.gender,
            onSelectGender: (value) =>
                viewModel.doIntent(SetGenderAction(value)),
            onNext: () => viewModel.doIntent(NextStepAction()),
          );
        },
      ),
    );
  }
}
