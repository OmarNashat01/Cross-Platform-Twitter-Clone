import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController videoPlayerController;
  VideoPlayerWidget({required this.videoPlayerController});
  @override
  Widget build(BuildContext context) =>
    (videoPlayerController!=null &&videoPlayerController.value.isInitialized)?
    Container(alignment: Alignment.topCenter,child: buildVideo(),)
    : Container(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  Widget buildVideo()=>buildVideoPlayer();
  Widget buildVideoPlayer()=>AspectRatio(aspectRatio:videoPlayerController.value.aspectRatio,child: VideoPlayer(videoPlayerController));

}
