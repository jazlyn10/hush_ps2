import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: QualityGraphPage([7.0, 8.0, 6.5, 9.0, 5.5]),
  ));
}

class QualityGraphPage extends StatelessWidget {
  final List<double> qualityData; // List of historical curr_quality values

  QualityGraphPage(this.qualityData);

  final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    List<FlSpot> qualitySpots = qualityData.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value;
      return FlSpot(index.toDouble(), value);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Sleep Graph'),
        backgroundColor: Color(0xFF233C67),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                'Sleep Duration Graph',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Imagine the graph as a sleepy roller coaster. \n\n\n'
                    'Going up means more sleep time, going down means less. In the first graph, you tell the app when you sleep. In the second graph, the app uses the phone to know. High points on the graph are like saying, I had a great sleep!. Low points mean, I might need more snoozes!',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              // SizedBox(height: 10),
              // Container(
              //   height: 300,
              //   child: qualityLineChart(qualitySpots),
              // ),
              SizedBox(height: 20),
              Text(
                'Sleep Duration Graph',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SleepDurationGraph(),
              SizedBox(height: 20),
              Text(
                'Sleep Duration Graph (Auto)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SleepDurationGraphAuto(),
              // Make sure this line is present// Display the QualityLineChart widget
            ],
          ),
        ),
      ),
    );
  }


}

class SleepDurationGraph extends StatefulWidget {
  @override
  _SleepDurationGraphState createState() => _SleepDurationGraphState();
}

class _SleepDurationGraphState extends State<SleepDurationGraph> {
  List<SleepEntry> sleepEntries = [];
  final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  double currSleep = 0.0; // Variable to store the current sleep duration

  @override
  void initState() {
    super.initState();
    fetchSleepData();
    fetchCurrSleep(); // Fetch the current sleep duration
  }

  Future<void> fetchSleepData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> accumulatedData = prefs.getStringList("accumulated_sleep_data") ?? [];

    for (String entryJson in accumulatedData) {
      Map<String, dynamic> entryMap = json.decode(entryJson);
      SleepEntry entry = SleepEntry.fromJson(entryMap);
      sleepEntries.add(entry);
    }

    setState(() {});
  }

  Future<void> fetchCurrSleep() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double currSleepValue = prefs.getDouble("curr_sleep") ?? 0.0;

    setState(() {
      currSleep = currSleepValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> durationSpots = sleepEntries.asMap().entries.map((entry) {
      int index = entry.key;
      SleepEntry sleepEntry = entry.value;
      return FlSpot(index.toDouble(), sleepEntry.sleepDuration.toDouble() / 60.0); // Convert to hours
    }).toList();

    List<FlSpot> currSleepSpot = [
      FlSpot(sleepEntries.length.toDouble(), currSleep),
      FlSpot((sleepEntries.length + 1).toDouble(), currSleep),
    ]; // Create spots for the current sleep duration curve

    List<FlSpot> spots = [...durationSpots, ...currSleepSpot]; // Combine both data sets

    return Container(
      height: 300,
      child: durationLineChart(spots),
    );
  }

  LineChart durationLineChart(List<FlSpot> spots) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return '${value.toInt()}h';
            },
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              if (value.toInt() >= 0 && value.toInt() < sleepEntries.length) {
                SleepEntry sleepEntry = sleepEntries[value.toInt()];
                return daysOfWeek[value.toInt()];
              } else if (value.toInt() == sleepEntries.length) {
                return 'Today';
              }
              return '';
            },
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            colors: [Colors.green, Colors.red], // Colors for duration and current sleep
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
class SleepDurationGraphAuto extends StatefulWidget {
  @override
  _SleepDurationGraphAutoState createState() => _SleepDurationGraphAutoState();
}

class _SleepDurationGraphAutoState extends State<SleepDurationGraphAuto> {
  List<SleepEntry> accumulatedSleepData = [];
  final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    fetchAccumulatedSleepData();
  }
  void fetchAccumulatedSleepData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> accumulatedData = prefs.getStringList("accumulated_sleep_data") ?? [];

    for (String entryJson in accumulatedData) {
      Map<String, dynamic> entryMap = json.decode(entryJson);
      SleepEntry entry = SleepEntry.fromJson(entryMap);
      accumulatedSleepData.add(entry);
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    List<FlSpot> durationSpots = accumulatedSleepData.asMap().entries.map((entry) {
      int index = entry.key;
      SleepEntry sleepEntry = entry.value;
      return FlSpot(index.toDouble(), sleepEntry.sleepDuration.toDouble() / 60.0);
    }).toList();

    return Container(
      height: 300,
      child: durationLineChart(durationSpots),
    );
  }
  LineChart durationLineChart(List<FlSpot> spots) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return '${value.toInt()}h';
            },
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              if (value.toInt() >= 0 && value.toInt() < accumulatedSleepData.length) {
                SleepEntry sleepEntry = accumulatedSleepData[value.toInt()];
                return sleepEntry.date;
              }
              return '';
            },
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            colors: [Colors.green, Colors.red],
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
class QualityLineChart extends StatefulWidget {
  @override
  _QualityLineChartState createState() => _QualityLineChartState();
}

class _QualityLineChartState extends State<QualityLineChart> {
  List<double> qualityData = [];
  final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    fetchQualityData();
  }

  void fetchQualityData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double currQuality = prefs.getDouble("curr_quality") ?? 0.0;
    String currQualityDate = prefs.getString("curr_quality_date") ?? "";

    List<double> accumulatedQualityData = prefs.getStringList("accumulated_quality_data")?.map((value) => double.parse(value)).toList() ?? [];

    print("currQuality: $currQuality");
    print("currQualityDate: $currQualityDate");

    setState(() {
      qualityData = accumulatedQualityData;
      if (currQualityDate.isNotEmpty) {
        // Add the current quality data with the recorded date
        DateTime recordedDate = DateTime.parse(currQualityDate);
        String formattedDate = DateFormat('EEE, MMM d').format(recordedDate);
        print("formattedDate: $formattedDate");
        qualityData.add(currQuality);
        daysOfWeek.add(formattedDate);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    List<FlSpot> qualitySpots = qualityData.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value;
      return FlSpot(index.toDouble(), value);
    }).toList();

    return Container(
      height: 300,
      child: qualityLineChart(qualitySpots),
    );
  }

  LineChart qualityLineChart(List<FlSpot> spots) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              int index = value.toInt();
              if (index >= 0 && index < daysOfWeek.length) {
                return daysOfWeek[index];
              }
              return '';
            },
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            colors: [Colors.blue],
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}


// SleepEntry class definition
class SleepEntry {
  final String date;
  int sleepDuration;
  int disturbances;

  SleepEntry({
    required this.date,
    required this.sleepDuration,
    required this.disturbances,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'sleepDuration': sleepDuration,
      'disturbances': disturbances,
    };
  }

  factory SleepEntry.fromJson(Map<String, dynamic> json) {
    return SleepEntry(
      date: json['date'],
      sleepDuration: json['sleepDuration'],
      disturbances: json['disturbances'],
    );
  }
}