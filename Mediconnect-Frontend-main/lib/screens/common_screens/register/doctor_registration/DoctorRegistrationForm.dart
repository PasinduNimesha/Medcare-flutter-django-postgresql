import 'package:flutter/material.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/widgets/DoctorIDField.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/widgets/DoctorIDUpload.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/widgets/SpecializationDropdown.dart';
import 'package:mediconnect/screens/common_screens/register/doctor_registration/widgets/VisitingHospitalField.dart';
import 'package:mediconnect/screens/common_screens/register/widgets/register_button.dart';
import '../../../common_screens/register/widgets/address_fields.dart';
import '../../../common_screens/register/widgets/birthday_field.dart';
import '../../../common_screens/register/widgets/name_fields.dart';
import '../../../common_screens/register/widgets/nic_field.dart';

class DoctorRegistrationForm extends StatefulWidget {
  const DoctorRegistrationForm({super.key});

  @override
  _DoctorRegistrationFormState createState() => _DoctorRegistrationFormState();
}

class _DoctorRegistrationFormState extends State<DoctorRegistrationForm> {
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
  final _doctorIDController = TextEditingController();

  // Variables for dropdowns
  String? _selectedSpecialization;
  List<VisitingHospitalField> _hospitalFields = [VisitingHospitalField()]; // Initialize with one hospital field

  // Function to add a new hospital field
  void _addHospitalField() {
    setState(() {
      _hospitalFields.add(VisitingHospitalField());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Add Scaffold to provide Material context
      appBar: AppBar(
        title: const Text('Doctor Registration'),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mediconnect.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
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
                    SpecializationDropdown(
                      selectedSpecialization: _selectedSpecialization,
                      onSpecializationChanged: (specialization) {
                        setState(() {
                          _selectedSpecialization = specialization;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    DoctorIDField(doctorIDController: _doctorIDController),
                    const SizedBox(height: 20),
                    DoctorIDUpload(),
                    const SizedBox(height: 20),
                    Column(
                      children: _hospitalFields,
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.add_circle, size: 30, color: Colors.green),
                      onPressed: _addHospitalField,
                    ),
                    const SizedBox(height: 20),
                    RegisterButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle doctor registration
                        }
                      }, 
                      selectedRole: "Doctor",
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
