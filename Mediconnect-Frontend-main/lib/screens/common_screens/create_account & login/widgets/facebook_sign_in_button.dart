import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
    required this.splashColor,
    required this.buttonBorderColor,
    required this.onPressed,
    this.buttonPadding = 6.0,
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

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: buttonBorderColor,
          );
        } else {
          bs = BorderSide.none;
        }

        return ButtonTheme(
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Adjust padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: bs,
              ),
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

class FacebookSignInButton extends StatelessWidget {
  Future<void> _handleFacebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Get the Facebook access token
        final accessToken = result.accessToken;

        // Send the Facebook token to your backend for verification
        final response = await http.post(
          Uri.parse('https://your-backend-api.com/api/facebook-login/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'token': accessToken?.token, // Send the Facebook access token
          }),
        );

        if (response.statusCode == 200) {
          // Successfully logged in
          print('Facebook login successful');
        } else {
          _showErrorMessage('Facebook login failed');
        }
      } else {
        _showErrorMessage('Facebook login failed');
      }
    } catch (error) {
      _showErrorMessage('Facebook login failed');
    }
  }

  void _showErrorMessage(String message) {
    // You can replace this with SnackBar or any other method
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Make the entire widget scrollable in landscape mode
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9, // Adjust button width dynamically
            child: StretchableButton(
              buttonColor: const Color(0xFF1877F2), // Facebook blue
              borderRadius: defaultBorderRadius,
              splashColor: Colors.blueAccent,
              buttonBorderColor: Colors.transparent, // Set the border color or use any desired color
              onPressed: _handleFacebookLogin,
              buttonPadding: 6.0, // Reduced padding for a smaller button
              centered: true,
              children: const <Widget>[
                Image(
                  image: AssetImage(
                    "assets/logos/flogo-HexRBG-Wht-100.png",
                  ),
                  height: 18.0, // Reduced image size for smaller button
                  width: 18.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.0, right: 10.0),
                  child: Text(
                    'Continue with Facebook',
                    style: TextStyle(
                      fontSize: 14.0, // Reduced font size for smaller button
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

extension on AccessToken? {
  get token => null;
}
