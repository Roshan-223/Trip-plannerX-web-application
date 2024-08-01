import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading('Introduction'),
            _buildParagraph(
              'Welcome to Trip PlannerX! We are committed to protecting your privacy and ensuring that your personal information is handled in a safe and responsible manner. This Privacy Policy explains how we collect, use, and protect your information when you use our app.'
            ),
            _buildHeading('Information We Collect'),
            _buildList([
              'Personal Information: We may collect personal information such as your name, email address, and profile picture when you create an account or update your profile.',
              'Usage Data: We collect information on how you use the app, including features you use, actions you take, and the time, frequency, and duration of your activities.',
              'Device Information: We may collect information about the device you use to access our app, including device type, operating system, and unique device identifiers.'
            ]),
            _buildHeading('How We Use Your Information'),
            _buildList([
              'To Provide and Improve Our Services: We use your information to operate, maintain, and enhance the features and functionality of our app.',
              'To Communicate with You: We may use your information to send you updates, security alerts, and support messages.',
              'To Personalize Your Experience: We may use your information to customize the content and experiences in our app.'
            ]),
            _buildHeading('Sharing Your Information'),
            _buildParagraph(
              'We do not share your personal information with third parties except in the following circumstances:'
            ),
            _buildList([
              'With Your Consent: We may share your information if you give us explicit permission.',
              'For Legal Reasons: We may share your information to comply with legal obligations or in response to a legal request.'
            ]),
            _buildHeading('Security'),
            _buildParagraph(
              'We take reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no method of transmission over the internet or electronic storage is completely secure.'
            ),
            _buildHeading('Changes to This Privacy Policy'),
            _buildParagraph(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes.'
            ),
            _buildHeading('Contact Us'),
            _buildParagraph(
              'If you have any questions or concerns about our Privacy Policy, please contact us at roshanjojy888@gmail.com.'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.arrow_right,
                    size: 16.0,
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
