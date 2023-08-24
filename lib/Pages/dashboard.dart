
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hush/Pages/profile.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SleepQualityGraph.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late double avg_duration = 0;

  late double avg_wakes = 0;

  late double avg_timeToSleep = 0;

  late double avg_quality = 0;

  @override
  void initState() {
    super.initState();
    fetchInfo();
  }

  Future<void> fetchInfo() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    avg_duration = await prefs.getDouble('avg_sleep') ?? 0.0;
    avg_wakes = await prefs.getDouble('avg_wakeup') ?? 0.0;
    avg_timeToSleep = await prefs.getDouble('avg_rested') ?? 0.0;
    avg_quality = await prefs.getDouble('avg_quality') ?? 0.0;
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {

    fetchInfo();
    String formattedAvgDuration = avg_duration.toStringAsFixed(2);
    String formattedAvgWakes = avg_wakes.toStringAsFixed(2);
    String formattedAvgtimeToSleep = avg_timeToSleep.toStringAsFixed(2);
    String formattedAvgquality = avg_quality.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF233C67),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Ionicons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.fromLTRB(80, 0, 50, 0),
          child: Text('Profile'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: const [
                  SizedBox(
                    width: 190,
                    height: 110,
                    child: CircleAvatar(
                      child: Image(
                        image: AssetImage(profilepic),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 30,
              ),
              Text(
                'Track your sleep below!!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 40,
              ),

              Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF233C67),
                  borderRadius: BorderRadius.circular(10),
                ),
                // padding: const EdgeInsets.all(60),
                padding: const EdgeInsets.fromLTRB(60, 45, 60, 45),
                // margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [

                    Text(
                      'Average Sleep Duration ',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      '${formattedAvgDuration}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 29),
              Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF233C67),
                  borderRadius: BorderRadius.circular(10),
                ),
                // padding: const EdgeInsets.all(60),
                padding: const EdgeInsets.fromLTRB(68, 45, 68, 45),
                // margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'Average Sleep Quality ',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      '${formattedAvgWakes}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 29,
              ),
              Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF233C67),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.fromLTRB(58, 45, 58, 45),
                // margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'Average Sleep Wake-Ups',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      '${formattedAvgtimeToSleep}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 29,
              ),
              Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF233C67),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.fromLTRB(35, 45, 35, 45),
                // margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'Average Ease in falling Asleep',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      '${formattedAvgquality}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),



              //Last Container
            ],
          ),
        ),
      ),
    );
  }
}





// Positioned(
// top: 0,
// bottom: 0,
// child: Container(
// height: 35,
// width: 35,
// decoration: const BoxDecoration(
// borderRadius: BorderRadius.circular(100),
// color: Colors.yellowAccent,
// ),
// child: const Icon(
// Ionicons.camera,
// size: 23,
// ),
// ),),

//
// Card(
// margin: EdgeInsets.all(10),
// color: Colors.greenAccent,
// child: Padding(
// padding: const EdgeInsets.fromLTRB(66, 20, 66, 90),
// child: Text(
// 'Average Sleep Score',
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.w300,
// fontFamily: 'Times New Roman'),
// ),
// ),
// ),
