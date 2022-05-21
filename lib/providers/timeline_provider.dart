import 'package:flutter/material.dart';

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
