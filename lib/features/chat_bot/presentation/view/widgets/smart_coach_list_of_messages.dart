import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/smart_coach_cubit.dart';

class SmartCoachListOfMessages extends StatelessWidget {
  const SmartCoachListOfMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartCoachCubit, SmartCoachState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate([
            ...state.messages.map((msg) => msg.buildMessageWidget()),
          ]),
        );
      },
    );
  }
}
