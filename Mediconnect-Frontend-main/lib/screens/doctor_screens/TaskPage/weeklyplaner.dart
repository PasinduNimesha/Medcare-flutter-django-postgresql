
//import 'package:doctor/TaskPage/addweeklycontainer.dart';
// import 'package:doctor/TaskPage/addweeklycontainer.dart';
// import 'package:doctor/TaskPage/weeklyaddtaskbutton.dart';
import 'package:flutter/material.dart';
import 'package:mediconnect/screens/doctor_screens/TaskPage/addweeklycontainer.dart';
import 'package:mediconnect/screens/doctor_screens/TaskPage/weeklyaddtaskbutton.dart';

class WeekPlanner extends StatefulWidget {
  const WeekPlanner({super.key});

  @override
  State<WeekPlanner> createState() => _WeekPlannerState();
}

class _WeekPlannerState extends State<WeekPlanner> {
// Title of the task
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Week Planner",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
           PlannerContainer(Deletebuttonstatus: false),
            SizedBox(height: 20,),
            WeekTask(),

          //  PlannerContainer(),

          ],
        ),
      ),
    );
  }                                                                 
}
