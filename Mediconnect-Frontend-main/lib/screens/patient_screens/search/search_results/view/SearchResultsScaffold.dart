import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mediconnect/screens/patient_screens/search/search_results/widgets/widgets.dart'; // For importing common widgets like the ResultCard

class SearchResultsScaffold extends StatelessWidget {
  final String? doctorName;
  final String? disease;
  final String? medicalCenter;
  final String? date;
  final String? time;

  const SearchResultsScaffold({
    super.key,
    this.doctorName,
    this.disease,
    this.medicalCenter,
    this.date,
    this.time,
  });

  Future<List<dynamic>> fetchSearchResults() async {
    final uri = Uri.parse('https://your-backend-url.com/api/search-results/');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'doctor_name': doctorName,
        'disease': disease,
        'medical_center': medicalCenter,
        'date': date,
        'time': time,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchSearchResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found.'));
          }

          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ResultCard(result: result);
            },
          );
        },
      ),
    );
  }
}
