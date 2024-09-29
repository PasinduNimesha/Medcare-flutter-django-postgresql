import 'package:flutter/material.dart';

void removeAppointmentConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
  TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Remove Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Type "Remove this appointment" to confirm'),
            const SizedBox(height: 10),
            TextField(controller: controller),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text == 'Remove this appointment') {
                onConfirm();
                Navigator.pop(context);
              }
            },
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
