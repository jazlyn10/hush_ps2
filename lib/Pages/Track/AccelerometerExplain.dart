import 'package:flutter/material.dart';

void main() {
  runApp(AccelerometerExplain());
}
class AccelerometerExplain extends StatelessWidget {
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
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Sleep Detection",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/sleepasses1.png', // Replace with your image path
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13),
                        child: Text(
                          "Enable automatic sleep detection when you enter your sleep hours to effortlessly gather essential sleep data. Obtain valuable insights such as sleep duration, disturbances, and timings on a daily basis. Note: For accurate results, please ensure that the app remains active throughout your sleep duration.",
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
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
