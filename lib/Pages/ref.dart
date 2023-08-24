import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepEntry {
  final DateTime date;
  final int sleepDuration;
  final int disturbances;

  SleepEntry({
    required this.date,
    required this.sleepDuration,
    required this.disturbances,
  });

  // Method to fetch all SleepEntry instances from shared preferences
  static Future<List<SleepEntry>> fetchAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    List<SleepEntry> sleepEntries = [];
    for (String key in keys) {
      if (key.startsWith("sleep_duration_")) {
        String dateKey = key.replaceFirst("sleep_duration_", "");
        DateTime entryDate = DateTime.parse(dateKey); // Parse the date
        int sleepDuration = prefs.getInt(key) ?? 0;
        int disturbances = prefs.getInt("disturbances_$dateKey") ?? 0;
        sleepEntries.add(SleepEntry(
          date: entryDate,
          sleepDuration: sleepDuration,
          disturbances: disturbances,
        ));
      }
    }

    return sleepEntries;
  }
}

class AllDataPage extends StatefulWidget {
  @override
  _AllDataPageState createState() => _AllDataPageState();
}

class _AllDataPageState extends State<AllDataPage> {
  List<SleepEntry> sleepEntries = [];

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    // Fetch all SleepEntry instances from shared preferences
    sleepEntries = await SleepEntry.fetchAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Data'),
      ),
      body: ListView.builder(
        itemCount: sleepEntries.length,
        itemBuilder: (context, index) {
          SleepEntry entry = sleepEntries[index];
          return ListTile(
            title: Text(entry.date.toString()), // Display the DateTime object
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sleep Duration: ${Duration(minutes: entry.sleepDuration).toString().split('.').first}'),
                Text('Disturbances: ${entry.disturbances}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AllDataPage(),
  ));
}



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AllDataPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF233C67),
//         title: Text('All Data'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('sleep_data').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final dailySleepData = _getDailySleepDataFromSnapshot(snapshot.data!);
//             return ListView.builder(
//               itemCount: dailySleepData.length,
//               itemBuilder: (context, index) {
//                 final date = dailySleepData.keys.elementAt(index);
//                 final sleepData = dailySleepData[date];
//                 return ListTile(
//                   title: Text('Date: ${date.toLocal()}'),
//                   subtitle: sleepData != null
//                       ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Sleep Duration: ${formatDuration(sleepData['duration']) ?? 'N/A'}'),
//                       Text('Disturbances: ${sleepData['disturbances'] ?? 'N/A'}'),
//                     ],
//                   )
//                       : Text('Sleep Data Not Available'),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
//
//   String formatDuration(Duration duration) {
//     return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
//   }
//
//   Map<DateTime, Map<String, dynamic>> _getDailySleepDataFromSnapshot(QuerySnapshot snapshot) {
//     Map<DateTime, Map<String, dynamic>> dailySleepData = {};
//
//     snapshot.docs.forEach((doc) {
//       Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
//       if (data != null) {
//         DateTime? date = DateTime.tryParse(data['date'] ?? '');
//         int? durationInMinutes = data['duration_in_minutes'];
//         int? disturbances = data['disturbances'];
//
//         if (date != null && durationInMinutes != null && disturbances != null) {
//           dailySleepData[date] = {
//             'duration': Duration(minutes: durationInMinutes),
//             'disturbances': disturbances,
//           };
//         }
//       }
//     });
//
//     return dailySleepData;
//   }
// }


































