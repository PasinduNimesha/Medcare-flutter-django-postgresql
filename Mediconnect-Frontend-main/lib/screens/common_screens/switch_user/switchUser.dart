import 'package:flutter/material.dart';
import 'view/view.dart';

void switchUser(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const SwitchUserDialog();  // Reference to the dialog from the view folder
    },
  );
}
