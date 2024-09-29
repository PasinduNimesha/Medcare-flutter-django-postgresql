import 'package:flutter/material.dart';

Widget buildToggleField(String label, {required bool enabled, required void Function(bool) onChanged, Widget? child}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Switch(
            value: enabled,
            onChanged: onChanged,
            activeColor: Colors.green,
          ),
        ],
      ),
      if (enabled && child != null) child,
      const SizedBox(height: 10),
    ],
  );
}
