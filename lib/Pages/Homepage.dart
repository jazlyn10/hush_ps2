

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:hush/Components/carousel_card.dart';
import 'package:hush/Pages/tic_tac_toe.dart';
import 'Journal1/note1.dart';
import 'SlumberQuest/main_menu.dart';
import 'Track/Track_homepage.dart';
import 'Track/RelaxersInfo.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void navigatebottombar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser!;

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
            child: Text(
              'Hello ${(user.displayName?.indexOf(" ") == -1) ? user.displayName : user.displayName?.substring(0, user.displayName?.indexOf(" ")) ?? "User"}',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Better your sleep with Hush!',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
          ),
          const Carousel(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: Text(
                'Improve your sleep using',
                style: TextStyle(
                    fontFamily: 'Poppins-med', fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      child: Container(
                        height: 152,
                        width: 152,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(11)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteListScreen()),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image(
                              image:
                              AssetImage('assets/images/sleep journal.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                      child: Container(
                        height: 152,
                        width: 152,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(11)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrackPage()),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image(
                              image: AssetImage('assets/images/sleeptrack.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenu()),
                  );
                },
                child: Container(
                  child: Image(image: AssetImage('assets/images/enjoy2.png')),
                )),
          ),

          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RelaxersInfo()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20),
              child: Row(
                children: [
                  Text(
                    'Try our Relaxers',
                    style: TextStyle(
                        fontFamily: 'Poppins-med', fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Find out why',
                    style: TextStyle(
                      fontFamily: 'Poppins-med',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),



          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(11)),
                        child: Image(
                            image: AssetImage('assets/images/tictactoe.gif')),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        ]),
      ),
    );
  }
}
