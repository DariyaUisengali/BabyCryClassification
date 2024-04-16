import 'package:flutter/material.dart';

class AudioPlayerControls extends StatelessWidget {
  final Function()? onPreviousPressed;
  final Function()? onPlayPausePressed;
  final Function()? onNextPressed;
  final Function()? onRestartPressed;
  final Function()? onShufflePressed;
  final Function()? onVolumePressed;

  // Add onRestartPressed function
  final bool isPlaying; // Add isPlaying parameter here
  final double sliderValue;
  final ValueChanged<double>? onSliderChange;

  const AudioPlayerControls({
    Key? key,
    required this.isPlaying, // Update constructor to accept isPlaying
    required this.sliderValue,
    this.onSliderChange,
    this.onPreviousPressed,
    this.onPlayPausePressed,
    this.onNextPressed,
    this.onRestartPressed,
    this.onShufflePressed,
    this.onVolumePressed// Include onRestartPressed in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF494E64), // Background color
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white),
                onPressed: onPreviousPressed,
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: onPlayPausePressed,
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.white),
                onPressed: onNextPressed,
              ),
            ],
          ),
          Slider(
            value: sliderValue,
            onChanged: onSliderChange,
            min: 0.0,
            max: 1.0,
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
          ),
          SizedBox(height: 10), // Spacer between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.restart_alt, color: Colors.white),
                onPressed: onRestartPressed,
              ),
              IconButton(
                icon: Icon(Icons.shuffle, color: Colors.white),
                onPressed: onShufflePressed,
              ),
              IconButton(
                icon: Icon(Icons.volume_up, color: Colors.white),
                onPressed: onVolumePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}