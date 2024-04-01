
import 'package:flutter/material.dart';
import 'package:record_with_play/screens/my_account.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/sleep_sounds_screen.dart';
import 'package:record_with_play/screens/moms_blog_page.dart'; // Update this import

class BottomMenu extends StatelessWidget {
  final String activePage;

  const BottomMenu({Key? key, required this.activePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(String page) {
      return activePage == page ? Color(0xFF98FB98) : Colors.white;
    }

    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              if (activePage != 'crying') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordAndPlayScreen()),
                );
              }
            },
            icon: Icon(
              Icons.nightlight_round,
              color: getColor('crying'),
            ),
          ),
          IconButton(
            onPressed: () {
              if (activePage != 'sounds') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepSoundsScreen()),
                );
              }
            },
            icon: Icon(
              Icons.music_note,
              color: getColor('sounds'),
            ),
          ),
          IconButton(
            onPressed: () {
              if (activePage != 'moms_blog') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MomsBlogPage()),
                );
              }
            },
            icon: Icon(
              Icons.article_outlined, // Change icon to represent Mom's Blog
              color: getColor('moms_blog'), // Update the active color
            ),
          ),
          IconButton(
            onPressed: () {
              if (activePage != 'account') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplitScreen()),
                );
              }
            },
            icon: Icon(
              Icons.nightlight_round,
              color: getColor('account'),
            ),
          ),
        ],
      ),
    );
  }
}