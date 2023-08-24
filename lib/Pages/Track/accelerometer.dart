import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'DisplayAcc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SleepData(),
    );
  }
}

class SleepData extends StatefulWidget {
  const SleepData({Key? key}) : super(key: key);

  @override
  State<SleepData> createState() => _SleepDataState();
}

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

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("sleep_duration_${this.date}", this.sleepDuration);
    await prefs.setInt("disturbances_${this.date}", this.disturbances);
  }

  static Future<List<SleepEntry>> fetchAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    List<SleepEntry> sleepEntries = [];
    for (String key in keys) {
      if (key.startsWith("sleep_duration_")) {
        String dateKey = key.replaceFirst("sleep_duration_", "");
        int sleepDuration = prefs.getInt(key) ?? 0;
        int disturbances = prefs.getInt("disturbances_$dateKey") ?? 0;
        sleepEntries.add(SleepEntry(
          date: dateKey,
          sleepDuration: sleepDuration,
          disturbances: disturbances,
        ));
      }
    }

    return sleepEntries;
  }
}

class _SleepDataState extends State<SleepData> {
  bool isSleeping = false;
  bool previousSleepState = false;
  double sleepThreshold = 0.003;
  DateTime? sleepStartTime;
  DateTime? sleepEndTime;
  List<Duration> sleepDurations = [];
  List<int> sleepDurationsInMinutes = [];
  int disturbanceCounter = 0;
  List<SleepEntry> accumulatedSleepData = [];
  StreamSubscription<UserAccelerometerEvent>? accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    initAccelerometer();
    fetchAccumulatedSleepData();
  }

  @override
  void dispose() {
    accelerometerSubscription?.cancel();
    super.dispose();
  }

  Future<void> saveAccumulatedSleepData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> accumulatedData = accumulatedSleepData.map((entry) => json.encode(entry.toJson())).toList();
    await prefs.setStringList("accumulated_sleep_data", accumulatedData);
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

  void onAwakeButtonClicked() async {
    if (sleepStartTime != null) {
      String formattedDate = DateFormat.yMd().format(sleepStartTime!);
      int existingEntryIndex = accumulatedSleepData.indexWhere((entry) => entry.date == formattedDate);

      if (existingEntryIndex != -1) {
        accumulatedSleepData[existingEntryIndex].sleepDuration += getSleepDuration().inMinutes;
        accumulatedSleepData[existingEntryIndex].disturbances += disturbanceCounter;
      } else {
        SleepEntry sleepEntry = SleepEntry(
          date: formattedDate,
          sleepDuration: getSleepDuration().inMinutes,
          disturbances: disturbanceCounter,
        );
        accumulatedSleepData.add(sleepEntry);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayAcc(sleepEntries: accumulatedSleepData),
            ));

      }

      sleepStartTime = null;
      sleepEndTime = null;
      disturbanceCounter = 0;

      await saveAccumulatedSleepData();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllDataPage(
            sleepEntries: accumulatedSleepData,
          ),
        ),
      );
    }
  }

  void initAccelerometer() {
    accelerometerSubscription = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        detectSleep(event);
      });
    });
  }

  Map<DateTime, int> disturbanceData = {};

  void detectSleep(UserAccelerometerEvent event) {
    double magnitude = (event.x * event.x) + (event.y * event.y) + (event.z * event.z);

    if (magnitude < sleepThreshold) {
      setState(() {
        if (!previousSleepState) {
          sleepStartTime = DateTime.now();
          previousSleepState = true;
        }
        isSleeping = true;
      });
    } else {
      setState(() {
        if (previousSleepState) {
          sleepEndTime = DateTime.now();
          if (sleepStartTime != null && sleepEndTime != null) {
            Duration sleepDuration = sleepEndTime!.difference(sleepStartTime!);
            int sleepDurationInMinutes = sleepDuration.inMinutes;
            if (sleepDurationInMinutes >= 30) {
              sleepDurations.add(sleepDuration);
              sleepDurationsInMinutes.add(sleepDurationInMinutes);
              disturbanceData[sleepStartTime!] = disturbanceCounter;

              accumulatedSleepData.add(
                SleepEntry(
                  date: DateFormat.yMd().format(sleepStartTime!),
                  sleepDuration: sleepDurationInMinutes,
                  disturbances: disturbanceCounter,
                ),
              );

              disturbanceCounter = 0;
            }
          }
        }
        isSleeping = false;
      });
      previousSleepState = false;
    }
  }

  String formatTime(DateTime? time) {
    if (time == null) {
      return 'N/A';
    }
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String formatDuration(Duration duration) {
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
  }

  List<SleepEntry> createSleepEntries() {
    List<SleepEntry> entries = [];

    for (DateTime date in getDailySleepData().keys) {
      String formattedDate = DateFormat.yMd().format(date);
      Duration sleepDuration = getDailySleepData()[date]!;
      int disturbances = disturbanceData[date] ?? 0;

      SleepEntry entry = SleepEntry(
        date: formattedDate,
        sleepDuration: sleepDuration.inMinutes,
        disturbances: disturbances,
      );

      entries.add(entry);
    }

    return entries;
  }

  Duration getTotalSleepDuration() {
    return sleepDurations.fold(Duration.zero, (previous, current) => previous + current);
  }

  Duration getSleepDuration() {
    if (sleepStartTime != null && isSleeping) {
      DateTime currentTime = DateTime.now();
      return currentTime.difference(sleepStartTime!);
    }
    return Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    List<SleepEntry> sleepEntries = createSleepEntries();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF233C67),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Current Sleep Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.data_usage),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllDataPage(sleepEntries: accumulatedSleepData),
                ),
              );
            },
          ),
          TextButton(
            onPressed: onAwakeButtonClicked,
            child: Text(
              'Awake',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayAcc(sleepEntries: accumulatedSleepData), // Pass the sleepEntries list
                ),
              );
            },
            child: Text(
              'Show Chart',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isSleeping ? 'Sleeping' : 'Awake',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                isSleeping ? 'Time started sleeping: ${formatTime(sleepStartTime!)}' : 'Time started sleeping: -',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                isSleeping ? 'Time slept: ${formatDuration(getSleepDuration())}' : 'Time slept: -',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Total Time Slept: ${formatDuration(getTotalSleepDuration())}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Sleep Disturbances: ${sleepDurationsInMinutes.length}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Sleep durations:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: sleepDurationsInMinutes.map((durationInMinutes) {
                  return Text(
                    formatDuration(Duration(minutes: durationInMinutes)),
                    style: TextStyle(fontSize: 16),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<DateTime, Duration> getDailySleepData() {
    Map<DateTime, Duration> dailySleepData = {};

    if (sleepStartTime != null) {
      for (int i = 0; i < sleepDurations.length; i++) {
        DateTime sleepDate = sleepStartTime!.add(sleepDurations[i]);

        dailySleepData.update(
          DateTime(sleepDate.year, sleepDate.month, sleepDate.day),
              (value) => value + sleepDurations[i],
          ifAbsent: () => sleepDurations[i],
        );
      }
    }

    return dailySleepData;
  }
}
class AllDataPage extends StatelessWidget {
  final List<SleepEntry>? sleepEntries;

  AllDataPage({required this.sleepEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Data'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF233C67), // Set the app bar color
      ),
      body: sleepEntries != null && sleepEntries!.isNotEmpty
          ? ListView.builder(
        itemCount: sleepEntries!.length,
        itemBuilder: (context, index) {
          SleepEntry entry = sleepEntries![index];

          return ListTile(
            title: Text(entry.date),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sleep Duration: ${entry.sleepDuration}'),
                Text('Disturbances: ${entry.disturbances}'),
              ],
            ),
          );
        },
      )
          : Center(
        child: Text('No sleep data available.'),
      ),
    );
  }
}
