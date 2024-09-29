import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/register/widgets/address_fields.dart';
import 'package:mediconnect/screens/common_screens/register/widgets/birthday_field.dart';
import 'package:mediconnect/screens/common_screens/register/widgets/name_fields.dart';
import 'package:mediconnect/screens/common_screens/register/widgets/nic_field.dart';
import 'package:mediconnect/screens/common_screens/register/widgets/register_button.dart';
import 'package:mediconnect/screens/common_screens/welcome/widgets/BackgroundImage.dart';
import '../widgets/widgets.dart';
import 'package:mediconnect/screens/patient_screens/home/home_page/HomePage.dart'; // Import the Home Screen after registration
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientRegistrationScaffold extends StatefulWidget {
  const PatientRegistrationScaffold({super.key});

  @override
  _PatientRegistrationScaffoldState createState() =>
      _PatientRegistrationScaffoldState();
}

class _PatientRegistrationScaffoldState
    extends State<PatientRegistrationScaffold> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _otherNamesController = TextEditingController();
  final _streetNoController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _nicController = TextEditingController();
  final _birthdayController = TextEditingController();

  // Variables for dropdowns and time pickers
  TimeOfDay? _breakfastTime;
  TimeOfDay? _lunchTime;
  TimeOfDay? _dinnerTime;

  Future<void> _registerUser() async {
    final url = Uri.parse('https://your-backend-url.com/api/register/');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'other_names': _otherNamesController.text,
        'street_no': _streetNoController.text,
        'street_name': _streetNameController.text,
        'city': _cityController.text,
        'postal_code': _postalCodeController.text,
        'nic': _nicController.text,
        'birthday': _birthdayController.text,
        'breakfast_time': _breakfastTime?.format(context),
        'lunch_time': _lunchTime?.format(context),
        'dinner_time': _dinnerTime?.format(context),
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      _showErrorDialog(context, 'Registration failed. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Registration'),
      ),
      body: Stack(
        children: [
          const BackgroundImage(), // Background Image
          Padding(
            padding: const EdgeInsets.all(16.0), // Use Padding instead of BlurredBox
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NameFields(
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      otherNamesController: _otherNamesController,
                    ),
                    const SizedBox(height: 20),
                    BirthdayField(birthdayController: _birthdayController),
                    const SizedBox(height: 20),
                    AddressFields(
                      streetNoController: _streetNoController,
                      streetNameController: _streetNameController,
                      cityController: _cityController,
                      postalCodeController: _postalCodeController,
                    ),
                    const SizedBox(height: 20),
                    NICField(nicController: _nicController),
                    const SizedBox(height: 20),
                    MealTimeFields(
                      breakfastTime: _breakfastTime,
                      lunchTime: _lunchTime,
                      dinnerTime: _dinnerTime,
                      onBreakfastChanged: (time) {
                        setState(() {
                          _breakfastTime = time;
                        });
                      },
                      onLunchChanged: (time) {
                        setState(() {
                          _lunchTime = time;
                        });
                      },
                      onDinnerChanged: (time) {
                        setState(() {
                          _dinnerTime = time;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    RegisterButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _registerUser();
                        }
                      },
                      selectedRole: 'Patient',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
