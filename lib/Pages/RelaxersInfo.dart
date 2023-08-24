import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF233C67), // #233C67
        toolbarHeight: 80, // Increase the height of the AppBar
        title: Row(
          children: [
            Text(
              "Play Relaxing Games",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0), // Add padding at the top
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Engaging in a relaxing game can take your mind off daily worries and concerns. It provides a mental break, allowing your brain to shift away from stressors that might keep you awake at night.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify, // Align the text justified
              ),
            ),
            SizedBox(height: 16), // Add space between paragraph and question mark icon
            Row(
              children: [
                Icon(
                  Icons.help_outline,
                  size: 50,
                ),
                SizedBox(width: 8),
                Text(
                  "DID YOU KNOW",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8), // Add space between "DID YOU KNOW" and fact paragraph
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Text(
                "Playing relaxing games can improve sleep quality. Studies have shown that engaging in enjoyable and low-stress activities like playing games can help reduce cortisol levels (the stress hormone) and promote better sleep.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}