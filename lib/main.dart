//дурыс версия
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_with_play/providers/play_audio_provider.dart';
import 'package:record_with_play/providers/record_audio_provider.dart';
import 'package:record_with_play/screens/record_and_play_audio.dart';
import 'package:record_with_play/screens/ask_ai.dart'
    as AskAI; // Import the AskAIPage widget with an alias
import 'package:record_with_play/bottom_menu.dart'; // Import the BottomMenu widget
import 'package:record_with_play/screens/sleep_sounds_screen.dart'; // Import the SleepSoundsScreen
import 'screens/welcome_screen.dart';
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  print('Starting the app...');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB_Jkc-mNNzJpNrCDfIWdkAVfwMJtSgZ28",
          appId: "1:672539338524:web:970f5bc114e053fd1bfcd9",
          messagingSenderId: "672539338524",
          projectId: "baby-s-world-fc6e9"));


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
        ChangeNotifierProvider(create: (_) => RecordAudioProvider()),
        // No context here
        ChangeNotifierProvider(create: (_) => PlayAudioProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // navigatorKey: navigatorKey,
        title: 'Record and Play',
        home: WelcomeScreen(),
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
      return AskAI
          .AskAIPage(); // Show the AskAIPage as a dialog using the alias
    },
  );
}
