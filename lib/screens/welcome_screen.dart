import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/sign_in_page.dart';
import 'sign_up_page.dart'; // Import the SignUpPage

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/welcome_screen/Welcometo.png',
                width: 170.05,
                height: 31.95,
              ),
              SizedBox(height: 20),
              Image.asset(
                'lib/assets/welcome_screen/BabysWorld.png',
                width: 181,
                height: 42,
              ),
              SizedBox(height: 40),
              Image.asset(
                'lib/icon.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 301,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF98FB98),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xFF32343E),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 301,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()), // Navigate to SignUpPage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF32343E),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 200,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RecordAndPlayScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      color: Color(0xFF32343E),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
