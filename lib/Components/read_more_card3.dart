import 'package:flutter/material.dart';



class ArticlePage3 extends StatelessWidget {
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text(
                  "The Impact of Sleep on Mental Health: Exploring the Vital Connection",
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
                      text: "Sleep and mental health share a deep and intricate connection. This article delves into the reciprocal relationship between sleep and mental well-being, exploring how sleep influences mental health and vice versa. Quality sleep plays a vital role in maintaining optimal mental health.\n\nAdequate sleep is essential for emotional regulation, cognitive functioning, and memory consolidation. Insufficient sleep or poor sleep quality can contribute to increased risk of mental health disorders such as depression, anxiety, and bipolar disorder. Conversely, mental health conditions can disrupt sleep patterns.\n\nAnxiety and depression often manifest as difficulty falling asleep, staying asleep, or experiencing nightmares. Sleep disturbances can exacerbate mental health symptoms, leading to a vicious cycle of sleep deprivation and emotional distress. Understanding this bidirectional relationship highlights the importance of prioritizing sleep for mental well-being.\n\nImplementing strategies to improve sleep hygiene, such as establishing a regular sleep schedule, creating a peaceful sleep environment, and practicing relaxation techniques, can positively impact mental health. Furthermore, therapies targeting both sleep and mental health prove effective in addressing these interconnected issues.\n\nCognitive-behavioral therapy for insomnia (CBT-I) is a widely recognized treatment approach that simultaneously targets sleep difficulties and underlying mental health concerns.\n\nMedications and alternative therapies can also aid in restoring healthy sleep and improving mental well-being. In conclusion, recognizing the profound connection between sleep and mental health is crucial for maintaining overall well-being.\n\nPrioritizing quality sleep and seeking appropriate interventions for sleep disturbances can have a significant positive impact on mental health outcomes, fostering emotional resilience and promoting overall mental well-being.",
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