import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hush/Pages/Homepage.dart';
import 'package:hush/Pages/login.dart';
import 'package:hush/auth/auth_page.dart';
import 'package:hush/bottom_navBar.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              //user is logged in
              if (snapshot.hasData){
                return  NavBar();
              }
              //user is not logged in
              else{
                return  Authpage();
              }
            },
          )
      ),
    );
  }
}
