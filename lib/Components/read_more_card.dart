import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF233C67), // Custom color for the app bar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // This line will navigate back to the previous page.
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "A Good Night's Sleep: A Well-Deserved Reset Button for the Mind and Body",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                    text: "In our fast-paced, demanding lives, it is easy to overlook the importance of a good night's sleep. Often, we sacrifice sleep to meet deadlines, engage in late-night activities, or succumb to the distractions of the digital world. However, it is crucial to recognize that sleep is not just a period of inactivity. Rather, it is a vital process that serves as a reset button for both our mind and body. Sleep is a naturally recurring state characterized by reduced consciousness, lowered sensory activity, and limited voluntary muscle movement. It is during this seemingly passive phase that our body and mind undergo a series of essential processes that contribute to our overall well-being.\n\nFirst and foremost, sleep plays a fundamental role in restoring and rejuvenating our physical health. Throughout the day, our bodies are constantly engaged in various activities, both externally and internally. Muscles are utilized, cells undergo repair and regeneration, and energy is expended. Sleep provides an opportunity for our body to repair and rebuild tissues, allowing for optimal growth and development.",
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
