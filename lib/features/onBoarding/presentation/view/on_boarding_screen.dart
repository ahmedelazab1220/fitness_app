import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../view_model/cubit/on_boarding_cubit.dart';
import 'widgets/on_boarding_container.dart';
import 'widgets/on_boarding_page_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final OnBoardingCubit viewModel;

  @override
  void initState() {
    viewModel = getIt<OnBoardingCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => viewModel,
      child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state.isOnBoardingDone) {
            Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
          }
        },
        builder: (context, state) {
          final current = viewModel.onBoardingPages[state.currentPageIndex];
          return Scaffold(
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
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: viewModel.pageController,
                        onPageChanged: (index) =>
                            viewModel.doIntent(OnBoardingPageChanged(index)),
                        itemCount: viewModel.onBoardingPages.length,
                        itemBuilder: (context, index) {
                          final item = viewModel.onBoardingPages[index];
                          return OnBoardingPageItem(
                            item: item,
                            isLast:
                                index == (viewModel.onBoardingPages.length - 1),
                            onSkip: () => viewModel.doIntent(OnBoardingSkip()),
                          );
                        },
                      ),
                    ),
                    SharedBluredContainer(
                      child: OnBoardingContainer(
                        item: current,
                        state: state,
                        totalPages: viewModel.onBoardingPages.length,
                        onNext: () => current == viewModel.onBoardingPages.last
                            ? viewModel.doIntent(OnBoardingDone())
                            : viewModel.doIntent(OnBoardingNextPage()),
                        onBack: () =>
                            viewModel.doIntent(OnBoardingPreviousPage()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
