import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientRepository {
  final http.Client client;

  // Constructor with optional http.Client parameter for dependency injection
  PatientRepository({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> createPatient({required String patient}) async {
    try {
      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/patient/create/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: patient,
      );

      // Check for a successful response status
      if (response.statusCode != 200) {
        // Return a default error response if the status is not 200
        return {
          "status": "error",
          "message": "Something went wrong: ${response.reasonPhrase}"
        };
      }

      final data = jsonDecode(response.body);
      if (data == null) {
        return {
          "status": "error",
          "message": "Response data is null"
        };
      } else {
        return data;
      }
    } catch (error) {
      print("Error: " + error.toString());
      return {
        "status": "error",
        "message": "Something went wrong: ${error.toString()}"
      };
    }
  }
}
