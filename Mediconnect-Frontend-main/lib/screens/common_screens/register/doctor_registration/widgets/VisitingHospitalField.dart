// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mediconnect/repository/hospital_repository.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/widgets/HospitalDropdown.dart';

class VisitingHospitalField extends StatefulWidget {
  final Function(Map<String, dynamic>) onHospitalDataChanged;
  final int index;

  VisitingHospitalField({
    required this.onHospitalDataChanged,
    required this.index,
  });

  @override
  State<VisitingHospitalField> createState() => _VisitingHospitalFieldState();
}

class _VisitingHospitalFieldState extends State<VisitingHospitalField> {
  final TextEditingController appointedCountController =
      TextEditingController();
  final TextEditingController appointlessCountController =
      TextEditingController();

  TimeOfDay? appointedStartTime;
  TimeOfDay? appointedEndTime;
  TimeOfDay? appointlessStartTime;
  TimeOfDay? appointlessEndTime;

  final hospitalRepository = HospitalRepository();
  String? _selectedHospital;

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

  Future<void> _pickTime(
      BuildContext context, ValueChanged<TimeOfDay?> onTimePicked) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        onTimePicked(pickedTime);
        _notifyChanges();
      });
    }
  }

  void _notifyChanges() {
    widget.onHospitalDataChanged({
      'Hospital_ID': _selectedHospital,
      'Mon': daySelected['Mon'],
      'Tue': daySelected['Tue'],
      'Wed': daySelected['Wed'],
      'Thu': daySelected['Thu'],
      'Fri': daySelected['Fri'],
      'Sat': daySelected['Sat'],
      'Sun': daySelected['Sun'],
      'AP_Start_Time': appointedStartTime?.format(context).toString() ?? '',
      'AP_End_Time': appointedEndTime?.format(context).toString() ?? '',
      'AP_Count': int.tryParse(appointedCountController.text) ?? 0,
      'APL_Start_Time': appointlessStartTime?.format(context).toString() ?? '',
      'APL_End_Time': appointlessEndTime?.format(context).toString() ?? '',
      'APL_Count': int.tryParse(appointlessCountController.text) ?? 0,
    });
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
                        _notifyChanges();
                      });
                    },
                  ),
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
                        _notifyChanges();
                      });
                    },
                  ),
                  Text(day),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          _buildTimeSection("Appointed Patients", appointedStartTime,
              appointedEndTime, appointedCountController),
          const SizedBox(height: 20),
          _buildTimeSection("Appointless Patients", appointlessStartTime,
              appointlessEndTime, appointlessCountController),
        ],
      ),
    );
  }

  Widget _buildTimeSection(String title, TimeOfDay? startTime,
      TimeOfDay? endTime, TextEditingController countController) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Row(children: [Text(title)]),
          Row(
            children: [
              const Text("Start Time: "),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: TextButton(
                    onPressed: () => _pickTime(context, (time) {
                      if (title.contains("Appointed")) {
                        appointedStartTime = time;
                      } else {
                        appointlessStartTime = time;
                      }
                    }),
                    child: Text(
                      startTime != null
                          ? startTime.format(context)
                          : 'Select Start Time',
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text("End Time: "),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                child: TextButton(
                  onPressed: () => _pickTime(context, (time) {
                    if (title.contains("Appointed")) {
                      appointedEndTime = time;
                    } else {
                      appointlessEndTime = time;
                    }
                  }),
                  child: Text(
                    endTime != null
                        ? endTime.format(context)
                        : 'Select End Time',
                  ),
                ),
              )),
            ],
          ),
          Row(
            children: [
              const Text("Patient Count: "),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: TextFormField(
                    controller: countController,
                    onChanged: (_) => _notifyChanges(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
