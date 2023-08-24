import 'package:flutter/material.dart';

class termspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hush - Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Effective Date: [Date]',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to Hush! These Terms and Conditions ("Terms") govern your use of the Hush mobile application ("App") and all related services provided by Hush ("Services"). By accessing or using the App and Services, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use the App or Services.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20,),
              Text(
                'App Description and Features',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Hush is a mobile application designed to promote healthy sleep habits and improve sleep quality. It offers the following main features:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              _buildFeatureItem('a. Sleep Tracking',
                  'The App facilitates sleep tracking by asking users four questions to analyze their sleep patterns and provide insights into their sleep quality.'),
              _buildFeatureItem('b. Quiz Section',
                  'The App includes a quiz section to assess users\' knowledge on sleep-related topics, helping them gain awareness and understanding of sleep science.'),
              _buildFeatureItem('c. Journal Feature',
                  'Users can maintain a sleep journal within the App to record their sleep experiences, habits, and any related information to track progress and identify areas for improvement.'),
              _buildFeatureItem('d. Dashboard',
                  'The App presents users with a dashboard displaying comprehensive statistics and insights based on their sleep tracking data and journal entries.'),
              _buildFeatureItem('e. Articles on Sleep',
                  'Hush offers five informative articles on sleep, providing users with valuable tips, advice, and research-based knowledge to foster better sleep habits.'),
              _buildFeatureItem('f. Tic-Tac-Toe Game',
                  'For entertainment purposes, Hush includes a Tic-Tac-Toe game that users can enjoy during their leisure time.'),
              SizedBox(height: 16),
              Text(
                'Account Registration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'To use certain features of the App, you may be required to create an account. You must provide accurate and complete information during the registration process. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Add other content sections here as per your requirements.
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFeatureItem(String title, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 4),
      Text(description),
      SizedBox(height: 8),
    ],
  );
}

