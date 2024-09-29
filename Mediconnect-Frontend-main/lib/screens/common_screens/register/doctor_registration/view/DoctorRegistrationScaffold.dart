import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/create_account%20&%20login/widgets/background_image.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/DoctorRegistrationForm.dart';
// import '../../../common_screens/register/widgets/address_fields.dart';
// import '../../../common_screens/register/widgets/birthday_field.dart';
// import '../../../common_screens/register/widgets/name_fields.dart';
// import '../../../common_screens/register/widgets/nic_field.dart';
import '../../../create_account & login/widgets/blurred_box.dart';
import '../widgets/widgets.dart';
//import 'DoctorRegistrationForm.dart';

class DoctorRegistrationScaffold extends StatelessWidget {
  const DoctorRegistrationScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Registration'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(), // Background Image
          BlurredBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const DoctorRegistrationForm(), // Add the Doctor Registration Form here
            ),
          ),
        ],
      ),
    );
  }
}
