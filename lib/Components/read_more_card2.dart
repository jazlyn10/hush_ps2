import 'package:flutter/material.dart';



class ArticlePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text(
                  "The Science of Sleep: Unveiling the Secrets to a Restful Night",
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
                      text: "Sleep is an essential aspect of our daily lives, yet many people struggle to achieve a restful night's sleep. Understanding the science behind sleep can provide valuable insights into improving sleep quality and overall well-being. Sleep is a complex biological process that involves several stages and intricate mechanisms within the brain and body.\n\nDuring sleep, the body repairs and restores itself, consolidates memories, and regulates various bodily functions. Disruptions in the sleep cycle can lead to a range of health issues, including increased stress, impaired cognitive function, and weakened immune system. To promote a good night's sleep, it is important to establish a consistent sleep schedule, create a sleep-friendly environment, and practice healthy sleep habits.\n\nThis includes avoiding caffeine and electronic devices before bedtime, engaging in relaxation techniques, and maintaining a comfortable sleep environment. Furthermore, understanding the role of circadian rhythms can greatly contribute to improving sleep. These internal biological clocks regulate our sleep-wake cycles and respond to external cues such as light and darkness. By aligning our daily routines with our natural circadian rhythms, we can optimize our sleep patterns and feel more refreshed upon waking.\n\nAdditionally, this article explores the impact of lifestyle factors on sleep quality. Exercise, diet, and stress management all play crucial roles in promoting healthy sleep. Regular physical activity can help regulate sleep patterns, while a balanced diet supports the production of sleep-regulating hormones. Effective stress management techniques, such as mindfulness meditation, can also promote relaxation and better sleep.",
                    ),
                  ),
                ),

                SizedBox(height: 16.0),
              ],

            ),
          ),
        ),
      ),
    );
  }
}