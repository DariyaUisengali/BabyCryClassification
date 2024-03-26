import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      body: Center(
        child: SingleChildScrollView( // Makes the content scrollable
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the column vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers the column's children horizontally
            children: [
              Image.asset(
                'lib/assets/welcome_screen/Welcometo.png',
                width: 170.05, // Adjust width as per your design
                height: 31.95, // Adjust height as per your design
              ),
              SizedBox(height: 20),
              Image.asset(
                'lib/assets/welcome_screen/BabysWorld.png',
                width: 181, // Adjust width as per your design
                height: 42, // Adjust height as per your design
              ),
              SizedBox(height: 40), // Spacing before the icon
              Image.asset(
                'lib/icon.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20), // Spacing before the buttons
              SizedBox(
                width: 301,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RecordAndPlayScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF98FB98), // Use primary for button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Sign in',
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
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF32343E),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30), // Spacing after the buttons
              SizedBox(
                width: 103.38,
                height: 19.27,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RecordAndPlayScreen()),
                    );
                  },
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      color: Colors.white,
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