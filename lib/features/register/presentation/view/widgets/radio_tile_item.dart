import 'package:flutter/material.dart';

class RadioTileItem extends StatelessWidget {
  const RadioTileItem({
    super.key,
    required this.goal,
    required this.selectedGoal,
    required this.onSelected,
    required this.onChanged,
  });

  final void Function() onSelected;
  final String goal;
  final String selectedGoal;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      // Fixed height
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: const Color(0x33D3D3D3),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
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
              goal,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            // Radio button
            Radio<String>(
              value: goal,
              groupValue: selectedGoal,
              onChanged: (value) {
                onChanged(value!);
              },
              fillColor: WidgetStateProperty.resolveWith(
                (states) => const Color(0xFFD3D3D3),
              ),
              activeColor: const Color(0xFFD3D3D3),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
