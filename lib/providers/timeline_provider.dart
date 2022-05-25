import 'package:flutter/material.dart';

import '../constants.dart';

class TimelineProvider extends ChangeNotifier {
   dynamic timelineList = [];
   updateMyTimeline(dynamic data) {
    if (data != null) {
      for (int i =0; i <data.length; i++) {
        timelineList.add(data[i]);
      }
    }
    notifyListeners();
  }
   addTweetToMyTimeline(dynamic data) {
     print(data);
     if (data != null) {
         timelineList.insert(0,data);
     }
     notifyListeners();
   }
   notify()
   {
     notifyListeners();
   }
   updateLikeInfoOfTweet(int index,int likeCount,bool isLiked) {
     timelineList[index].outerTweet.likeCount=likeCount;
     timelineList[index].outerTweet.isLiked=isLiked;
     notifyListeners();
   }
   updateMyTimelineDuringPagination(dynamic data) {
     if (data != null) {
       for (int i =0; i <data.length; i++) {
         timelineList.add(data[i]);
       }
     }
     notifyListeners();
   }
  void removeTweetFromTimeline(int index) {

    timelineList.removeAt(index);
     notifyListeners();
  }
 List getTimelineList()
 {
   return timelineList;
 }
}
