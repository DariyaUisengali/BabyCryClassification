import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/ask_ai.dart';

class BottomMenu extends StatelessWidget {
  final String activePage;

  const BottomMenu({Key? key, required this.activePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(String page) {
      return activePage == page ? Color(0xFF98FB98) : Colors.white;
    }

    return BottomAppBar(
      color: Colors.transparent, // Make the bottom app bar transparent
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordAndPlayScreen()),
              );
            },
            icon: Icon(
              Icons.nightlight_round,
              color: getColor('crying'),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle button tap
            },
            icon: Icon(
              Icons.music_note,
              color: getColor('sounds'),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AskAIPage()),
              );
            },
            icon: Icon(
              Icons.question_answer,
              color: getColor('ask_ai'),
            ),
          ),
        ],
      ),
    );
  }
}
