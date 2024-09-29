import 'package:flutter/material.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  final String doctorName;
  final int? selectedNumber;
  final ValueChanged<int?> onSelectNumber;
  final ValueChanged<String> onConsultationTypeChanged;
  final ValueChanged<String> onNoteChanged;
  final VoidCallback onPlaceAppointment;

  const AppointmentDetailsWidget({
    super.key,
    required this.doctorName,
    required this.selectedNumber,
    required this.onSelectNumber,
    required this.onConsultationTypeChanged,
    required this.onNoteChanged,
    required this.onPlaceAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make an Appointment with $doctorName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Doctor name: Dr. $doctorName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Medical Center: Medicare - Kiribathgoda',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on),
                TextButton(
                  onPressed: () {
                    // Handle See Location press
                  },
                  child: const Text(
                    'See Location',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Date: 2024/06/25',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Available Numbers',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<int>(
              value: selectedNumber,
              onChanged: onSelectNumber,
              items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Approx. time',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '11:00 AM',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'This time may vary. So make sure to visit the medical center/hospital on time',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => onConsultationTypeChanged('In-person'),
                  child: const Text('In-person'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 116, 198, 236),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onConsultationTypeChanged('Online'),
                  child: const Text('Online'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'My note',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'John Doe - Chest Pain',
                ),
                onChanged: onNoteChanged,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: onPlaceAppointment,
                child: const Text(
                  'Place Appointment',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Full-width button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
