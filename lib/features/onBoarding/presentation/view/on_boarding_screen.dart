import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/core/utils/shared_widgets/blured_container.dart';
import 'package:fitness_app/features/onBoarding/presentation/view/widgets/on_boarding_container.dart';
import 'package:fitness_app/features/onBoarding/presentation/view/widgets/on_boarding_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../view_model/cubit/on_boarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnBoardingCubit>(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundOne),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
              builder: (context, state) {
                final cubit = context.read<OnBoardingCubit>();
                final current = cubit.onBoardingData[state.currentPageIndex];

                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: cubit.pageController,
                        onPageChanged: (index) =>
                            cubit.doIntent(OnBoardingPageChanged(index)),
                        itemCount: cubit.onBoardingData.length,
                        itemBuilder: (context, index) {
                          final item = cubit.onBoardingData[index];
                          return OnBoardingPageItem(
                            item: item,
                            isLast: index == cubit.onBoardingData.length - 1,
                            onSkip: () => cubit.doIntent(OnBoardingSkip()),
                          );
                        },
                      ),
                    ),
                    BluredContainer(
                      child: OnBoardingContainer(
                        item: current,
                        state: state,
                        totalPages: cubit.onBoardingData.length,
                        onNext: () => cubit.doIntent(OnBoardingNextPage()),
                        onBack: () => cubit.doIntent(OnBoardingPreviousPage()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
