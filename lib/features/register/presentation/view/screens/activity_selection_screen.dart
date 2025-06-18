import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/radio_items_widget.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';

class ActivitySelectionScreen extends StatelessWidget {
  const ActivitySelectionScreen({super.key});

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
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final cubit = context.read<RegisterCubit>();
              return RadioItemsWidget(
                options: cubit.activityLevels,
                selectedValue: state.activity,
                onChanged: cubit.setActivity,
                onSubmit: () => cubit.doIntent(UserRegistrationAction()),
                buttonLabel: LocaleKeys.Register.tr(),
              );
            },
          ),
        ),
      ],
    );
  }
}
