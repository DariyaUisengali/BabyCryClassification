import 'package:flutter/material.dart';
import 'package:record_with_play/screens/bottom_menu.dart';
import 'package:record_with_play/providers/audio_player_controls.dart';
import 'package:just_audio/just_audio.dart';

class SleepSoundsScreen extends StatefulWidget {
  @override
  _SleepSoundsScreenState createState() => _SleepSoundsScreenState();
}

class _SleepSoundsScreenState extends State<SleepSoundsScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  double sliderValue = 0.0;
  Duration? audioDuration;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.positionStream.listen((position) {
      setState(() {
        if (audioDuration != null && audioDuration!.inMilliseconds > 0) {
          sliderValue = position.inMilliseconds.toDouble() /
              audioDuration!.inMilliseconds.toDouble();
        }
      });
    });

    audioPlayer.durationStream.listen((duration) {
      setState(() {
        audioDuration = duration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSoundTiles(),
      backgroundColor: Color(0xFF32343E),
      bottomNavigationBar: BottomMenu(activePage: 'sounds'),
      persistentFooterButtons: [
        AudioPlayerControls(
          onPreviousPressed: () {
            // Handle previous button press
          },
          onPlayPausePressed: () {
            _togglePlayPause();
          },
          onNextPressed: () {
            // Handle next button press
          },
          isPlaying: isPlaying,
          sliderValue: sliderValue,
          onSliderChange: (double value) {
            _seekTo(value);
          },
        ),
      ],
    );
  }

  void _togglePlayPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _seekTo(double value) {
    if (audioDuration != null) {
      int milliseconds =
      (value * audioDuration!.inMilliseconds.toDouble()).round();
      audioPlayer.seek(Duration(milliseconds: milliseconds));
    }
  }

  Widget _buildSoundTiles() {
    List<String> soundFiles = [
      'deep-in-the-dell.mp3',
      'dreamland.mp3',
      'evening.mp3',
    ];
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 40,
          crossAxisSpacing: 40,
          childAspectRatio: 1,
        ),
        itemCount: soundFiles.length,
        itemBuilder: (context, index) {
          return _buildSoundTile(soundFiles[index]);
        },
      ),
    );
  }

  Widget _buildSoundTile(String soundFile) {
    String soundName = soundFile.replaceAll('.mp3', '');
    return GestureDetector(
      onTap: () {
        _playSound(soundFile);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            'lib/sleep_sounds_page_items/sleep_images/$soundName.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _playSound(String soundFile) async {
    String path = 'lib/sleep_sounds_page_items/sleep_sounds/$soundFile';
    await audioPlayer.setAsset(path);
    audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
