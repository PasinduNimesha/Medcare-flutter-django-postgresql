import 'package:mediconnect/models/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future createUser({required String user}) async {
    try {
      var response = await http.post(
          Uri.parse("http://10.0.2.2:8000/api/users/create/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: user);
      print(response.toString());
    } catch (error) {
      print("Error: " + error.toString());
    }
  }
}
