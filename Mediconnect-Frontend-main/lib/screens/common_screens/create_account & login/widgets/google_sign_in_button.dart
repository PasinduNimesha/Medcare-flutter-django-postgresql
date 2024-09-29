import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double buttonPadding;
  final Color buttonColor, splashColor;
  final Color buttonBorderColor;
  final List<Widget> children;
  final bool centered;

  StretchableButton({
    required this.buttonColor,
    required this.borderRadius,
    required this.children,
    this.splashColor = Colors.transparent,
    this.buttonBorderColor = Colors.transparent,
    required this.onPressed,
    this.buttonPadding = 8.0,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          if (centered) {
            contents.insert(0, Spacer());
          }
          contents.add(Spacer());
        }

        BorderSide bs = buttonBorderColor != Colors.transparent
            ? BorderSide(color: buttonBorderColor)
            : BorderSide.none;

        return ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: bs,
              ),
              padding: EdgeInsets.all(buttonPadding),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final response = await http.post(
          Uri.parse('https://your-backend-api.com/api/google-login/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'token': googleAuth.idToken}),
        );

        if (response.statusCode == 200) {
          print('Google login successful');
        } else {
          _showErrorMessage('Google login failed');
        }
      }
    } catch (error) {
      _showErrorMessage('Google login failed');
    }
  }

  void _showErrorMessage(String message) {
    // Show error message
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: Colors.white,
      borderRadius: defaultBorderRadius,
      splashColor: Colors.grey[300]!,
      buttonBorderColor: Colors.grey[400]!,
      onPressed: _handleGoogleSignIn,
      buttonPadding: 0.0,
      centered: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 30.0, // Match height for Google logo
            width: 30.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: Center(
              child: Image.asset(
                "assets/logos/google-logo.png",
              ),
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            'Sign in with Google',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
