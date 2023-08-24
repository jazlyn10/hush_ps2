import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hush/Pages/Homepage.dart';
// import 'package:hush/Pages/sleeponbo.dart';
// import 'package:hush/bottom_navBar.dart';
// import 'package:hush/main_page.dart';
// import 'package:hush/Pages/login.dart';
// import 'package:hush/Pages/Register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/sleeponbo.dart';
import 'bottom_navBar.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';



late bool isLoggedIn;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = await prefs.getBool('loggedIn') ?? false;
  runApp( Home());
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: (isLoggedIn) ? NavBar() : SplashScreen(),
    );
  }
}


