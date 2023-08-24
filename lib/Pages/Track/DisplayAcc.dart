import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'accelerometer.dart';

class DisplayAcc extends StatelessWidget {
  final List<SleepEntry> sleepEntries;

  DisplayAcc({required this.sleepEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Data Visualization'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sleep Data Visualization',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SleepDataLineChart(sleepEntries: sleepEntries),
          ],
        ),
      ),
    );
  }
}

class SleepDataLineChart extends StatelessWidget {
  final List<SleepEntry> sleepEntries;

  SleepDataLineChart({required this.sleepEntries});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 300,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTextStyles: (context, value) => const TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 12),
                    getTitles: (value) {
                      final DateTime date = DateTime.parse(sleepEntries[value.toInt()].date);
                      return DateFormat('MM/dd').format(date);
                    },
                    margin: 10,
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 12),
                    getTitles: (value) {
                      // Convert minutes to hours and display on Y-axis
                      return '${(value / 60).toInt()}h';
                    },
                    margin: 12,
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: const Color(0xff37434d), width: 1),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: sleepEntries
                        .asMap()
                        .entries
                        .map((entry) =>
                        FlSpot(entry.key.toDouble(), entry.value.sleepDuration.toDouble()))
                        .toList(),
                    isCurved: true,
                    colors: [Colors.blue],
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Interpreting the Graph:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            '- Each point on the graph represents a date and the corresponding sleep duration.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            '- The X-axis shows the dates, while the Y-axis shows sleep duration in hours.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            '- The curve represents trends in sleep duration over time.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          Text(
            '- Longer curves indicate longer sleep duration, and shorter curves indicate shorter sleep duration.',
            style: TextStyle(fontSize: 14),
          ),

        ],
      ),
    );
  }
}

