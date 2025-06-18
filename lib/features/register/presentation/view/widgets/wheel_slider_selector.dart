import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';


class WheelSliderSelector extends StatelessWidget {
  final String label;
  final int initialValue;
  final Function(dynamic) onValueChanged;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final int totalCount;

  const WheelSliderSelector({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onValueChanged,
    required this.buttonText,
    required this.onButtonPressed,
    this.totalCount = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(label, style: const TextStyle(color: Color(0xFFFD3C00))),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 62,
          width: double.infinity,
          child: WheelSlider.number(
            totalCount: totalCount,
            initValue: initialValue,
            unSelectedNumberStyle: const TextStyle(
              fontSize: 33.0,
              color: Color(0xFFBDBDBD),
              fontWeight: FontWeight.w800,
            ),
            selectedNumberStyle: const TextStyle(
              fontSize: 44.0,
              color: Color(0xFFFD3C00),
              fontWeight: FontWeight.w800,
            ),
            currentIndex: initialValue,
            onValueChanged: onValueChanged,
            itemSize: 100,
            isInfinite: true,
            listHeight: 800,
            listWidth: 400,
            animationDuration: const Duration(milliseconds: 300),
            animationType: Curves.easeInOut,
            customPointer: const SizedBox(),
            horizontal: true,
            scrollPhysics: const BouncingScrollPhysics(),
            showPointer: true,
            verticalListHeight: 300,
            horizontalListHeight: 100,
            horizontalListWidth: 200,
            verticalListWidth: 100,
            hapticFeedbackType: HapticFeedbackType.selectionClick,
          ),
        ),
        const SizedBox(height: 6),
        const Icon(Icons.arrow_drop_up, size: 30, color: Color(0xFFFD3C00)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: onButtonPressed,
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}
