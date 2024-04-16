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

  Map<String, List<String>> soundCategories = {
    'All': [
      'boiling-water.mp3',
      'calm-meditation-and-deep-relaxation.mp3',
      'ocean-1.mp3',
      'ocean-2.mp3',
      'pink-noise.mp3',
      'rain-1.mp3',
      'rain-2.mp3',
      'storm.mp3',
      'train.mp3',
      'twinkle-twinkle-little-star.mp3',
      'underwater-1.mp3',
      'underwater-2.mp3',
      'waterfall.mp3',
      'white-noise-01.mp3',
      'deep-in-the-dell.mp3',
      'dreamland.mp3',
      'evening.mp3',
      'the-magic-tree.mp3',
    ],
    'Nature': [
      'dreamland.mp3',
      'ocean-1.mp3',
      'ocean-2.mp3',
      'rain-1.mp3',
      'rain-2.mp3',
      'storm.mp3',
      'waterfall.mp3',
      'boiling-water.mp3',
    ],
    'City': [
      'calm-meditation-and-deep-relaxation.mp3',
      'train.mp3',
      'city-sound-1.mp3',
      'city-sound-2.mp3',
    ],
    'White noise': [
      'pink-noise.mp3',
      'white-noise-01.mp3',
    ],
    'Lullaby': [
      'twinkle-twinkle-little-star.mp3',
      'forest-lullaby.mp3',
      'piano-lullaby.mp3',
      'piano-lullaby-2.mp3'
    ],
  };

  Map<String, String> soundImages = {
    'boiling-water.mp3': 'boiling-water.jpg',
    'calm-meditation-and-deep-relaxation.mp3':
        'calm-meditation-and-deep-relaxation.jpg',
    'ocean-1.mp3': 'ocean-1.jpg',
    'ocean-2.mp3': 'ocean-2.jpg',
    'pink-noise.mp3': 'pink-noise.jpg',
    'rain-1.mp3': 'rain-1.jpg',
    'rain-2.mp3': 'rain-2.jpg',
    'storm.mp3': 'storm.jpg',
    'train.mp3': 'train.jpg',
    'city-sound-1.mp3': 'city-sound-1.jpg', // Corrected image path
    'city-sound-2.mp3': 'city-sound-2.jpg', // Corrected image path
    'twinkle-twinkle-little-star.mp3': 'twinkle-twinkle-little-star.jpg',
    'underwater-1.mp3': 'underwater-1.jpg',
    'underwater-2.mp3': 'underwater-2.jpg',
    'waterfall.mp3': 'waterfall.jpg',
    'white-noise-01.mp3': 'white-noise-1.jpg',
    'deep-in-the-dell.mp3': 'deep-in-the-dell.jpg',
    'dreamland.mp3': 'dreamland.jpg',
    'evening.mp3': 'evening.jpg',
    'the-magic-tree.mp3': 'the-magic-tree.jpg',
    'forest-lullaby.mp3': 'forest-lullaby.jpg',
    'piano-lullaby.mp3': 'piano-lullaby.jpg',
    'piano-lullaby-2.mp3': 'piano-lullaby-2.jpg'
  };

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

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed &&
          isPlaying) {
        _playNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Sleep Sounds',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF494E64),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add category selection buttons here
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 6.0), // Adjust vertical padding here
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: soundCategories.keys
                    .map((category) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                return category == selectedCategory
                                    ? Color(0xFF7685CF)
                                    : Color(0xFF4E5262);
                              }),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(horizontal: 20.0)),
                            ),
                            child: Text(category),
                          ),
                        ))
                    .toList(),
              ),
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
            onShufflePressed: () {
              _shuffle();
            },
            onVolumePressed: () {
              _increaseVolume();
            }),
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
          String path =
              'lib/sleep_sounds_page_items/sleep_sounds/${categorySounds[currentIndex]}';
          if (audioPlayer.duration != null &&
              audioPlayer.position < audioPlayer.duration!) {
            // Resume
            audioPlayer.play();
          } else {
            // Start from the beginning
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
      // If the audio is paused,  seek to the beginning
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
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
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
    String imageName = soundImages[soundFile] ?? '';
    return GestureDetector(
      onTap: () {
        _playSound(soundFile);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/sleep_sounds_page_items/sleep_images/$imageName',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.35),
                padding: EdgeInsets.all(4.0),
                child: Text(
                  soundName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
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
        volumeValue += 0.1;
        audioPlayer.setVolume(volumeValue);
      });
    } else {
      setState(() {
        volumeValue = 0.0;
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
