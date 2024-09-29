import 'package:flutter/material.dart';
import '../../create_account & login/login/LoginScreen.dart'; // Import RegisterScreen

class ForegroundContent extends StatelessWidget {
  const ForegroundContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.65), // Semi-transparent overlay
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent, // Make AppBar transparent
              elevation: 0, // Remove shadow
              title: const Text(
                'Welcome',
                style: TextStyle(color: Colors.white), // White text for contrast
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'MediConnect',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color for contrast
                      ),
                    ),
                    const Text(
                      'Your Healthcare Companion',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Text color for contrast
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to RegisterScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
