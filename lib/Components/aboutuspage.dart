import 'package:flutter/material.dart';

class aboutuspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Hush'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Hush - Your Guide to Better Sleep!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'At Hush, our mission is to help you achieve a good night\'s sleep and wake up refreshed every morning. We are passionate about promoting healthy sleep habits and improving sleep quality for our users.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Our Team:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Mentor: Dr. Nishtha Phutela\n'
                  'App Developers:\n'
                  '  - Aayush Dubey\n'
                  '  - Jazlyn Jose\n'
                  '  - Mubashir Buhari\n'
                  '  - Unnati Gupta\n',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'We are committed to continuously improving the Hush app, adding more valuable features, and staying up-to-date with the latest research on sleep science. Your feedback and support are crucial to our journey towards better sleep and overall well-being.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Thank you for choosing Hush, and we wish you a peaceful and restful sleep ahead!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
