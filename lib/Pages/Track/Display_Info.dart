import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayInfo extends StatefulWidget {
  const DisplayInfo({super.key});

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {

  late double avg_duration = 0;
  late double avg_wakes = 0;
  late double avg_timeToSleep = 0;
  late double avg_quality = 0;

  @override
  void initState() {
    super.initState();
    fetchInfo();
  }

  void fetchInfo(){

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('numberValues').doc('duration').get().then((doc) {
      if (doc.exists) {
        setState(() {
          avg_duration = doc.data()?['value'];
        });
      }}).catchError((error) {
    });
    //
    firestore.collection('numberValues').doc('wakes').get().then((doc) {
      if (doc.exists) {
        setState(() {
          avg_wakes = doc.data()?['value'];
        });
      }}).catchError((error) {
    });
    firestore.collection('numberValues').doc('timeToSleep').get().then((doc) {
      if (doc.exists) {
        setState(() {
          avg_timeToSleep = doc.data()?['value'];
        });
      }}).catchError((error) {
    });
    firestore.collection('numberValues').doc('quality').get().then((doc) {
      if (doc.exists) {
        setState(() {
          avg_quality = doc.data()?['value'];
        });
      }}).catchError((error) {
    });
  }

  @override
  Widget build(BuildContext context) {

    fetchInfo();
    String formattedAvgDuration = avg_duration.toStringAsFixed(2);
    String formattedAvgWakes = avg_wakes.toStringAsFixed(2);
    String formattedAvgtimeToSleep = avg_timeToSleep.toStringAsFixed(2);
    String formattedAvgquality = avg_quality.toStringAsFixed(2);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AVG Duration ${formattedAvgDuration}'),
            Text('AVG Wakes ${formattedAvgWakes}'),
            Text('AVG timeToSleep ${formattedAvgtimeToSleep}'),
            Text('AVG quality ${formattedAvgquality}'),
          ],
        ),
      ),
    );
  }
}
