import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/moms_blog_page.dart'; // Update this import
import 'package:record_with_play/screens/sleep_sounds_screen.dart'; // Import the SleepSoundsScreen
import 'package:record_with_play/bottom_menu.dart'; // Import the BottomMenu widget

import 'package:flutter/material.dart';
import 'database_helper.dart'; // Replace 'your_database_helper_path' with the actual path

class HungryPage extends StatelessWidget {
  const HungryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pageName = 'Hungry';
    String dateTime = DateTime.now().toString();
    DatabaseHelper().insertSpecialPage(pageName, dateTime);

    return Scaffold(
      backgroundColor: Color(0xFF32343E), // Set the background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF98FB98), // Circle background color
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(20), // Adjust padding as needed
              child: Icon(
                Icons.restaurant,
                size: 60, // Adjust icon size as needed
                color: Colors.black, // Icon color
              ),
            ),
            SizedBox(height: 20), // Add spacing between icon and text
            Text(
              'Hungry',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF98FB98),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(activePage: 'none'), // Set activePage to 'none'
    );
  }
}

