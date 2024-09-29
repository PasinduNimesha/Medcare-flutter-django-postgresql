import 'package:flutter/material.dart';

// Notification widget for the Notifications Page
class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.notification_important, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

// View for Notifications
class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: const [
        NotificationCard(
          title: 'Appointment Reminder',
          subtitle: 'Your appointment with Dr. Smith is scheduled for tomorrow at 10:00 AM.',
        ),
        NotificationCard(
          title: 'New Message from Dr. Johnson',
          subtitle: 'You have a new message regarding your test results.',
        ),
        NotificationCard(
          title: 'Prescription Update',
          subtitle: 'Your prescription has been updated by Dr. Lee.',
        ),
      ],
    );
  }
}
