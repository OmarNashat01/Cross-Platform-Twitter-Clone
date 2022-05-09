import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerWidget extends StatelessWidget {
   VideoPlayerController videoPlayerController;
   double isMuted;
  VideoPlayerWidget({required this.videoPlayerController,required this.isMuted});
  @override
  Widget build(BuildContext context) =>
    (videoPlayerController.value.isInitialized)?
    Container(alignment: Alignment.topCenter,child: buildVideo(),)
    : Container(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  Widget buildVideo()=>
      VisibilityDetector(
        onVisibilityChanged: (visibility){
          if (visibility.visibleFraction ==0) {
            videoPlayerController.pause();//pausing  functionality
          }
          else
            {
              videoPlayerController.play();
            }
        },
        key: ObjectKey(videoPlayerController),
        child: Stack(
            children: [
              buildVideoPlayer(),
              Positioned(
                bottom: 10,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: 15,
                  child: IconButton(
                    icon:
                    Icon(

                      isMuted==0?FontAwesomeIcons.volumeXmark:FontAwesomeIcons.volumeHigh,
                      size: 15,
                      color: Colors.white,
                    ),
                    onPressed:()=>videoPlayerController.setVolume(isMuted==0?1:0),
                  ),
                ),
              ),
   ],
        ),
      );
  Widget buildVideoPlayer()=>AspectRatio(aspectRatio:videoPlayerController.value.aspectRatio,child: VideoPlayer(videoPlayerController));

}