//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SleepData(),
//     );
//   }
// }
//
// class SleepData extends StatefulWidget {
//   const SleepData({Key? key}) : super(key: key);
//
//   @override
//   State<SleepData> createState() => _SleepDataState();
// }
//
// class SleepEntry {
//   final String date;
//   final int sleepDuration;
//   final int disturbances;
//
//   SleepEntry({
//     required this.date,
//     required this.sleepDuration,
//     required this.disturbances,
//   });
//
//   // Add a toJson method to convert SleepEntry to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'date': date,
//       'sleepDuration': sleepDuration,
//       'disturbances': disturbances,
//     };
//   }
//
//   // Add a factory constructor to create SleepEntry from a JSON map
//   factory SleepEntry.fromJson(Map<String, dynamic> json) {
//     return SleepEntry(
//       date: json['date'],
//       sleepDuration: json['sleepDuration'],
//       disturbances: json['disturbances'],
//     );
//   }
//
//   Future<void> save() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt("sleep_duration_${this.date}", this.sleepDuration);
//     await prefs.setInt("disturbances_${this.date}", this.disturbances);
//   }
//
//   // Fetch all SleepEntry instances from shared preferences
//   static Future<List<SleepEntry>> fetchAll() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Set<String> keys = prefs.getKeys();
//
//     List<SleepEntry> sleepEntries = [];
//     for (String key in keys) {
//       if (key.startsWith("sleep_duration_")) {
//         String dateKey = key.replaceFirst("sleep_duration_", "");
//         int sleepDuration = prefs.getInt(key) ?? 0;
//         int disturbances = prefs.getInt("disturbances_$dateKey") ?? 0;
//         sleepEntries.add(SleepEntry(
//           date: dateKey,
//           sleepDuration: sleepDuration,
//           disturbances: disturbances,
//         ));
//       }
//     }
//
//     return sleepEntries;
//   }
// }
//
// class _SleepDataState extends State<SleepData> {
//   bool isSleeping = false;
//   bool previousSleepState = false;
//   double sleepThreshold = 0.003;
//   DateTime? sleepStartTime;
//   DateTime? sleepEndTime;
//   List<Duration> sleepDurations = [];
//   List<int> sleepDurationsInMinutes = [];
//   int disturbanceCounter = 0;
//   List<SleepEntry> accumulatedSleepData = [];
//   StreamSubscription<UserAccelerometerEvent>? accelerometerSubscription;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize accelerometer
//     initAccelerometer();
//     // Fetch accumulated sleep data
//     fetchAccumulatedSleepData();
//   }
//
//   @override
//   void dispose() {
//     // Cancel the accelerometer subscription to prevent calling setState after dispose
//     accelerometerSubscription?.cancel();
//     super.dispose();
//   }
//
//   void fetchAccumulatedSleepData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> accumulatedData = prefs.getStringList("accumulated_sleep_data") ?? [];
//
//     for (String entryJson in accumulatedData) {
//       Map<String, dynamic> entryMap = json.decode(entryJson);
//       SleepEntry entry = SleepEntry.fromJson(entryMap);
//       accumulatedSleepData.add(entry);
//     }
//
//     setState(() {});
//   }
//
//   // Move the saveAccumulatedSleepData method here
//   void saveAccumulatedSleepData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> accumulatedData = accumulatedSleepData.map((entry) => json.encode(entry.toJson())).toList();
//     await prefs.setStringList("accumulated_sleep_data", accumulatedData);
//   }
//
//   void initAccelerometer() {
//     // Store the subscription in the instance variable
//     accelerometerSubscription = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       setState(() {
//         detectSleep(event);
//       });
//     });
//   }
//
//   Map<DateTime, int> disturbanceData = {};
//
//   void detectSleep(UserAccelerometerEvent event) {
//     double magnitude = (event.x * event.x) + (event.y * event.y) + (event.z * event.z);
//
//     if (magnitude < sleepThreshold) {
//       setState(() {
//         if (!previousSleepState) {
//           sleepStartTime = DateTime.now();
//           previousSleepState = true;
//         }
//         isSleeping = true;
//       });
//     } else {
//       setState(() {
//         if (previousSleepState) {
//           sleepEndTime = DateTime.now();
//           if (sleepStartTime != null && sleepEndTime != null) {
//             Duration sleepDuration = sleepEndTime!.difference(sleepStartTime!);
//             int sleepDurationInMinutes = sleepDuration.inMinutes;
//             if (sleepDurationInMinutes >= 2) {
//               sleepDurations.add(sleepDuration);
//               sleepDurationsInMinutes.add(sleepDurationInMinutes);
//               disturbanceData[sleepStartTime!] = disturbanceCounter;
//
//               // Accumulate sleep data during the day
//               accumulatedSleepData.add(
//                 SleepEntry(
//                   date: DateFormat.yMd().format(sleepStartTime!),
//                   sleepDuration: sleepDurationInMinutes,
//                   disturbances: disturbanceCounter,
//
//                 ),
//               );
//
//               disturbanceCounter = 0;
//             }
//           }
//
//         }
//         isSleeping = false;
//       });
//       previousSleepState = false;
//     }
//   }
//
//   String formatTime(DateTime time) {
//     return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
//   }
//
//   String formatDuration(Duration duration) {
//     return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
//   }
//
//   List<SleepEntry> createSleepEntries() {
//     List<SleepEntry> entries = [];
//
//     for (DateTime date in getDailySleepData().keys) {
//       String formattedDate = DateFormat.yMd().format(date);
//       Duration sleepDuration = getDailySleepData()[date]!; // Sleep duration in minutes
//       int disturbances = disturbanceData[date] ?? 0;
//
//       SleepEntry entry = SleepEntry(
//         date: formattedDate,
//         sleepDuration: sleepDuration.inMinutes, // Convert sleep duration to minutes
//         disturbances: disturbances,
//       );
//
//       entries.add(entry);
//     }
//
//     return entries;
//   }
//
//   Duration getTotalSleepDuration() {
//     return sleepDurations.fold(Duration.zero, (previous, current) => previous + current);
//   }
//
//   Duration getSleepDuration() {
//     if (sleepStartTime != null && isSleeping) {
//       DateTime currentTime = DateTime.now();
//       return currentTime.difference(sleepStartTime!);
//     }
//     return Duration.zero;
//   }
//
//
//   void onAwakeButtonClicked() async {
//     // Create a SleepEntry instance for the current sleep session
//     SleepEntry sleepEntry = SleepEntry(
//       date: DateFormat.yMd().format(sleepStartTime!),
//       sleepDuration: getSleepDuration().inMinutes,
//       disturbances: disturbanceCounter,
//     );
//
//     // Save the SleepEntry instance to shared preferences
//     await sleepEntry.save();
//
//
//     // Navigate to the AllDataPage after saving the data
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AllDataPage(sleepEntries: accumulatedSleepData),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<SleepEntry> sleepEntries = createSleepEntries();
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xFF233C67),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: Text('Current Sleep Data'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.data_usage),
//               onPressed: () {
//                 // Navigate to the AllDataPage
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AllDataPage(sleepEntries: accumulatedSleepData),
//                   ),
//                 );
//               },
//             ),
//             TextButton(
//               onPressed: onAwakeButtonClicked,
//               child: Text(
//                 'Awake',
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//           ],
//
//           // Add the "Awake" button to save accumulated sleep data
//           //   TextButton(
//           //     onPressed: () {
//           //       // Call the function to save accumulated sleep data to shared preferences
//           //       saveAccumulatedSleepData();
//           //     },
//           //     child: Text(
//           //       'Awake',
//           //       style: TextStyle(fontSize: 16, color: Colors.white),
//           //     ),
//           //   ),
//           // ],
//
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   isSleeping ? 'Sleeping' : 'Awake',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   isSleeping ? 'Time started sleeping: ${formatTime(sleepStartTime!)}' : 'Time started sleeping: -',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   isSleeping ? 'Time slept: ${formatDuration(getSleepDuration())}' : 'Time slept: -',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Total Time Slept: ${formatDuration(getTotalSleepDuration())}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Sleep Disturbances: ${sleepDurationsInMinutes.length}',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Sleep durations:',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Column(
//                   children: sleepDurationsInMinutes.map((durationInMinutes) {
//                     return Text(
//                       formatDuration(Duration(minutes: durationInMinutes)),
//                       style: TextStyle(fontSize: 16),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Map<DateTime, Duration> getDailySleepData() {
//     Map<DateTime, Duration> dailySleepData = {};
//
//     for (int i = 0; i < sleepDurations.length; i++) {
//       DateTime sleepDate = sleepStartTime!.add(sleepDurations[i]);
//
//       {
//         dailySleepData.update(
//           DateTime(sleepDate.year, sleepDate.month, sleepDate.day),
//               (value) => value + sleepDurations[i],
//           ifAbsent: () => sleepDurations[i],
//         );
//       }
//     }
//
//     return dailySleepData;
//   }
//
// }
//
// class AllDataPage extends StatelessWidget {
//   final List<SleepEntry> sleepEntries;
//
//   AllDataPage({required this.sleepEntries});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Data'),
//       ),
//       body: ListView.builder(
//         itemCount: sleepEntries.length,
//         itemBuilder: (context, index) {
//           SleepEntry entry = sleepEntries[index];
//           return ListTile(
//             title: Text(entry.date),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Sleep Duration: ${entry.sleepDuration}'),
//                 Text('Disturbances: ${entry.disturbances}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//
