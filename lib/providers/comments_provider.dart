import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class CommentsProvider extends ChangeNotifier {
  dynamic commentsList = [];
  updateTweetCommentList(dynamic data) {
    if (data != null) {
      for (int i =0; i <data.length; i++) {
        commentsList.insert(0,data[i]);
      }
    }
    notifyListeners();
  }
  updateComment(dynamic data) {
    if (data != null) {
      commentsList.insert(0, data);
    }
    notifyListeners();
  }
  updateLikeInfoOfTweet(int index,int likeCount,bool isLiked) {
    // commentsList[index].tweet.likeCount=likeCount;
    // commentsList[index].tweet.isLiked=isLiked;
    notifyListeners();
  }
  // void removeTweetFromTimeline(int index) {
  //
  //   timelineList.removeAt(index);
  //   notifyListeners();
  // }
  // List getTimelineList()
  // {
  //   return timelineList;
  // }
}
