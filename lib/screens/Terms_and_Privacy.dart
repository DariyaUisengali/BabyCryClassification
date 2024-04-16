import 'package:flutter/material.dart';

class TermsAndPrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String termsText = generateTermsText();
    String privacyText = generatePrivacyText();

    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Privacy'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Terms and Conditions:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            termsText,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Text(
            'Privacy Policy:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            privacyText,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  String generateTermsText() {
    return '''
1. Introduction

These Terms and Conditions govern your use of this website; by using this website, you accept these Terms and Conditions in full. If you disagree with these Terms and Conditions or any part of these Terms and Conditions, you must not use this website.

2. Intellectual Property Rights

Unless otherwise stated, we or our licensors own the intellectual property rights in the website and material on the website. Subject to the license below, all these intellectual property rights are reserved.

3. License to Use Website

You may view, download for caching purposes only, and print pages from the website for your own personal use, subject to the restrictions set out below and elsewhere in these Terms and Conditions.

4. Limitations of Liability

We will not be liable to you (whether under the law of contract, the law of torts or otherwise) in relation to the contents of, or use of, or otherwise in connection with, this website: 
- to the extent that the website is provided free-of-charge, for any direct loss; 
- for any indirect, special or consequential loss; or 
- for any business losses, loss of revenue, income, profits or anticipated savings, loss of contracts or business relationships, loss of reputation or goodwill, or loss or corruption of information or data.

5. Variation

We may revise these Terms and Conditions from time-to-time. Revised Terms and Conditions will apply to the use of this website from the date of the publication of the revised Terms and Conditions on this website. Please check this page regularly to ensure you are familiar with the current version.

''';
  }

  String generatePrivacyText() {
    return '''
1. Introduction

We are committed to safeguarding the privacy of our website visitors; in this policy, we explain how we will treat your personal information.

2. What Information Do We Collect?

We may collect, store, and use the following kinds of personal information: 
- information about your computer and about your visits to and use of this website (including your IP address, geographical location, browser type and version, operating system, referral source, length of visit, page views, and website navigation paths);
- information that you provide to us when registering with our website (including your email address);
- information that you provide to us for the purpose of subscribing to our email notifications and/or newsletters (including your name and email address);
- information that you provide to us when using the services on our website, or that is generated in the course of the use of those services (including the timing, frequency, and pattern of service use);
- information relating to any purchases you make of our goods and/or services or any other transactions that you enter into through our website (including your name, address, telephone number, email address, and card details);
- information contained in or relating to any communication that you send to us or send through our website (including the communication content and metadata associated with the communication);

3. Using Your Personal Information

Personal information submitted to us through our website will be used for the purposes specified in this policy or on the relevant pages of the website.

4. Disclosures

We may disclose your personal information to any of our employees, officers, insurers, professional advisers, agents, suppliers, or subcontractors as reasonably necessary for the purposes set out in this policy.

5. Security of Your Personal Information

We will take reasonable technical and organizational precautions to prevent the loss, misuse, or alteration of your personal information.

''';
  }
}
