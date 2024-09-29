import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class MedicineRemindersScaffold extends StatelessWidget {
  const MedicineRemindersScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reminders'),
      ),
      body: const MedicineRemindersView(),
    );
  }
}
