import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: non_constant_identifier_names
Future<bool> SendData(String title,String fromhour,String fromminute,String fromAmPm,String tohour,String tominute,String toAmPm,bool repeat,String Repeatchoice,String Repeatchoicecount,
String venue,List<bool> daystate) async {
  // Define the URL to make the POST request to
  final url = Uri.parse('https://example.com/url'); /////////// this is a sample url

  // Define the data to be sent in the POST request
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, dynamic> body = {
    'title': title,
    'fromhour': fromhour,
    'fromminute': fromminute,
    'fromAmPm':fromAmPm,
     'tohour': tohour,
    'tominute': tominute,
    'toAmPm':toAmPm,
    'status of repeat button':repeat,
    'repeat choice':Repeatchoice,
    'repeat choice count':Repeatchoicecount,
    'venue':venue,
    'selected days':daystate,


  };

  try {
    // Make the POST request
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );

    // Check the response status code
    if (response.statusCode==200) {
      // Parse and print the JSON response
     // final data = json.decode(response.body);
      if (kDebugMode) {
        print('succesfully add to the server');
      }
      
      return true;
    } else {
      // Handle non-201 status codes
      if (kDebugMode) {
        print('Failed to post data. Status code: ${response.statusCode}');
      }
      return false;
    }
  } catch (e) {
    // Handle errors such as network issues
    if (kDebugMode) {
      print('Error: $e');
    }
    return false;
  }
}
