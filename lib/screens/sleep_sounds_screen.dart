import 'dart:math';

import 'package:flutter/material.dart';
import 'package:record_with_play/bottom_menu.dart';
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
  double volumeValue = 0.5; // Default volume
  Duration? audioDuration;
  String selectedCategory = 'All'; // Default category
  int currentIndex = 0;

  // Define sound files based on categories
  Map<String, List<String>> soundCategories = {
    'All': ['deep-in-the-dell.mp3', 'dreamland.mp3', 'evening.mp3', 'the-magic-tree.mp3'],
    'Nature': ['dreamland.mp3'],
    'City': ['deep-in-the-dell.mp3', 'the-magic-tree.mp3'],
    'White noise': ['evening.mp3'],
  };

  // Define a map to associate each sound file with its image file
  Map<String, String> soundImages = {
    'deep-in-the-dell.mp3': 'deep-in-the-dell.jpg',
    'dreamland.mp3': 'dreamland.jpg',
    'evening.mp3': 'evening.jpg',
    'the-magic-tree.mp3': 'the-magic-tree.jpg',
  };

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.positionStream.listen((position) {
      setState(() {
        if (audioDuration != null &&
            audioDuration!.inMilliseconds > 0) {
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

    // Listen for completion event
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState ==
          ProcessingState.completed &&
          isPlaying) {
        _playNext(); // Play next audio when current one finishes
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add category selection buttons here
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: soundCategories.keys
                  .map((category) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                        return category == selectedCategory
                            ? Color(0xFF7685CF)
                            : Color(0xFF4E5262);
                      }),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 20.0)),
                ),
                child: Text(category),
              ))
                  .toList(),
            ),
          ),
          Expanded(child: _buildSoundTiles()),
        ],
      ),
      backgroundColor: Color(0xFF32343E),
      bottomNavigationBar: BottomMenu(activePage: 'sounds'),
      persistentFooterButtons: [
        AudioPlayerControls(
            onPreviousPressed: () {
              _playPrevious();
            },
            onPlayPausePressed: () {
              _togglePlayPause();
            },
            onNextPressed: () {
              _playNext();
            },
            isPlaying: isPlaying,
            sliderValue: sliderValue,
            onSliderChange: (double value) {
              _seekTo(value);
            },
            onRestartPressed: () {
              _restart();
            },
            onShufflePressed: (){
              _shuffle();
            },
            onVolumePressed: () {
              _increaseVolume();
            }
        ),
      ],
    );
  }


  void _togglePlayPause() async {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      if (audioPlayer.playing) {
        audioPlayer.play();
      } else {
        // If no audio is currently playing, start playing the selected audio or resume the paused audio
        List<String>? categorySounds = soundCategories[selectedCategory];
        if (categorySounds != null && categorySounds.isNotEmpty) {
          String path = 'lib/sleep_sounds_page_items/sleep_sounds/${categorySounds[currentIndex]}';
          if (audioPlayer.duration != null && audioPlayer.position < audioPlayer.duration!) {
            // Resume from where it was paused
            audioPlayer.play();
          } else {
            // Start playing from the beginning
            await audioPlayer.setAsset(path);
            audioPlayer.play();
          }
        }
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }
  void _restart() async {
    if (isPlaying) {
      // If the audio is currently playing, pause it and seek to the beginning
      await audioPlayer.pause();
      await audioPlayer.seek(Duration.zero);
      await audioPlayer.play();
    } else {
      // If the audio is paused, just seek to the beginning
      await audioPlayer.seek(Duration.zero);
    }
  }

  void _shuffle() {
    List<String>? categorySounds = soundCategories[selectedCategory];
    if (categorySounds != null && categorySounds.isNotEmpty) {
      currentIndex = Random().nextInt(categorySounds.length);
      String path =
          'lib/sleep_sounds_page_items/sleep_sounds/${categorySounds[currentIndex]}';
      audioPlayer.setAsset(path).then((_) {
        audioPlayer.play();
        setState(() {
          isPlaying = true;
        });
      });
    }
  }

  void _seekTo(double value) {
    if (audioDuration != null) {
      int milliseconds =
      (value * audioDuration!.inMilliseconds.toDouble()).round();
      audioPlayer.seek(Duration(milliseconds: milliseconds));
    }
  }

  void _playNext() async {
    List<String>? categorySounds = soundCategories[selectedCategory];
    if (categorySounds != null && categorySounds.isNotEmpty) {
      currentIndex = (currentIndex + 1) % categorySounds.length;
      String path =
          'lib/sleep_sounds_page_items/sleep_sounds/${categorySounds[currentIndex]}';
      await audioPlayer.setAsset(path);
      audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _playPrevious() async {
    List<String>? categorySounds = soundCategories[selectedCategory];
    if (categorySounds != null && categorySounds.isNotEmpty) {
      currentIndex = (currentIndex - 1) % categorySounds.length;
      if (currentIndex < 0) {
        currentIndex = categorySounds.length - 1;
      }
      String path =
          'lib/sleep_sounds_page_items/sleep_sounds/${categorySounds[currentIndex]}';
      await audioPlayer.setAsset(path);
      audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  Widget _buildSoundTiles() {
    Set<String> soundFilesSet = Set();
    List<String> soundFiles = [];

    if (selectedCategory == 'All') {
      // For 'All' category, merge all sound files from different categories
      for (var categorySounds in soundCategories.values) {
        for (var soundFile in categorySounds) {
          if (!soundFilesSet.contains(soundFile)) {
            soundFilesSet.add(soundFile);
            soundFiles.add(soundFile);
          }
        }
      }
    } else {
      soundFiles = soundCategories[selectedCategory] ?? [];
    }

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
    // Use the soundImages map to get the corresponding image file
    String imageName = soundImages[soundFile] ?? '';
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
            'lib/sleep_sounds_page_items/sleep_images/$imageName',
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
  void _increaseVolume() {
    if (volumeValue < 1.0) {
      setState(() {
        volumeValue += 0.1; // Increase volume by 0.1
        audioPlayer.setVolume(volumeValue);
      });
    } else {
      setState(() {
        volumeValue = 0.0; // Set volume to 0
        audioPlayer.setVolume(volumeValue);
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}