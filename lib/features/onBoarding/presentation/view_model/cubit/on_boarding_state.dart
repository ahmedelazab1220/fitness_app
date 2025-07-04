part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final int currentPageIndex;
  final bool isOnBoardingDone;

  const OnBoardingState({
    this.currentPageIndex = 0,
    this.isOnBoardingDone = false,
  });

  @override
  List<Object> get props => [currentPageIndex, isOnBoardingDone];

  OnBoardingState copyWith({int? currentPageIndex, bool? isOnBoardingDone}) {
    return OnBoardingState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isOnBoardingDone: isOnBoardingDone ?? this.isOnBoardingDone,
    );
  }
}

sealed class OnBoardingActions {}

final class OnBoardingNextPage extends OnBoardingActions {}

final class OnBoardingPreviousPage extends OnBoardingActions {}

final class OnBoardingPageChanged extends OnBoardingActions {
  final int pageIndex;

  OnBoardingPageChanged(this.pageIndex);
}

final class OnBoardingSkip extends OnBoardingActions {}

final class OnBoardingDone extends OnBoardingActions {}
