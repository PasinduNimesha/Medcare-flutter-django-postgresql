import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/widgets.dart';  // Import the widgets

class SwitchUserDialog extends StatefulWidget {
  const SwitchUserDialog({super.key});

  @override
  _SwitchUserDialogState createState() => _SwitchUserDialogState();
}

class _SwitchUserDialogState extends State<SwitchUserDialog> {
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('https://yourbackendapi.com/api/logged_in_users'));  // Update with your actual API endpoint

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          users = data['users'];  // Assume 'users' is a list of user objects returned from the backend
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Switch Account'),
      content: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListBody(
                children: users.map((user) {
                  return UserListTile(
                    name: user['name'],
                    email: user['email'],
                    role: user['role'],
                    onTap: () {
                      // Handle switching to this account
                      Navigator.of(context).pop();  // Close dialog after switching
                    },
                  );
                }).toList(),
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
  }
}
