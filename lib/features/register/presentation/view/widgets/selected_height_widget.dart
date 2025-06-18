import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';

class SelectedHeightWidget extends StatelessWidget {
  const SelectedHeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("CM"),
        ),
        SizedBox(height: 6),
        SizedBox(
          height: 62,
          width: double.infinity,
          child: WheelSlider.number(
            totalCount: 150,
            initValue: 167,
            unSelectedNumberStyle: TextStyle(
              fontSize: 33.0,
              color: const Color(0xFFBDBDBD),
              fontWeight: FontWeight.w800,
            ),
            selectedNumberStyle: TextStyle(
              fontSize: 44.0,
              color: const Color(0xFFFD3C00),
              fontWeight: FontWeight.w800,
            ),
            currentIndex: 167,
            onValueChanged: (value) {
              print("Selected Height: $value");
            },
            itemSize: 100,
            isInfinite: true,
            listHeight: 800,
            listWidth: 400,
            animationDuration: Duration(milliseconds: 300),
            animationType: Curves.easeInOut,
            customPointer: Container(),
            horizontal: true,
            scrollPhysics: BouncingScrollPhysics(),
            showPointer: true,
            verticalListHeight: 300,
            horizontalListHeight: 100,
            horizontalListWidth: 200,
            verticalListWidth: 100,
            hapticFeedbackType: HapticFeedbackType.selectionClick,
          ),
        ),
        SizedBox(height: 6),
        const Icon(Icons.arrow_drop_up, size: 30, color: Color(0xFFFD3C00)),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(LocaleKeys.Next.tr()),
          ),
        ),
      ],
    );
  }
}
