import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorRepository {
  http.Client client;

  // Inject the client dependency (defaulting to http.Client)
  DoctorRepository({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> createDoctor({required String doctor}) async {
    try {
      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/doctors/create/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: doctor,
      );
      final data = jsonDecode(response.body);
      if (data == null) {
        return {"status": "error", "message": "Something went wrong"};
      } else {
        return data;
      }
    } catch (error) {
      print("Error: " + error.toString());
      throw Exception("Failed to create doctor");
    }
  }
}
