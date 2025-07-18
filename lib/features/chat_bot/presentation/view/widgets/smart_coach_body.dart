import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';
import 'ask_coach_field.dart';
import 'get_started_page_view.dart';
import 'smart_coach_app_bar.dart';
import 'smart_coach_list_of_messages.dart';

class SmartCoachBody extends StatelessWidget {
  const SmartCoachBody({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: viewModel.pageController,
            onPageChanged: (index) {
              viewModel.doIntent(ChangePageAction(index: index));
            },
            children: [
              const GetStartedPageView(),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.backgroundFive),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        controller: viewModel.scrollController,
                        slivers: const [
                          SmartCoachAppBar(),
                          SmartCoachListOfMessages(),
                        ],
                      ),
                    ),
                    const AskCoachField(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
