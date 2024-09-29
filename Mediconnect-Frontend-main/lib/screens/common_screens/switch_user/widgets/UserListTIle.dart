import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final VoidCallback onTap;

  const UserListTile({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('$email ($role)'),  // Shows the user's email and role
      onTap: onTap,
    );
  }
}
