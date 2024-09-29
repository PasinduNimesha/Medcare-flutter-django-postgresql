import 'package:flutter/material.dart';

class DoctorIDUpload extends StatelessWidget {
  const DoctorIDUpload({super.key});

  Future<void> _uploadDoctorID() async {
    // Add logic for uploading the Doctor ID image
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            'Upload Doctor ID',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: _uploadDoctorID,
          child: const Text('Upload'),
        ),
      ],
    );
  }
}
