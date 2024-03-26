//дурыс версия
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_with_play/providers/play_audio_provider.dart';
import 'package:record_with_play/providers/record_audio_provider.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/ask_ai.dart' as AskAI; // Import the AskAIPage widget with an alias
import 'package:record_with_play/screens/bottom_menu.dart'; // Import the BottomMenu widget
import 'package:record_with_play/screens/sleep_sounds_screen.dart'; // Import the SleepSoundsScreen
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() {
  print('Starting the app...');
  runApp(const EntryRoot());
  print('App started successfully.');
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // providers: [
      //   ChangeNotifierProvider.value( // Use .value to reuse existing instance
      //     value: RecordAudioProvider(context), // Provide context here
      //   ),
      //   ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      // ],
      providers: [
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()), // No context here
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // navigatorKey: navigatorKey,
        title: 'Record and Play',
        home: Scaffold(
          backgroundColor: Colors.transparent, // Make Scaffold background transparent
          body: Stack(
            children: [
              Container(
                color: Color(0xFF32343E), // Background color
                width: double.infinity,
                height: double.infinity,
              ),

              // ChangeNotifierProvider.value( // Wrap RecordAndPlayScreen with provider
              //   value: Provider.of<RecordAudioProvider>(context), // Reuse existing instance
              //   child: RecordAndPlayScreen(),
              // ),

              RecordAndPlayScreen(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomMenu(activePage: 'crying'),
              ),
            ],
          ),
        ),
        theme: ThemeData(
          // No changes to the button here
        ),
      ),
    );
  }


}

void _showAskAIDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AskAI.AskAIPage(); // Show the AskAIPage as a dialog using the alias
    },
  );
}