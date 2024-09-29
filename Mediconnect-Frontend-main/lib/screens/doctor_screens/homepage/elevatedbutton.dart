import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ElevatedButton elevationbutton(String nameOfButton) {
  return ElevatedButton(
    onPressed: () {
      // Add your onPressed logic here
      if (kDebugMode) {
        print('$nameOfButton button pressed!');
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor:Colors.white ,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: Colors.black), 
      ),
      //backgroundColor: Colors.blue,
      
    ),
    child: Text(
      nameOfButton,
      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),
    ),
  );
}
