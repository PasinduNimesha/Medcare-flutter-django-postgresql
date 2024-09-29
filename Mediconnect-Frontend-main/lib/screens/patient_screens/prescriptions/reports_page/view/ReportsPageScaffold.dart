import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ReportsScaffold extends StatelessWidget {
  final List<Map<String, dynamic>> reports = [
    {
      'date': 'March 10, 2024',
      'doctor': 'Dr. Sarah Johnson (Neurologist)',
      'reportType': 'MRI Scan',
      'pdfPath': 'assets/reports/mri_scan.pdf',
    },
    {
      'date': 'February 28, 2024',
      'doctor': 'Dr. John Doe (Cardiologist)',
      'reportType': 'Echocardiogram',
      'pdfPath': 'assets/reports/echocardiogram.pdf',
    },
    {
      'date': 'January 22, 2024',
      'doctor': 'Dr. Emma Wilson (Radiologist)',
      'reportType': 'Suger',
      'pdfPath': 'assets/reports/xray_report.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return ReportCard(report: report);
      },
    );
  }
}
