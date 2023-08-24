// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:hush/Pages/profile.dart';
//
//
// Future<void> initialiseService() async{
//   final service = FlutterBackgroundService();
//   await service.configure(
//     iosConfiguration: IosConfiguration(),
//       androidConfiguration: AndroidConfiguration(
//           onStart: onStart, isForegroundMode: true, autoStart: true),
//   );
// }
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   if (service is AndroidServiceInstance){
//     service.on('setAsForeground').listen((event){
//       service.setAsForegroundService();
//     });
//     service.on('setAsBackground').listen((event){
//       service.setAsBackgroundService();
//
//     });
//   }
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if(service is AndroidServiceInstance){
//       if(await service.isForegroundService()) {
//         service.setForegroundNotificationInfo(
//             title: "hush", content: "Track your sleep");
//       }
//
//     }
//     //perform operation on background
//     print("background service running");
//     service.invoke('update');
//
//   });
// }