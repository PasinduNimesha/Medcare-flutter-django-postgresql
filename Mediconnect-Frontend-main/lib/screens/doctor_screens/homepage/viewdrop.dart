import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final String? initialLocation;
  final ValueChanged<String?>? onChanged;

  const MyDropdownButton({super.key, this.initialLocation, this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String? _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 0,
                    offset: const Offset(0, 3),
                  ),
                ],
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     offset: const Offset(0, 0), // Shadow only at the bottom
        //     blurRadius: 1.0,
        //   ),
        // ],
      ),
      child: Center(child: 
       DropdownButton<String>(
        value: _currentState,
        items: const <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: "maharagama",
            child: Text("maharagama hospital"),
          ),
          DropdownMenuItem<String>(
            value: "kalupovila",
            child: Text("kalupovila hospital"),
          ),
        ],
        onChanged: (String? newValue) {
          setState(() {
            _currentState = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
          if (newValue != null) {
            if (kDebugMode) {
              print(newValue);
            }
          }
        },
        style: const TextStyle(
          color: Colors.grey, // Text color
        ),
        iconEnabledColor: Colors.grey, // Icon color
        underline: Container(), // Removes the default underline
      ),
    ),);
  }
}
