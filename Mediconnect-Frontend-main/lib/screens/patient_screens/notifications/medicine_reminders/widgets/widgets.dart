import 'package:flutter/material.dart';

// Widget for Reminder Card
class ReminderCard extends StatefulWidget {
  final String medicine;
  final String intake;
  final String time;

  const ReminderCard({
    required this.medicine,
    required this.intake,
    required this.time,
  });

  @override
  _ReminderCardState createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.medicine,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.intake,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        "Time: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// View for Medicine Reminders
class MedicineRemindersView extends StatelessWidget {
  const MedicineRemindersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reminders = [
      {'medicine': 'Panadol - 5mg', 'intake': 'After Breakfast', 'time': '8:00 AM'},
      {'medicine': 'Digene - 5mg', 'intake': 'Before Lunch', 'time': '12:30 PM'},
      {'medicine': 'Pantodac - 15mg', 'intake': 'After Lunch', 'time': '2:00 PM'},
    ];

    return ListView.builder(
      itemCount: reminders.length,
      itemBuilder: (context, index) {
        final reminder = reminders[index];
        return ReminderCard(
          medicine: reminder['medicine']!,
          intake: reminder['intake']!,
          time: reminder['time']!,
        );
      },
    );
  }
}
