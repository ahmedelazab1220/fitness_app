import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/assets/app_images.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'on_boarding_model.dart';

part 'on_boarding_state.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingState> {
  final PageController pageController = PageController();

  OnBoardingCubit() : super(const OnBoardingState());

  void doIntent(OnBoardingActions action) {
    switch (action) {
      case OnBoardingNextPage():
        {
          next();
        }
      case OnBoardingPreviousPage():
        {
          back();
        }
      case OnBoardingPageChanged():
        {
          changePage(action.pageIndex);
        }
      case OnBoardingSkip():
        {
          skip();
        }
    }
  }

  final List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
      image: AppImages.onboarding1,
      title: LocaleKeys.ThePriceOfExcellenceIsDiscipline.tr(),
      description: LocaleKeys
          .LoremIpsumDolorSitAmetConsecteturEuUrnaUtGravidaQuisIdPretiumPurusMaurIsMassa.tr(),
    ),
    OnBoardingModel(
      image: AppImages.onboarding2,
      title: LocaleKeys.FitnessHasNeverBeenSoMuchFun.tr(),
      description: LocaleKeys
          .LoremIpsumDolorSitAmetConsecteturEuUrnaUtGravidaQuisIdPretiumPurusMaurIsMassa.tr(),
    ),
    OnBoardingModel(
      image: AppImages.onboarding3,
      title: LocaleKeys.NOMOREEXCUSESDoItNow.tr(),
      description: LocaleKeys
          .LoremIpsumDolorSitAmetConsecteturEuUrnaUtGravidaQuisIdPretiumPurusMaurIsMassa.tr(),
    ),
  ];

  void changePage(int pageIndex) {
    emit(state.copyWith(currentPageIndex: pageIndex));
  }

  void next() {
    if (state.currentPageIndex < onBoardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changePage(state.currentPageIndex + 1);
    } else {
      skip();
    }
  }

  void back() {
    if (state.currentPageIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      changePage(state.currentPageIndex - 1);
    }
  }

  void skip() {
    emit(state.copyWith(currentPageIndex: onBoardingPages.length - 1));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
