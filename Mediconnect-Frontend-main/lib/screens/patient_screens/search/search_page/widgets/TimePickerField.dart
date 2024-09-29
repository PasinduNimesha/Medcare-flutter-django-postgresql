import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final VoidCallback onTimeSelected;

  const TimePickerField({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTimeSelected,
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: selectedTime != null ? 'Selected Time: ${selectedTime!.format(context)}' : 'Select Time',
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
