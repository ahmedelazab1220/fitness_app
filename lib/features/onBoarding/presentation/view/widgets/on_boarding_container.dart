import 'package:flutter/material.dart';

import '../../view_model/cubit/on_boarding_cubit.dart';
import '../../view_model/cubit/on_boarding_model.dart';
import 'next_back_buttons.dart';

class OnBoardingContainer extends StatelessWidget {
  final OnBoardingModel item;
  final OnBoardingState state;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnBoardingContainer({
    super.key,
    required this.item,
    required this.state,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        NextBackButtons(
          currentPage: state.currentPageIndex,
          length: totalPages,
          onNext: onNext,
          onBack: onBack,
        ),
      ],
    );
  }
}
