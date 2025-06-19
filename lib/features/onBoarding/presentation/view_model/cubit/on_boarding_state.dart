part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final int currentPageIndex;

  const OnBoardingState({this.currentPageIndex = 0});

  @override
  List<Object> get props => [currentPageIndex];

  OnBoardingState copyWith({int? currentPageIndex}) {
    return OnBoardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}

sealed class OnBoardingActions {}

class OnBoardingNextPage extends OnBoardingActions {}

class OnBoardingPreviousPage extends OnBoardingActions {}

class OnBoardingPageChanged extends OnBoardingActions {
  final int pageIndex;

  OnBoardingPageChanged(this.pageIndex);
}

class OnBoardingSkip extends OnBoardingActions {}
