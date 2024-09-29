import 'package:flutter/material.dart';
import 'package:mediconnect/screens/doctor_screens/StatsPage/widgets/appointmenttable.dart';
import 'package:mediconnect/screens/doctor_screens/StatsPage/widgets/rating.dart';
import 'package:fl_chart/fl_chart.dart';

class Barchart extends StatelessWidget {
  const Barchart({super.key});

  ///////////////////////////////////////////////////////  this part shows booked Appointment ////////////////////////////////////////////////////
  // ignore: non_constant_identifier_names
  static List<BarChartGroupData> createSampleAppointmentData() {
    final data = [
      Barmodel('Mon', 10),
      Barmodel('Tue', 40),
      Barmodel('Wed', 50),
      Barmodel('Thu', 100),
      Barmodel('Fri', 75),
      Barmodel('Sat', 65),
      Barmodel('Sun', 80),
    ];

    return data.asMap().entries.map((entry) {
      int index = entry.key;
      Barmodel barmodel = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: barmodel.count.toDouble(),
            color: Colors.green,
            width: 20,
            borderRadius: BorderRadius.circular(0),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "STATS",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Appointments Summary",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: createSampleAppointmentData(),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barTouchData: BarTouchData(enabled: true),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Appointment Detail", style: TextStyle(fontWeight: FontWeight.bold)),
            const Appointment_Table(),
            const SizedBox(height: 20),
            const Text("Rate", style: TextStyle(fontWeight: FontWeight.bold)),
            Rating(4.5),
          ],
        ),
      ),
    );
  }
}

class Barmodel {
  final String year;
  final int count;
  Barmodel(this.year, this.count);
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Barchart(),
    );
  }
}