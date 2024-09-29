import 'package:flutter/material.dart';

class Task {
   String name;
   String venue;
   TimeOfDay startTime;
   TimeOfDay endTime;
  bool isCompleted;

  Task({
    required this.name,
    required this.venue,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
  });
}
