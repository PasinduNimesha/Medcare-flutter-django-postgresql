
import 'package:flutter/material.dart';

import '../../../common_screens/create_account & login/login/LoginScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showRemoveAccountDialog(BuildContext context, String userName) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Type "Remove $userName" to confirm'),
              const SizedBox(height: 10),
              TextField(controller: controller),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text == 'Remove $userName') {
                  // Perform account removal
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {
                  // Show error message or do nothing
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

  @override
  Widget build(BuildContext context) {
    const String firstName = "John";
    const String lastName = "Doe";
    final String fullName = '$firstName $lastName';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.jpg'), // replace with actual image asset
                    ),
                    const SizedBox(height: 10),
                    Text(
                      fullName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.cake),
                title: Text('12/02/2001'),
              ),
              const ListTile(
                leading: Icon(Icons.email),
                title: Text('johndoe@gmail.com'),
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text('1234567891'),
              ),
              const ListTile(
                leading: Icon(Icons.location_on),
                title: Text('123 Main Street, New York, USA'),
              ),
              const SizedBox(height: 20),
              const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ExpansionTile(
                title: const Text('Notifications'),
                children: [
                  ListTile(
                    title: const Text('Notification Type'),
                    trailing: DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: 'Mute',
                          child: Text('Mute'),
                        ),
                        DropdownMenuItem(
                          value: 'Vibrate',
                          child: Text('Vibrate'),
                        ),
                        DropdownMenuItem(
                          value: 'Sound',
                          child: Text('Sound'),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle notification type change
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Notification Sound'),
                    trailing: DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: 'Default',
                          child: Text('Default'),
                        ),
                        DropdownMenuItem(
                          value: 'Chime',
                          child: Text('Chime'),
                        ),
                        DropdownMenuItem(
                          value: 'Bell',
                          child: Text('Bell'),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle notification sound change
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Vibration Type'),
                    trailing: DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: 'Short',
                          child: Text('Short'),
                        ),
                        DropdownMenuItem(
                          value: 'Long',
                          child: Text('Long'),
                        ),
                        DropdownMenuItem(
                          value: 'Pattern',
                          child: Text('Pattern'),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle vibration type change
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Language'),
                    trailing: DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: 'English',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'Spanish',
                          child: Text('Spanish'),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle language change
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Log Out'),
              ),
              ElevatedButton(
                onPressed: () => _showRemoveAccountDialog(context, fullName),
                child: const Text('Remove Account'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
