import 'package:flutter/material.dart';
import 'view/view.dart';

class SearchResultsPage extends StatelessWidget {
  final String? doctorName;
  final String? disease;
  final String? medicalCenter;
  final String? date;
  final String? time;
  final Map<String, dynamic> searchData;  

  const SearchResultsPage({
    super.key,
    this.doctorName,
    this.disease,
    this.medicalCenter,
    this.date,
    this.time, required this.searchData,
  });

  @override
  Widget build(BuildContext context) {
    return SearchResultsScaffold(
      doctorName: doctorName,
      disease: disease,
      medicalCenter: medicalCenter,
      date: date,
      time: time,
      searchData: searchData,
    );
  }
}
