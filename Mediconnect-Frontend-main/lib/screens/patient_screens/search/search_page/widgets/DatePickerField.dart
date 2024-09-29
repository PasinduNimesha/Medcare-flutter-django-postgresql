import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onDateSelected;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDateSelected,
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            labelText: selectedDate != null
                ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                : 'Select Date',
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
