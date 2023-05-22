import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EyeExerciseTab extends StatefulWidget {
  const EyeExerciseTab({super.key});

  @override
  State<EyeExerciseTab> createState() => _EyeExerciseTabState();
}

class _EyeExerciseTabState extends State<EyeExerciseTab> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller =
        VideoPlayerController.asset('lib/assets/videos/eye_exrecise_video.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
