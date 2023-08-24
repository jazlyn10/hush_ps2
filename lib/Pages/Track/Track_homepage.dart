// import 'dart:js';

// import 'package:hush/bottom_navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'DisplayInfo.dart';
import '../../bottom_navBar.dart';
import '../Homepage.dart';
import 'Display_Info.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {

  late int questionIndex;
  late ValueNotifier<int> number;
  late List<int> numberValues; // Store previous number button values


  void previousQuestion() {
    setState(() {
      if (questionIndex > 0) {
        numberValues[questionIndex] = number.value; // Store current number button value
        questionIndex--;
        number.value = numberValues[questionIndex]; // Retrieve number button value for the previous case
      }
    });
  }

  @override
  void initState() {
    super.initState();
    questionIndex = 0;
    number = ValueNotifier<int>(0);
    numberValues = List<int>.filled(4, 0); // Initialize list with 4 elements, all set to 0
  }



  void nextQuestion(BuildContext context) {
    setState(() async {
      if (questionIndex < 3) {
        numberValues[questionIndex] = number.value;
        questionIndex++;
        number.value = numberValues[questionIndex]; // Retrieve number button value for the next case
        number.value = 0;
        setState(() {});
      } else if (questionIndex == 3) {

        numberValues[questionIndex] = number.value;



        double curr_sleep =  numberValues[0].toDouble();
        double curr_wakeup =  numberValues[1].toDouble();
        double curr_rested =  numberValues[2].toDouble();
        double curr_quality =  numberValues[3].toDouble();

        DateTime currentDate = DateTime.now();
        String dateString = currentDate.toIso8601String();

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        int cnt = prefs.getInt('cnt') ?? 0;
        double avg_sleep = prefs.getDouble('avg_sleep') ?? 0.0;
        double avg_wakeup = prefs.getDouble('avg_wakeup') ?? 0.0;
        double avg_rested = prefs.getDouble('avg_rested') ?? 0.0;
        double avg_quality = prefs.getDouble('avg_quality') ?? 0.0;

        double new_avg_sleep = ((numberValues[0] + (avg_sleep * cnt)) / (cnt + 1));
        double new_avg_wakeup = ((numberValues[1] + (avg_wakeup * cnt)) / (cnt + 1));
        double new_avg_rested = ((numberValues[2] + (avg_rested * cnt)) / (cnt + 1));
        double new_avg_quality = ((numberValues[3] + (avg_quality * cnt)) / (cnt + 1));

        await prefs.setDouble('avg_sleep',new_avg_sleep);
        await prefs.setDouble('avg_wakeup',new_avg_wakeup);
        await prefs.setDouble('avg_rested',new_avg_rested);
        await prefs.setDouble('avg_quality',new_avg_quality);
        var new_cnt = cnt+1;
        await prefs.setInt('cnt',new_cnt);

        // Store the curr_sleep value and date in shared preferences
        await prefs.setDouble('curr_sleep', curr_sleep);
        await prefs.setString('curr_sleep_date', dateString);

        // Store the curr_quality value and date in shared preferences
        await prefs.setDouble('curr_quality', curr_quality);
        await prefs.setString('curr_quality_date', dateString);


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );



      }
    });
  }

  void decreaseNumber() {
    setState(() {
      if (number.value > 0) {
        number.value--;
      }
    });
  }

  void increaseNumber() {
    setState(() {
      number.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/sleepassesbg.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 324,
                  height: 462,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(33),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: previousQuestion,
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 152,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: (questionIndex + 1) / 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF233C67),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 0),
                      buildQuestion(questionIndex),
                      const SizedBox(height: 7),
                      buildImage(questionIndex),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedButton(
                            backgroundColor: const Color(0xFFFDFCFF),
                            icon: Icons.remove,
                            onPressed: decreaseNumber,
                          ),
                          const SizedBox(width: 16),
                          NumberButton(number: number),
                          const SizedBox(width: 16),
                          RoundedButton(
                            backgroundColor: const Color(0xFFFDFCFF),
                            icon: Icons.add,
                            onPressed: increaseNumber,
                          ),
                        ],
                      ),

                      //NEXT BUTTON

                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (questionIndex == 3) {
                            const Text('Submit');
                            nextQuestion(context);
                          } else {
                            nextQuestion(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF233C67),
                          ),
                        ),
                        child: Text(questionIndex == 3 ? 'Submit' : 'Next'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildQuestion(int questionIndex) {
  switch (questionIndex) {
    case 0:
      return const Text(
        'How long did you sleep tonight?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    case 1:
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            'How many times did you wake',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            'up in the middle of the night?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    case 2:
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            'How easily do you fall asleep',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            '    on a scale of 0 to 10?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    case 3:
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            'How would you rate the quality of',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'your sleep on a scale of 0 to 10',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      );
    default:
      return const SizedBox.shrink();
  }
}





Widget buildImage(int questionIndex) {
  switch (questionIndex) {
    case 0:
      return Image.asset(
        'assets/images/sleepasses1.png',
        width: 200,
      );
    case 1:
      return Image.asset(
        'assets/images/sleepasses2.png',
        width: 200,
      );
    case 2:
      return Image.asset(
        'assets/images/sleepasses3.png',
        width: 200,
      );
    case 3:
      return Image.asset(
        'assets/images/sleepasses4.png',
        width: 200,
      );
    default:
      return const SizedBox.shrink();
  }
}

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  const RoundedButton({
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}


class NumberButton extends StatelessWidget {
  final ValueNotifier<int> number;

  NumberButton({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: number,
          builder: (context, value, _) {
            return Text(
              value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}