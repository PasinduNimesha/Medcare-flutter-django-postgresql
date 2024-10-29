import 'dart:convert';
import 'package:mediconnect/models/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final http.Client client;

  // Injecting client through the constructor
  UserRepository({http.Client? client}) : client = client ?? http.Client();

  Future<dynamic> createUser({required String user}) async {
    try {
      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/users/create/"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: user,
      );

      if (response.statusCode != 200) {
        // Return a default error response if the status is not 200
        return {"status": "error", "message": "Something went wrong"};
      }

      final data = jsonDecode(response.body);
      if (data == null) {
        return {"status": "error", "message": "Something went wrong"};
      } else {
        return data;
      }
    } catch (error) {
      print("Error: " + error.toString());
    }
  }


  Future<dynamic> loginUser({required String user}) async {
    try {
      var response = await client.post(
        Uri.parse("http://10.0.2.2:8000/api/users/login/"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: user,
      );
      final data = jsonDecode(response.body);
      if (data == null) {
        return {"status": "error", "message": "Something went wrong"};
      } else {
        return data;
      }
    } catch (error) {
      print("Error: " + error.toString());
    }
  }

  Future<dynamic> changeRegStatus({required String id}) async {
    try {
      var response = await client.put(
        Uri.parse('http://10.0.2.2:8000/api/users/$id/update-registration/'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, String>{"empty": "empty"}),
      );
      final data = jsonDecode(response.body);
      if (data == null) {
        return {"status": "error", "message": "Something went wrong"};
      } else {
        return data;
      }
    } catch (error) {
      print("Error: " + error.toString());
    }
  }
}
