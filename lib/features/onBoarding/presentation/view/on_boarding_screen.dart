import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/core/utils/shared_widgets/blured_container.dart';
import 'package:fitness_app/features/onBoarding/presentation/view/widgets/next_back_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../view_model/cubit/on_boarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final OnBoardingCubit _cubit = getIt<OnBoardingCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundOne),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
              builder: (context, state) {
                final isLast =
                    state.currentPageIndex == _cubit.demoData.length - 1;
                return Column(
                  children: [
                    if (!isLast)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => _cubit.doIntent(OnBoardingSkip()),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text('Skip'),
                        ),
                      ),
                    Expanded(
                      child: PageView.builder(
                        controller: _cubit.pageController,
                        onPageChanged: (idx) =>
                            _cubit.doIntent(OnBoardingPageChanged(idx)),
                        itemCount: _cubit.demoData.length,
                        itemBuilder: (context, idx) {
                          final item = _cubit.demoData[idx];
                          return Column(
                            children: [
                              Image.asset(item.image, fit: BoxFit.contain),
                              const SizedBox(height: 16),
                              Expanded(
                                child: BluredContainer(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            item.title,
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            item.description,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      NextBackButtons(
                                        currentPage: state.currentPageIndex,
                                        length: _cubit.demoData.length,
                                        onNext: () => _cubit.doIntent(
                                          OnBoardingNextPage(),
                                        ),
                                        onBack: () => _cubit.doIntent(
                                          OnBoardingPreviousPage(),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
