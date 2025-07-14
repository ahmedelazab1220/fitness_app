import 'dart:math' as math;

import 'package:fitness_app/core/assets/app_colors.dart';
import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 2,
            child: CircularProgressIndicator(
              value: current / total,
              strokeWidth: 4,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.orange),
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(
            '$current/$total',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
