import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/role_selection/widgets/RoleTile.dart';

class RoleSelectionScaffold extends StatelessWidget {
  const RoleSelectionScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Redirect to the previous screen
        return false; // Prevents default back button behavior
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mediconnect.png'),
              fit: BoxFit.cover, // Adjust the image's size and position
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'I am a,',
                  style: TextStyle(
                    fontSize: 50, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.black, // Text color over the background
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    RoleTile(
                      icon: Icons.local_hospital,
                      iconColor: Colors.black,
                      label: 'Doctor',
                      onPressedRoute: 'doctor_registration',
                    ),
                    SizedBox(width: 20),
                    RoleTile(
                      icon: Icons.person,
                      iconColor: Colors.black,
                      label: 'Patient',
                      onPressedRoute: 'patient_registration',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
