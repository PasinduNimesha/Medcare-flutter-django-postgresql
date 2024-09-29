import 'package:flutter/material.dart';
import '../widgets/widgets.dart'; // Import widgets

class GetStartedScaffold extends StatelessWidget {
  const GetStartedScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          BackgroundImage(),
          ForegroundContent(),
        ],
      ),
    );
  }
}
