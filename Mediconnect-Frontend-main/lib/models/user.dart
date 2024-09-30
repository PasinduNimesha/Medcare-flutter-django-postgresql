import 'dart:convert';

class User {
  int User_ID;
  String Email;
  String Password;
  String Device_ID;

  User(
      {required this.User_ID,
      required this.Email,
      required this.Password,
      required this.Device_ID});

  String toMap() {
    return jsonEncode(<String, dynamic>{
          
        'User_ID': User_ID,
        'Email': Email,
        'Password': Password,
        'Device_ID': Device_ID
      
        });
  }

  static User fromMap(Map<String, dynamic> doc) {
    return User(
        User_ID: doc['User_ID'],
        Email: doc['Email'],
        Password: doc['Password'],
        Device_ID: doc['Device_ID']);
  }
}
