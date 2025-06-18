import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({
    super.key,
    required this.progress,
    required this.current,
    required this.total,
  });

  final double progress;
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
              value: progress,
              strokeWidth: 4,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFF4100),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(
            '$current/$total',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
