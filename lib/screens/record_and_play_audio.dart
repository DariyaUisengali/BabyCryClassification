import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record_with_play/providers/play_audio_provider.dart';
import 'package:record_with_play/providers/record_audio_provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:record_with_play/bottom_menu.dart'; // Import the BottomMenu widget

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
        statusBarBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _playProvider = Provider.of<PlayAudioProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF32343E), // Set the background color here
      body: Stack(
        children: [
          _buildContent(_recordProvider, _playProvider), // Existing content
          if (_isLoading) _buildLoadingIndicator(), // Loading indicator
        ],
      ),
      bottomNavigationBar: BottomMenu(activePage: 'crying'), // Provide the activePage parameter here
    );
  }

  Widget _buildContent(
      RecordAudioProvider recordProvider,
      PlayAudioProvider playProvider,
      ) {
    if (_isLoading) {
      return Container(
        color: Color(0xFF32343E), // Background color
        child: _buildLoadingIndicator(),
      );
    } else {
      return Container(
        color: Color(0xFF32343E), // Background color
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
                !playProvider.isSongPlaying)
              const SizedBox(height: 40),
            if (recordProvider.recordedFilePath.isNotEmpty &&
                !playProvider.isSongPlaying)
              _resetButton(),
          ],
        ),
      );
    }
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(), // Loading indicator
          SizedBox(height: 20),
          Text(
            'WELCOME', // Welcome message
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
          Image.asset('lib/icon.jpeg', width: 50, height: 50),
        ],
      ),
    );
  }

  _commonIconSection() {
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


  _recordHeading() {
    return const Center(
      child: Text(
        '', // Changed text
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  _playAudioHeading() {
    return const Center(
      child: Text(
        'Play Audio',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }

  _recordingSection() {
    final _recordProvider = Provider.of<RecordAudioProvider>(context);
    final _recordProviderWithoutListener =
    Provider.of<RecordAudioProvider>(context, listen: false);

    if (_recordProvider.isRecording) {
      return InkWell(
        onTap: () async =>
        await _recordProviderWithoutListener.stopRecording(),
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
      onTap: () async =>
      await _recordProviderWithoutListener.recordVoice(),
      child: _commonIconSection(),
    );
  }

  _audioPlayingSection() {
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

  _audioControllingSection(String songPath) {
    final _playProvider = Provider.of<PlayAudioProvider>(context);
    final _playProviderWithoutListen =
    Provider.of<PlayAudioProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;
        await _playProviderWithoutListen.playAudio(File(songPath));
      },
      icon: Icon(_playProvider.isSongPlaying
          ? Icons.pause
          : Icons.play_arrow_rounded),
      color: const Color(0xff4BB543),
      iconSize: 30,
    );
  }

  _audioProgressSection() {
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
        ));
  }

  _resetButton() {
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
