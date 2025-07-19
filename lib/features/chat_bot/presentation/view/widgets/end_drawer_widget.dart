import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';
import 'build_history_conversation_widget.dart';
import 'handle_empty_history.dart';
import 'handle_history_fetch_error.dart';

class EndDrawerWidget extends StatelessWidget {
  const EndDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return Drawer(
      backgroundColor: AppColors.darkgrey.withAlpha(240),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.75,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<SmartCoachCubit, SmartCoachState>(
                  buildWhen: (previous, current) =>
                      (previous.getAllConversations !=
                          current.getAllConversations ||
                      previous.deleteConversation !=
                          current.deleteConversation),
                  builder: (context, state) {
                    if (state.getAllConversations is BaseErrorState) {
                      return const HandleHistoryFetchError();
                    } else if (viewModel.sessions.isEmpty) {
                      return const HandleEmptyHistory();
                    }
                    return const BuildHistoryConversationWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
