import 'package:flutter/material.dart';

void switchUser(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Switch Account'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                title: const Text('John Doe'),
                subtitle: const Text('john.doe@example.com (Patient)'),
                onTap: () {
                  // Switch to this account
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Dr. Smith'),
                subtitle: const Text('dr.smith@example.com (Doctor)'),
                onTap: () {
                  // Switch to this account
                  Navigator.of(context).pop();
                },
              ),
              // Add more users here
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
