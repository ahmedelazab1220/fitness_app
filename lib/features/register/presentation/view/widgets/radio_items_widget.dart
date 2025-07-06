import 'package:fitness_app/features/register/presentation/view/widgets/radio_tile_item.dart';
import 'package:flutter/material.dart';

class RadioItemsWidget extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;
  final String buttonLabel;

  const RadioItemsWidget({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.onSubmit,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...options.map(
          (option) => RadioTileItem(
            value: option,
            selectedValue: selectedValue ?? '',
            onSelected: () => onChanged(option),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: selectedValue != null ? onSubmit : null,
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}
