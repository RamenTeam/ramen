import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late MediaQueryData queryData = MediaQuery.of(context);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) => {setState(() {})});
  }

  @override
  Widget build(Object context) {
    return Container(
        child: Stack(
      children: [
        Container(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: queryData.devicePixelRatio / 6,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        FloatingActionButton(onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        })
      ],
    ));
  }
}
