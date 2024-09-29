import 'package:flutter/material.dart';

class MealTimeFields extends StatelessWidget {
  final TimeOfDay? breakfastTime;
  final TimeOfDay? lunchTime;
  final TimeOfDay? dinnerTime;
  final ValueChanged<TimeOfDay> onBreakfastChanged;
  final ValueChanged<TimeOfDay> onLunchChanged;
  final ValueChanged<TimeOfDay> onDinnerChanged;

  const MealTimeFields({
    super.key,
    this.breakfastTime,
    this.lunchTime,
    this.dinnerTime,
    required this.onBreakfastChanged,
    required this.onLunchChanged,
    required this.onDinnerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85), // Blurred background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Usual Meal Times (You can change these later)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('Breakfast'),
            trailing: Text(
                breakfastTime == null ? 'Set Time' : breakfastTime!.format(context)),
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 6, minute: 0),
              );
              if (selectedTime != null) {
                onBreakfastChanged(selectedTime);
              }
            },
          ),
          ListTile(
            title: const Text('Lunch'),
            trailing: Text(lunchTime == null ? 'Set Time' : lunchTime!.format(context)),
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 12, minute: 0),
              );
              if (selectedTime != null) {
                onLunchChanged(selectedTime);
              }
            },
          ),
          ListTile(
            title: const Text('Dinner'),
            trailing: Text(dinnerTime == null ? 'Set Time' : dinnerTime!.format(context)),
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: const TimeOfDay(hour: 18, minute: 0),
              );
              if (selectedTime != null) {
                onDinnerChanged(selectedTime);
              }
            },
          ),
        ],
      ),
    );
  }
}
