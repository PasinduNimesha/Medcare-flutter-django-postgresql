// import 'package:doctor/homepage/todaytaskcontainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mediconnect/screens/doctor_screens/homepage/todaytaskcontainer.dart';

class AddTodaysTask extends StatefulWidget {
  const AddTodaysTask({super.key});

  @override
  State<AddTodaysTask> createState() => _AddTodaysTaskState();
}

class _AddTodaysTaskState extends State<AddTodaysTask> {
  // List to keep track of PlannerContainer widgets
  // ignore: prefer_final_fields
  List<Widget> _plannerContainers = [];

  void _addTaskContainer() {
    setState(() {
      _plannerContainers.add(const TodayTaskContainer());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display existing PlannerContainer widgets
        ..._plannerContainers,
        // Button to add new PlannerContainer widgets
        Container(
          alignment:Alignment.center,
          padding: const EdgeInsets.only(top: 0, left: 16.0, right: 18.0),
        //  width: 300,
          child:ElevatedButton(
  onPressed: () {
    if (kDebugMode) {
      print("Add new Today Task button click");
    }
    _addTaskContainer();
  },
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.black), // Corrected line
    shape: WidgetStateProperty.all(const CircleBorder()),
    padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
  ),
  child: const Icon(
    Icons.add,
    size: 20,
    color: Colors.white,
  ),
),

        ),
      ],
    );
  }
}