import 'package:flutter/material.dart';

void main() {
  runApp(PolyphasicExplain());
}
class PolyphasicExplain extends StatelessWidget {
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
                              "PolyPhasic Sleep",
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
                          "Polyphasic sleep is an alternative sleep schedule where instead of having one long sleep at night, you break it up into shorter naps throughout the day. It's like dividing your sleep into smaller chunks.With a simple interface, users can tap a timer when they're awake and another when they're sleeping.",
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
