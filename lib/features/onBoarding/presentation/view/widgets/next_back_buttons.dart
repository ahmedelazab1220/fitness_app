import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            length,
            (index) => DotItems(isActive: index == currentPage),
          ),
        ),
        const SizedBox(height: 24),
        if (currentPage > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: onBack,
                child: Text(LocaleKeys.Back.tr()),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onNext,
                child: Text(
                  currentPage < length - 1
                      ? LocaleKeys.Next.tr()
                      : LocaleKeys.DoIt.tr(),
                ),
              ),
            ],
          ),
        ] else ...[
          ElevatedButton(onPressed: onNext, child: Text(LocaleKeys.Next.tr())),
        ],
      ],
    );
  }
}
