import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';

class AskCoachField extends StatelessWidget {
  const AskCoachField({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: viewModel.messageController,
              maxLength: 1000,
              onChanged: (_) {
                viewModel.doIntent(ValidateMessageAction());
              },
              decoration: InputDecoration(
                hintText: LocaleKeys.TypeYourMessage.tr(),
                filled: true,
                fillColor: AppColors.darkgrey,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          const SizedBox(width: 8),
          BlocBuilder<SmartCoachCubit, SmartCoachState>(
            buildWhen: (previous, current) =>
                (previous.isValidMessage != current.isValidMessage ||
                current.baseState is BaseLoadingState),
            builder: (context, state) {
              return InkWell(
                onTap: state.isValidMessage == true
                    ? () {
                        viewModel.doIntent(
                          AskSmartCoachAction(
                            message: viewModel.messageController.text.trim(),
                          ),
                        );
                      }
                    : null,
                child: CircleAvatar(
                  backgroundColor: state.isValidMessage == true
                      ? AppColors.orange
                      : AppColors.white.withAlpha(150),
                  child: state.baseState is BaseLoadingState
                      ? const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : const Icon(Icons.send, color: AppColors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
