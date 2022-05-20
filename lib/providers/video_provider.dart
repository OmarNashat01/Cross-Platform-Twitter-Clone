import 'package:flutter/material.dart';

class VideoPlayerProvider extends ChangeNotifier
{
  double isMuted=1;
  dynamic isPlayed;
  // void muteVideo(dynamic videoPlayerController)
  // {
  //   isMuted=1;
  //   videoPlayerController.setVolume(0);
  //   notifyListeners();
  // }
  void setVolume(dynamic videoPlayerController,double v) {
    if (v == 1){
      isMuted=1;
    }
    else
      {
        isMuted=0;
      }
    videoPlayerController.setVolume(v);
    notifyListeners();
  }
  // void unMuteVideo(dynamic videoPlayerController)
  // {
  //   isMuted=0;
  //   videoPlayerController.setVolume(1);
  //   notifyListeners();
  // }
  void playVideo(dynamic videoPlayerController)
  {
    isPlayed=true;
    videoPlayerController.play();
    notifyListeners();
  }
  void pauseVideo(dynamic videoPlayerController)
  {
    isPlayed=false;
    videoPlayerController.pause();
    notifyListeners();
  }


}
