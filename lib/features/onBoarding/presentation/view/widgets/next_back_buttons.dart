import 'package:flutter/material.dart';
import 'dot_items.dart';

class NextBackButtons extends StatelessWidget {
  const NextBackButtons({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onBack,
    required this.length,
  });

  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            length,
            (index) => DotItems(isActive: index == currentPage),
          ),
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentPage > 0)
              Expanded(
                child: OutlinedButton(onPressed: onBack, child: Text('Back')),
              ),
            if (currentPage > 0) const SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: onNext,
                child: Text(currentPage < length - 1 ? 'Next' : 'Get Started'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
