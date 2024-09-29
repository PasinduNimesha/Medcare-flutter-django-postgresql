import 'package:flutter/material.dart';

class BirthdayField extends StatelessWidget {
  final TextEditingController birthdayController;

  const BirthdayField({super.key, required this.birthdayController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85), // Blurred background box
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: birthdayController,
        decoration: const InputDecoration(
          labelText: 'Birthday',
          hintText: 'Select Your Birthday',
        ),
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            birthdayController.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your birthday';
          }
          return null;
        },
      ),
    );
  }
}
