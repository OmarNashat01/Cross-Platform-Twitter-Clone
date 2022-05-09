import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class TimelineProvider extends ChangeNotifier {
   dynamic timelineList = [];
   updateMyTimeline(dynamic data) {
    if (data != null) {
      for (int i =0; i <data.length; i++) {
        timelineList.insert(0,data[i]);
      }
    }
    notifyListeners();
  }
  void removeTweetFromTimeline(int index) {

    timelineList.removeAt(index);
     notifyListeners();
  }
  // static updateUserStreamController(dynamic data, int index) {
  //   if (data != null) {
  //     for (int i =0; i <data.length; i++) {
  //       userTweetsList.insert(0, data[i]);
  //       print(data[i].tweet.text);
  //     }
  //   }
  //   userTweetsList=[];
  //   //stream = streamController.stream;
  //   // notifyListeners();
  // }

 List getTimelineList()
 {
   return timelineList;
 }
}
