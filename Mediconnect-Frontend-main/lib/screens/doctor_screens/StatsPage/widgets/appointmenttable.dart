import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class Appointment_Table extends StatefulWidget {
  const Appointment_Table({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Appointment_TableState createState() => _Appointment_TableState();
}

// ignore: camel_case_types
class _Appointment_TableState extends State<Appointment_Table> {
  bool _sortAscending = true;
  int _sortColumnIndex = 2;

  final List<Map<String, dynamic>> _data = [
    {
      'date': DateTime(2024, 9, 9),
      'hospital': 'Kalupovila',
      'time': DateTime(2024, 9, 9, 14, 30, 45),
      'no.booking': 10,
    },
    {
      'date': DateTime(2024, 9, 9),
      'hospital': 'Kalupovila',
      'time': DateTime(2024, 9, 9, 11, 30, 45),
      'no.booking': 10,
    },
    {
      'date': DateTime(2024, 9, 8),
      'hospital': 'Northen Central',
      'time': DateTime(2024, 9, 8, 12, 0, 0),
      'no.booking': 15,
    },
    {
      'date': DateTime(2024, 9, 7),
      'hospital': 'Maharagama',
      'time': DateTime(2024, 9, 7, 8, 45, 30),
      'no.booking': 20,
    },
  ];

  void _sort<T>(Comparable<T> Function(Map<String, dynamic> row) getField,
      int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _data.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _sort<DateTime>((row) => row['time'], _sortColumnIndex, _sortAscending);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: [
          const DataColumn(
            label: Text('Date'),
            numeric: false,
          ),
          const DataColumn(
            label: Text('Hospital'),
            numeric: false,
          ),
          DataColumn(
            label: const Text('Time'),
            onSort: (int columnIndex, bool ascending) {
              _sort<DateTime>((row) => row['time'], columnIndex, ascending);
            },
          ),
          const DataColumn(
            label: Text('No.Booking'),
            numeric: true,
          ),
        ],
        rows: _data.map((row) {
          final timeFormat = DateFormat('HH:mm');
          return DataRow(cells: [
            DataCell(
                Text(DateFormat('yyyy-MM-dd').format(row['date']))), // Format Date
            DataCell(Text(row['hospital'])),
            DataCell(Text(timeFormat.format(row['time']))), // Format Time
            DataCell(Text(row['no.booking'].toString())), // Ensure this is converted to string
          ]);
        }).toList(),
      ),
    );
  }
}