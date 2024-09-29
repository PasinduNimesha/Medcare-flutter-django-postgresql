import 'package:flutter/material.dart';
import '../../medicine_reminders/widgets/widgets.dart';
import '../widgets/widgets.dart';

class NotificationsPageScaffold extends StatelessWidget {
  const NotificationsPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,  // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications & Reminders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Notifications'),
              Tab(text: 'My Reminders'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NotificationsView(),
            MedicineRemindersView(),
          ],
        ),
      ),
    );
  }
}
