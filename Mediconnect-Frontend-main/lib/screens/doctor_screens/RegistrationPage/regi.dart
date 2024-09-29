
import 'package:flutter/material.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoctorRegistrationScreenState createState() => _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TextField(decoration: InputDecoration(labelText: 'First name')),
              const TextField(decoration: InputDecoration(labelText: 'Last name')),
              const TextField(decoration: InputDecoration(labelText: 'Other name/s')),
              const TextField(decoration: InputDecoration(labelText: 'Age')),
              const TextField(decoration: InputDecoration(labelText: 'Specialisation')),
              const TextField(decoration: InputDecoration(labelText: 'Address')),
              const TextField(decoration: InputDecoration(labelText: 'Doctor Registration Number')),
              const TextField(decoration: InputDecoration(labelText: 'NIC')),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (value) {},
              ),
              const TextField(decoration: InputDecoration(labelText: 'Visiting Hospitals')),
              Row(
                children: [
                  const Text('Visiting Time:'),
                  TextButton(
                    onPressed: () => _selectTime(context, true),
                    child: Text(_selectedStartTime != null
                        ? _selectedStartTime!.format(context)
                        : 'From'),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context, false),
                    child: Text(_selectedEndTime != null
                        ? _selectedEndTime!.format(context)
                        : 'To'),
                  ),
                ],
              ),
              const TextField(decoration: InputDecoration(labelText: 'Doctor ID (Front View)')),
              const TextField(decoration: InputDecoration(labelText: 'Doctor ID (Back View)')),
              ElevatedButton(
                onPressed: () {
                  // Registration logic here
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}