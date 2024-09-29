import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/welcome/GetStartedScreen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mediconnect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const GetStartedScreen()
    );
  }


}