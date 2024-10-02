import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/widgets/HospitalDropdown.dart';

class VisitingHospitalField extends StatefulWidget {
  @override
  State<VisitingHospitalField> createState() => _VisitingHospitalFieldState();
}

class _VisitingHospitalFieldState extends State<VisitingHospitalField> {
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController hospitalLocationController =
      TextEditingController();

  TimeOfDay? appointedStartTime;
  TimeOfDay? appointedEndTime;
  TimeOfDay? appointlessStartTime;
  TimeOfDay? appointlessEndTime;

  final List<String> daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  final Map<String, bool> daySelected = {
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
    'Sun': false,
  };

  String? _selectedHospital;

  Future<void> _pickTime(
      BuildContext context, ValueChanged<TimeOfDay?> onTimePicked) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        onTimePicked(pickedTime);
      });
    }
  }

  Future<void> _openAddHospitalDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Hospital'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: hospitalNameController,
                decoration: const InputDecoration(labelText: 'Hospital Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: hospitalLocationController,
                decoration:
                    const InputDecoration(labelText: 'Hospital Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (hospitalNameController.text.isNotEmpty &&
                    hospitalLocationController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: HospitalDropdown(
                    selectedHospital: _selectedHospital,
                    onHospitalChanged: (hospital) {
                      setState(() {
                        _selectedHospital = hospital;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _openAddHospitalDialog,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: daysOfWeek.map((day) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: daySelected[day],
                    onChanged: (bool? value) {
                      setState(() {
                        daySelected[day] = value!;
                      });
                    },
                  ),
                  Text(day),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          // Appointed Patients Time Row
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
            child: Row(
              children: [
                const Text("Appointed Patients:"),
                Flexible(
                  child: TextButton(
                    onPressed: () =>
                        _pickTime(context, (time) => appointedStartTime = time),
                    child: Text(
                      appointedStartTime != null
                          ? appointedStartTime!.format(context)
                          : 'Start Time',
                    ),
                  ),
                ),
                const Text(" To"),
                Flexible(
                  child: TextButton(
                    onPressed: () =>
                        _pickTime(context, (time) => appointedEndTime = time),
                    child: Text(
                      appointedEndTime != null
                          ? appointedEndTime!.format(context)
                          : 'End Time',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Appointless Patients Time Row
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 3),
            child: Row(
              children: [
                const Text("Appointless Patients:"),
                Flexible(
                  child: TextButton(
                    onPressed: () => _pickTime(
                        context, (time) => appointlessStartTime = time),
                    child: Text(
                      appointlessStartTime != null
                          ? appointlessStartTime!.format(context)
                          : 'Start Time',
                    ),
                  ),
                ),
                const Text(" To"),
                Flexible(
                  child: TextButton(
                    onPressed: () =>
                        _pickTime(context, (time) => appointlessEndTime = time),
                    child: Text(
                      appointlessEndTime != null
                          ? appointlessEndTime!.format(context)
                          : 'End Time',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
