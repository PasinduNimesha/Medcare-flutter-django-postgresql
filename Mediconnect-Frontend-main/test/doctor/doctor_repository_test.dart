import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mediconnect/repository/doctor_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'doctor_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('DoctorRepository', () {
    test('createDoctor sends correct data and parses response', () async {
      final mockResponse = {
        "status": "success",
        "message": "Doctor created successfully",
        "data": {
          "id": 1,
          "First_name": "John",
          "Last_name": "Doe",
          "Other_name": "A",
          "Birthday": "1990-01-01",
          "Street_No": "123",
          "Street_Name": "Main Street",
          "City": "Metropolis",
          "Postal_Code": "12345",
          "NIC": "123456789V",
          "Specialization": "Cardiology",
          "Reg_num": "DOC123",
          "ID_photo": 123
        }
      };
      final client = MockClient();
      final doctorRepository = DoctorRepository();
      doctorRepository.client = client;

      // Set up the mock to return a successful response
      when(client.post(
        Uri.parse("http://10.0.2.2:8000/api/doctors/create/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      // Call the createDoctor function
      var response = await doctorRepository.createDoctor(
        doctor: jsonEncode({
          'User_ID': 1,
          'First_name': 'John',
          'Last_name': 'Doe',
          'Other_name': 'A',
          'Birthday': '1990-01-01',
          'Street_No': '123',
          'Street_Name': 'Main Street',
          'City': 'Metropolis',
          'Postal_Code': '12345',
          'NIC': '123456789V',
          'Specialization': 'Cardiology',
          'Reg_num': 'DOC123',
          'ID_photo': 123
        }),
      );

      // Verify the response data
      expect(response, isNotNull);
      expect(response['status'], 'success');
      expect(response['message'], 'Doctor created successfully');
      expect(response['data']['First_name'], 'John');
      expect(response['data']['Last_name'], 'Doe');
      expect(response['data']['Reg_num'], 'DOC123');
    });

    test('throws an exception if the http call completes with an error', () async {
      final client = MockClient();
      final doctorRepository = DoctorRepository();
      doctorRepository.client = client;

      // Set up the mock to return an error response
      when(client.post(
        Uri.parse("http://10.0.2.2:8000/api/doctors/create/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"error": "Server error"}', 500));

      // Call the createDoctor function and check for exception
      try {
        await doctorRepository.createDoctor(
          doctor: jsonEncode({
            'User_ID': 1,
            'First_name': 'John',
            'Last_name': 'Doe',
            'Other_name': 'A',
            'Birthday': '1990-01-01',
            'Street_No': '123',
            'Street_Name': 'Main Street',
            'City': 'Metropolis',
            'Postal_Code': '12345',
            'NIC': '123456789V',
            'Specialization': 'Cardiology',
            'Reg_num': 'DOC123',
            'ID_photo': 123
          }),
        );
        fail('Expected an exception to be thrown');
      } catch (error) {
        // Verify that an error is thrown when the status code is 500
        expect(error, isA<Exception>());
      }
    });
  });

}
