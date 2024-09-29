import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/create_account%20&%20login/widgets/facebook_sign_in_button.dart';
import 'package:mediconnect/screens/common_screens/role_selection/RoleSelection.dart';
import '../../widgets/widgets.dart';
//import '../role_selection/role_selection_screen.dart'; // Import role selection screen

class LoginScaffold extends StatefulWidget {
  const LoginScaffold({super.key});

  @override
  State<LoginScaffold> createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<LoginScaffold> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(), // Use the background image
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                // Title at the top
                const Padding(
                  padding: EdgeInsets.only(top: 50.0), // Add padding from the top
                  child: Text(
                    'Login to Your Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: BlurredBox(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // Reduce the box size based on content
                          children: [
                            EmailField(),
                            const SizedBox(height: 20),
                            PasswordField(),
                            const SizedBox(height: 20),
                            LoginButton(),
                            const SizedBox(height: 20),
                            const Text('Or', style: TextStyle(color: Colors.black)),
                            const SizedBox(height: 10),
                            GoogleSignInButton(),
                            const SizedBox(height: 10),
                            FacebookSignInButton(),
                            const SizedBox(height: 20),
                            const Text('Do not have an account?', style: TextStyle(color: Colors.black)),
                            CreateAnAccount(),
                            const SizedBox(height: 20),
                            // Bypass Login Button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              ),
                              child: const Text(
                                'Bypass Login',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
