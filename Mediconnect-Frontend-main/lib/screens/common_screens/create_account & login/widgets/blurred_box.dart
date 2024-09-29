import 'package:flutter/material.dart';
import 'dart:ui'; // For blur effect

class BlurredBox extends StatelessWidget {
  final Widget child;

  const BlurredBox({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // Blur background
          child: Container(
            width: 350.0, // Increased width for content readability
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25), // More opacity for the box to be whitish
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.5), // Slightly more visible border
              ),
            ),
            child: child, // Embed input fields and buttons here
          ),
        ),
      ),
    );
  }
}