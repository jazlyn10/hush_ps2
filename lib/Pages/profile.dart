import 'dart:ffi';
import 'SleepQualityGraph.dart';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/aboutuspage.dart';
import '../Components/termspage.dart';
import '../auth/auth_page.dart';
import '../bottom_navBar.dart';
import 'dashboard.dart';
import 'Track/accelerometer.dart';
import 'Track/AccelerometerExplain.dart';
import 'Track/PolyphasicExplain.dart';
import 'Track/PolyphasicSleepApp.dart';
import 'SleepQualityGraph.dart';

void removeAllAndPushNew(BuildContext context, Widget newPage) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => newPage),
        (Route<dynamic> route) => false,
  );
}

final user = FirebaseAuth.instance.currentUser!;

class ProfileScreen extends StatelessWidget {
  String username = "User";
  late String email;

  Future<void> getDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      username = user.displayName ?? username;
      email = user.email ?? "Error Fetching Email";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF233C67),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            );
          },
          icon: Icon(Ionicons.arrow_back),
        ),
        title: Center(child: Text('Profile')),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Settings()),
                // );
                print(user);
              },
              icon: Icon(Ionicons.settings_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 180,
                height: 110,
                child: CircleAvatar(
                  child: Image(
                    image: AssetImage(profilepic),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<void>(
                future: getDetails(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        Text(
                          '${username}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${email}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),

              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen()),
                  );
                },
                child: SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SleepData()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5, // Add space to the left
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 170,
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(
                              'Record Your Sleep',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccelerometerExplain()),
                          );
                        },
                        child: Icon(
                          Icons.help_outline,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PolyphasicSleepApp()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5, // Add space to the left
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 170,
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(
                              'Track Polyphasic sleep',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PolyphasicExplain()),
                          );
                        },
                        child: Icon(
                          Icons.help_outline,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: 25,
              ),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QualityGraphPage([7.0, 8.0, 6.5, 9.0, 5.5])),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 5,
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 170,
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(
                              'Sleep Graph',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PolyphasicExplain()),
                          );
                        },
                        child: Icon(
                          Icons.help_outline,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),







              SizedBox(
                height: 34,
              ),
              Divider(),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Ionicons.newspaper,
                    color: Color(0xFF233C67),
                  ),
                  title: Center(
                      child: Text(
                        'Terms & Conditions',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
                      )),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => termspage(),
                        ),
                      );
                    },
                    child: Icon(
                      Ionicons.arrow_forward_circle,
                      color: Color(0xFF233C67),
                      size: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Ionicons.lock_closed,
                    color: Color(0xFF233C67),
                  ),
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 50, 0),
                    child: Center(
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
                        )),
                  ),
                  trailing: Icon(
                    Ionicons.arrow_forward_circle,
                    color: Color(0xFF233C67),
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: ListTile(
                  leading: Icon(
                    Ionicons.information_circle,
                    color: Color(0xFF233C67),
                  ),
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 99, 0),
                    child: Center(
                        child: Text(
                          'About',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
                        )),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => aboutuspage(),
                        ),
                      );
                    },
                    child: Icon(
                      Ionicons.arrow_forward_circle,
                      color: Color(0xFF233C67),
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
                child: SizedBox(
                  height: 55,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.setBool("loggedIn", false);
                      print(FirebaseAuth.instance.currentUser);
                      Widget newPage = Authpage();
                      removeAllAndPushNew(context, newPage);
                      print("logout");
                    },
                    child: ListTile(
                      leading: Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        child: Icon(
                          Ionicons.log_out,
                          color: Colors.red,
                        ),
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const profilepic = 'assets/images/man.png';

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
