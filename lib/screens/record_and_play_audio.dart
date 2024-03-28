import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record_with_play/providers/play_audio_provider.dart';
import 'package:record_with_play/providers/record_audio_provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'ask_ai.dart'; // Import the AskAIPage widget
import 'package:record_with_play/bottom_menu.dart';

import 'display_prediction.dart';


class RecordAndPlayScreen extends StatefulWidget {
  const RecordAndPlayScreen({Key? key}) : super(key: key);

  @override
  State<RecordAndPlayScreen> createState() => _RecordAndPlayScreenState();
}

class _RecordAndPlayScreenState extends State<RecordAndPlayScreen> {
  bool _isLoading = true; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    customizeStatusAndNavigationBar();
    // Simulate a loading delay (you can replace this with your actual loading logic)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Set loading flag to false when loading is done
      });
    });
  }

  customizeStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   final _recordProvider = Provider.of<RecordAudioProvider>(context);
  //   final _playProvider = Provider.of<PlayAudioProvider>(context);
  //   return ChangeNotifierProvider.value(
  //     // value: RecordAudioProvider(context),
  //     value: RecordAudioProvider(),
  //     child: Scaffold(
  //         appBar: AppBar(
  //           backgroundColor: Colors.black, // Set background color to black
  //           title: Text('', style: TextStyle(color: Color(0xff4BB543))), // Set title text color to white
  //           leading: Builder(
  //             builder: (BuildContext context) {
  //               return IconButton(
  //                 icon: Icon(Icons.menu, color: Colors.white), // Set leading icon color to white
  //                 onPressed: () {
  //                   Scaffold.of(context).openDrawer();
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         drawer: Drawer(
  //           child: MenuWidget(),
  //         ),
  //         backgroundColor: Colors.white,
  //         body: Stack(
  //           children: [
  //             // if (_recordProvider.predictionResult != null)
  //             //   PredictionPage(predictionLabel: _recordProvider.predictionResult)
  //             // else
  //             //   _buildContent(_recordProvider, _playProvider), // Existing content when no prediction
  //             _buildContent(_recordProvider, _playProvider),
  //             Positioned(
  //               bottom: 0,
  //               left: 0,
  //               right: 0,
  //               child: BottomMenu(activePage: 'crying'), // Bottom menu
  //             ),
  //           ],
  //         ),
  //         floatingActionButton: ChatMessageButton(
  //           onPressed: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(builder: (context) => AskAIPage()),
  //             );
  //           },
  //         ),
  //         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  //       ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final _recordProvider = Provider.of<RecordAudioProvider>(context, listen: true);
    final _playProvider = Provider.of<PlayAudioProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black, // Set background color to black
          title: Text('', style: TextStyle(color: Color(0xff4BB543))), // Set title text color to white
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white), // Set leading icon color to white
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: MenuWidget(),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            if (_recordProvider.predictionResult != null)
              PredictionPage(predictionLabel: _recordProvider.predictionResult)
            else
              _buildContent(_recordProvider, _playProvider), // Existing content when no prediction
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomMenu(activePage: 'crying'), // Bottom menu
            ),
          ],
        ),
        floatingActionButton: ChatMessageButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AskAIPage()),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
  }




  Widget _buildContent(
      RecordAudioProvider recordProvider,
      PlayAudioProvider playProvider,
      ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0xFF32343E), // Set the background color to #32343E
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          recordProvider.recordedFilePath.isEmpty
              ? _recordHeading()
              : _playAudioHeading(),
          const SizedBox(height: 40),
          recordProvider.recordedFilePath.isEmpty
              ? _recordingSection()
              : _audioPlayingSection(),
          if (recordProvider.recordedFilePath.isNotEmpty &&
              !playProvider.isSongPlaying) const SizedBox(height: 40),
          if (recordProvider.recordedFilePath.isNotEmpty &&
              !playProvider.isSongPlaying) _resetButton(),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Color(0xFF32343E), // Background color
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Loading indicator
            SizedBox(height: 20),
            Image.asset('lib/assets/welcome_icon.png', width: 130, height: 130),
          ],
        ),
      ),
    );
  }
  Widget _commonIconSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);

    // Define the color for the flashing circle
    Color flashColor =
    _recordProvider.isRecording ? Color(0x5598FB98) : Colors.transparent;

    // Define the duration for the flash animation
    Duration flashDuration = Duration(milliseconds: 500);

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            if (!_recordProvider.isRecording) {
              await _recordProvider.recordVoice();
            }else{
              await _recordProvider.stopRecording();
            }
          },
          child: Container(
            width: 150, // Set the width and height to make the circle bigger
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF98FB98), // Set the circle color
            ),
            child: Stack(
              alignment: Alignment.center, // Center the content of the Stack
              children: [
                AnimatedContainer(
                  duration: flashDuration,
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: flashColor, // Set the color for the flash
                  ),
                ),
                Icon(
                  Icons.keyboard_voice_rounded,
                  color: Colors.black, // Set the mic icon color to black
                  size: 80, // Keep the mic icon size as it is
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          _recordProvider.isRecording ? 'Listening' : 'Tap to Listen',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _recordHeading() {
    return const Center(
      child: Text(
        'Record Audio',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _playAudioHeading() {
    return const Center(
      child: Text(
        'Play Audio',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _recordingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context, listen: true);
    // final _recordProviderWithoutListener =
    // Provider.of<RecordAudioProvider>(context, listen: false);

    if (_recordProvider.isRecording) {
      return InkWell(
        // onTap: () async => await _recordProviderWithoutListener.stopRecording(),
        onTap: () async => await _recordProvider.stopRecording(),

        child: RippleAnimation(
          repeat: true,
          color: const Color(0xff4BB543),
          minRadius: 40,
          ripplesCount: 6,
          child: _commonIconSection(),
        ),
      );
    }

    return InkWell(
      // onTap: () async => await _recordProviderWithoutListener.recordVoice(),
      onTap: () async => await _recordProvider.recordVoice(),
      child: _commonIconSection(),
    );
  }

  Widget _audioPlayingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 110,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _audioControllingSection(_recordProvider.recordedFilePath),
          _audioProgressSection(),
        ],
      ),
    );
  }

  Widget _audioControllingSection(String songPath) {
    final _playProvider = Provider.of<PlayAudioProvider>(context);
    final _playProviderWithoutListen =
    Provider.of<PlayAudioProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;
        await _playProviderWithoutListen.playAudio(File(songPath));
      },
      icon: Icon(
        _playProvider.isSongPlaying ? Icons.pause : Icons.play_arrow_rounded,
      ),
      color: const Color(0xff4BB543),
      iconSize: 30,
    );
  }

  Widget _audioProgressSection() {
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Expanded(
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: LinearPercentIndicator(
          percent: _playProvider.currLoadingStatus,
          backgroundColor: Colors.black26,
          progressColor: const Color(0xff4BB543),
        ),
      ),
    );
  }

  Widget _resetButton() {
    final _recordProvider =
    Provider.of<RecordAudioProvider>(context, listen: false);

    return InkWell(
      onTap: () => _recordProvider.clearOldData(),
      child: Center(
        child: Container(
          width: 80,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Reset',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}



//// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
//// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
//// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
//// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
//// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
//// UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!UPPER MENU CODE BELOW!!!
class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(152, 251, 152, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(52, 61, 52, 1),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle 'About Us' tap
                  },
                ),
                CustomDivider(),
                ListTile(
                  title: Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(52, 61, 52, 1),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle 'Settings' tap
                  },
                ),
                CustomDivider(),
                ListTile(
                  title: Center(
                    child: Text(
                      'Terms and Privacy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(52, 61, 52, 1),
                      ),
                    ),
                  ),
                  onTap: () {
                    // Handle 'Terms and Privacy' tap
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Divider(
        height: 1,
        color: Color.fromRGBO(52, 61, 52, 1),
        thickness: 2,
      ),
    );
  }
}



/////////////////////////CHAT GPT BUTTON


class ChatMessageButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ChatMessageButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _ChatMessageButtonState createState() => _ChatMessageButtonState();
}

class _ChatMessageButtonState extends State<ChatMessageButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10), // Adjust the top padding as needed
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: 64,
                height: 64,
                child: Image.asset(
                  'lib/assets/chatGPT_logo.svg.webp',
                  // Adjust the path according to your asset location
                  width: 64,
                  height: 64,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




