import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/di/di.dart';
import '../view_model/cubit/smart_coach_cubit.dart';
import 'widgets/end_drawer_widget.dart';
import 'widgets/smart_coach_body.dart';

class SmartCoachScreen extends StatefulWidget {
  const SmartCoachScreen({super.key});

  @override
  State<SmartCoachScreen> createState() => _SmartCoachScreenState();
}

class _SmartCoachScreenState extends State<SmartCoachScreen> {
  late final SmartCoachCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SmartCoachCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: const Scaffold(
        endDrawer: EndDrawerWidget(),
        body: SmartCoachBody(),
      ),
    );
  }
}
