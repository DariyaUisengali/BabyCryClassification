import 'package:flutter/material.dart';
class AudioPlayerControls extends StatelessWidget {
  final Function()? onPreviousPressed;
  final Function()? onPlayPausePressed;
  final Function()? onNextPressed;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.white),
                onPressed: onPreviousPressed,
              ),
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: onPlayPausePressed,
              ),
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
        ],
      ),
    );

  }
}