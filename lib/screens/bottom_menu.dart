import 'package:flutter/material.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/sleep_sounds_screen.dart';
import 'package:record_with_play/screens/moms_blog_page.dart';
import 'my_account.dart';

class BottomMenu extends StatelessWidget {
  final String activePage;

  const BottomMenu({Key? key, required this.activePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(String page) {
      return activePage == page ? Color(0xFF98FB98) : Colors.white;
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1.0,
            color: Colors.white, // White line color
          ),
          Container(
            color: Color(0xFF32343E),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 20, // Reduce icon size
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
                      Text(
                        'Cry Analyzer',
                        style: TextStyle(
                          color: getColor('crying'),
                          fontWeight: FontWeight.bold,
                          fontSize: 10, // Reduce text size
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 20, // Reduce icon size
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SleepSoundsScreen()),
                          );
                        },
                        icon: Icon(
                          Icons.music_note,
                          color: getColor('sounds'),
                        ),
                      ),
                      Text(
                        'Sleep Sounds',
                        style: TextStyle(
                          color: getColor('sounds'),
                          fontWeight: FontWeight.bold,
                          fontSize: 10, // Reduce text size
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 20, // Reduce icon size
                        onPressed: () {
                          if (activePage != 'moms_blog') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MomsBlogPage()),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.article_outlined,
                          color: getColor('moms_blog'),
                        ),
                      ),
                      Text(
                        "Baby's Blog",
                        style: TextStyle(
                          color: getColor('moms_blog'),
                          fontWeight: FontWeight.bold,
                          fontSize: 10, // Reduce text size
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 20, // Reduce icon size
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SplitScreen()),
                          );
                        },
                        icon: Icon(
                          Icons.account_circle,
                          color: getColor('account'),
                        ),
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                          color: getColor('account'),
                          fontWeight: FontWeight.bold,
                          fontSize: 10, // Reduce text size
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:record_with_play/screens/moms_blog_page.dart';
// import 'package:record_with_play/screens/record_and_play_audio.dart';
// import 'package:record_with_play/screens/sleep_sounds_screen.dart';
// import 'package:record_with_play/screens/account_page.dart'; // Import the AccountPage screen
//
// class BottomMenu extends StatelessWidget {
//   final String activePage;
//
//   const BottomMenu({Key? key, required this.activePage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Color getColor(String page) {
//       return activePage == page ? Color(0xFF98FB98) : Colors.white;
//     }
//
//     return BottomAppBar(
//       color: Colors.transparent,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => RecordAndPlayScreen()),
//                   );
//                 },
//                 icon: Icon(
//                   Icons.nightlight_round,
//                   color: getColor('crying'),
//                 ),
//               ),
//               Text(
//                 'Cry Analyzer',
//                 style: TextStyle(
//                   color: getColor('crying'),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 5, // Adjust text size
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

