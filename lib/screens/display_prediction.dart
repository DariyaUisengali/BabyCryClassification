import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/moms_blog_page.dart'; // Update this import
import 'package:record_with_play/screens/sleep_sounds_screen.dart'; // Import the SleepSoundsScreen
import 'package:record_with_play/bottom_menu.dart'; // Import the BottomMenu widget
import 'package:record_with_play/providers/record_audio_provider.dart';
import 'package:provider/provider.dart';
import 'database_helper.dart';
import 'package:intl/intl.dart';

class PredictionPage extends StatelessWidget {
  String? predictionLabel;

  PredictionPage({Key? key, required this.predictionLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _recordProvider =
        Provider.of<RecordAudioProvider>(context, listen: true);
    DateTime now = DateTime.now();
    String dateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);
    DatabaseHelper().insertSpecialPage(predictionLabel!, dateTime);

    String imagePath = '';
    if (predictionLabel == 'sleepy') {
      imagePath =
          'lib/assets/prediction_images/baby_sleepy-removebg-preview.png';
    } else if (predictionLabel == 'hungry') {
      imagePath =
          'lib/assets/prediction_images/baby-hungry-removebg-preview.png';
    } else if (predictionLabel == 'uncomfortable') {
      imagePath =
          'lib/assets/prediction_images/baby_uncom-removebg-preview.png';
    } else {
      imagePath = 'lib/assets/prediction_images/not_cry.png';
    }

    return Scaffold(
      backgroundColor: Color(0xFF32343E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF98FB98),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(0),
              child: Image.asset(
                imagePath,
                width: 180,
                height: 180,
              ),
            ),
            SizedBox(height: 20),
            Text(
              predictionLabel!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF98FB98),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => RecordAndPlayScreen(),
                //   ),
                //   (route) => false, // Remove all existing routes
                // );
                _recordProvider.clearOldData();
              },
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(activePage: 'crying'),
    );
  }
}
