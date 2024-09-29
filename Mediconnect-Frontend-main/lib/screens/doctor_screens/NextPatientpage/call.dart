import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ElevatedButton call() {
  return ElevatedButton(
    onPressed: () {
      // Add your onPressed logic here
      if (kDebugMode) {
        print('Call button pressed!');
      }
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor:const Color.fromARGB(255, 74, 224, 79),
      
    ),
    child: const Text(
      "Call",
      style: TextStyle(fontSize: 16,color: Colors.black ),
    ),
  );
}
