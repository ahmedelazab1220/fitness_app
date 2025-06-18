import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';

class RadioTileItem extends StatelessWidget {
  const RadioTileItem({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
    required this.onChanged,
  });

  final void Function() onSelected;
  final String value;
  final String selectedValue;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      // Fixed height
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: AppColors.white[AppColors.colorCode30]!.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColors.white[AppColors.colorCode20]!,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          onSelected();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text widget for the goal
            Text(
              value,
              style: const TextStyle(color: AppColors.white, fontSize: 14),
            ),
            // Radio button
            Radio<String>(
              value: value,
              groupValue: selectedValue,
              onChanged: (value) {
                onChanged(value!);
              },
              fillColor: WidgetStateProperty.resolveWith(
                (states) => AppColors.white[AppColors.colorCode30],
              ),
              activeColor: AppColors.white[AppColors.colorCode30],
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
