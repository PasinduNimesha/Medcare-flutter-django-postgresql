import 'package:flutter/material.dart';
import 'view/view.dart'; // Import the view which contains the scaffold

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleSelectionScaffold(); // Use the scaffold from the view
  }
}
