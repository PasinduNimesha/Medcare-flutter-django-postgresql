import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mediconnect/models/patient.dart';
import 'package:mediconnect/repository/patient_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'patient_repository_test.mocks.dart';

// Generate a MockClient using the Mockito package.
@GenerateMocks([http.Client])
void main() {
  group("PatientRepository", () {
    test("createPatient sends correct data and parses response", () async {
      final mockResponse = {
        "status": "success",
        "message": "Patient created successfully",
        "data": {"Patient_ID": "12345"}
      };

      // Create a MockClient instance
      final client = MockClient();
      // Pass the mock client to the PatientRepository
      final patientRepository = PatientRepository(client: client);

      // Setup the mock response
      when(client.post(
        Uri.parse("http://10.0.2.2:8000/api/patient/create/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      // Create a Patient instance
      final patient = Patient(
        User_ID: "1",
        Patient_ID: "12345",
        First_name: "John",
        Last_name: "Doe",
        Other_name: "Johnny",
        Birthday: "1990-01-01",
        Street_No: "123",
        Street_Name: "Main St",
        City: "Anytown",
        Postal_Code: "12345",
        NIC: "NIC123456",
        Breakfast_time: "08:00 AM",
        Lunch_time: "12:00 PM",
        Dinner_time: "07:00 PM",
      );

      // Make the call to create a patient using the mock client
      var response = await patientRepository.createPatient(patient: jsonEncode(patient.toString()));

      // Verify the response
      expect(response, isNotNull);
      expect(response['status'], 'success');
      expect(response['message'], 'Patient created successfully');
      expect(response['data']['Patient_ID'], '12345');
    });

    test("createPatient returns error when server response is not 200", () async {
      final client = MockClient();
      final patientRepository = PatientRepository(client: client);

      when(client.post(
        Uri.parse("http://10.0.2.2:8000/api/patient/create/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Not Found', 404));

      final patient = Patient(
        User_ID: "1",
        Patient_ID: "12345",
        First_name: "John",
        Last_name: "Doe",
        Other_name: "Johnny",
        Birthday: "1990-01-01",
        Street_No: "123",
        Street_Name: "Main St",
        City: "Anytown",
        Postal_Code: "12345",
        NIC: "NIC123456",
        Breakfast_time: "08:00 AM",
        Lunch_time: "12:00 PM",
        Dinner_time: "07:00 PM",
      );

      var response = await patientRepository.createPatient(patient: jsonEncode(patient.toString()));

      expect(response, isNotNull);
      expect(response['status'], 'error');
      expect(response['message'], contains("Something went wrong"));
    });
  });
}
