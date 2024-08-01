import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading('Introduction'),
            _buildParagraph(
              'Welcome to Trip PlannerX! These Terms of Service ("Terms") govern your use of our app. By using our app, you agree to these Terms. If you do not agree to these Terms, please do not use our app.',
            ),
            _buildHeading('Use of the App'),
            _buildList([
              'Eligibility: You must be at least 13 years old to use our app. By using the app, you represent and warrant that you meet this eligibility requirement.',
              'Account: You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
              'Prohibited Activities: You agree not to engage in any of the following prohibited activities:',
              'Violating any laws or regulations.',
              'Infringing the intellectual property rights of others.',
              'Using the app to distribute spam or other unsolicited messages.',
              'Engaging in any activity that could damage, disable, or impair the app.',
            ]),
            _buildHeading('Intellectual Property'),
            _buildParagraph(
              'All content and materials available on our app, including but not limited to text, graphics, logos, and software, are the property of PlannerX and are protected by copyright, trademark, and other intellectual property laws.',
            ),
            _buildHeading('Disclaimer of Warranties'),
            _buildParagraph(
              'Our app is provided "as is" and "as available" without warranties of any kind, either express or implied. We do not warrant that the app will be uninterrupted, error-free, or free of viruses or other harmful components.',
            ),
            _buildHeading('Limitation of Liability'),
            _buildParagraph(
              'To the fullest extent permitted by law, PlannerX shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of our app.',
            ),
            _buildHeading('Changes to These Terms'),
            _buildParagraph(
              'We may update our Terms of Service from time to time. We will notify you of any changes by posting the new Terms of Service on this page. You are advised to review these Terms periodically for any changes.',
            ),
            _buildHeading('Contact Us'),
            _buildParagraph(
              'If you have any questions or concerns about these Terms, please contact us at roshanjojy888@gmail.com.',
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
