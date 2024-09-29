import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/mediconnect.png', // Background image
        fit: BoxFit.cover, // Make image cover the screen
      ),
    );
  }
}
