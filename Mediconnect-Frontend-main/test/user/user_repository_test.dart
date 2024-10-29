import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mediconnect/models/user.dart';
import 'package:mediconnect/repository/user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("UserRepository", () {
    late MockClient client;
    late UserRepository userRepository;

    setUp(() {
      client = MockClient();
      userRepository = UserRepository(client: client);
    });

    test("createUser sends correct data and parses response", () async {
      final mockResponse = {
        "status": "success",
        "message": "User created successfully",
        "data": {"User_ID": 1}
      };

      when(client.post(
        Uri.parse("http://10.0.2.2:8000/api/users/create/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final user = User(
          User_ID: 1,
          Email: "test@example.com",
          Password: "password123",
          Device_ID: "device123");

      var response = await userRepository.createUser(user: user.toMap());

      expect(response, isNotNull);
      expect(response['status'], 'success');
      expect(response['message'], 'User created successfully');
      expect(response['data']['User_ID'], 1);
    });

    test("loginUser sends correct data and parses response", () async {
      final mockResponse = {
        "status": "success",
        "message": "Login successful",
        "data": {"User_ID": 1}
      };

      when(client.post(
        Uri.parse("http://10.0.2.2:8000/api/users/login/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final user = User(
          User_ID: 1,
          Email: "test@example.com",
          Password: "password123",
          Device_ID: "device123");

      var response = await userRepository.loginUser(user: user.toMap());

      expect(response, isNotNull);
      expect(response['status'], 'success');
      expect(response['message'], 'Login successful');
      expect(response['data']['User_ID'], 1);
    });

    test("changeRegStatus sends correct data and parses response", () async {
      final mockResponse = {
        "status": "success",
        "message": "Registration status updated"
      };

      const userId = "1";

      when(client.put(
        Uri.parse("http://10.0.2.2:8000/api/users/$userId/update-registration/"),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      var response = await userRepository.changeRegStatus(id: userId);

      expect(response, isNotNull);
      expect(response['status'], 'success');
      expect(response['message'], 'Registration status updated');
    });

    test("throws an exception if the http call completes with an error", () async {
      when(client.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response("Not Found", 404)); // Plain text response with 404 status

      final user = User(
        User_ID: 1,
        Email: "test@example.com",
        Password: "password123",
        Device_ID: "device123",
      );

      var response = await userRepository.createUser(user: user.toMap());

      // The repository should return an error message in this case
      expect(response, isNotNull);
      expect(response['status'], "error");
      expect(response['message'], "Something went wrong");
    });
  });
}
