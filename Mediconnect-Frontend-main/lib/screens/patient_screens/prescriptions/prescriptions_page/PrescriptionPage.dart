import 'package:flutter/material.dart';
import 'view/view.dart';
import '../reports_page/view/view.dart';

class PrescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // We have 2 tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Medical Records'),
          bottom: const TabBar(
            indicatorColor: Colors.blue, // Underline color of selected tab
            labelColor: Colors.blue, // Color of selected tab label
            unselectedLabelColor: Colors.grey, // Unselected tab label color
            tabs: [
              Tab(text: 'My Prescriptions'),
              Tab(text: 'My Reports'),
            ],
          ),
          backgroundColor: Colors.white, // AppBar background color
        ),
        body: TabBarView(
          children: [
            PrescriptionsScaffold(), // Prescription page content
            ReportsScaffold(), // Reports page content
          ],
        ),
      ),
    );
  }
}
