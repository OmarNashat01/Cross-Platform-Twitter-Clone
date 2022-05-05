import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class StreamControllerProvider {
  static List<StreamController> streamController = [];

  static dynamic myTweetsList = [];
  static dynamic userTweetsList = [];
  static updateMyStreamController(dynamic data, int index) {
    if (data != null) {
      for (int i =0; i <data.length; i++) {
        myTweetsList.insert(0, data[i]);
      }
    }
    streamController[index].add(myTweetsList);
    //stream = streamController.stream;
    // notifyListeners();
  }

  static updateUserStreamController(dynamic data, int index) {
    if (data != null) {
      for (int i =0; i <data.length; i++) {
        userTweetsList.insert(0, data[i]);
      }
    }
    streamController[index].add(userTweetsList);
    //stream = streamController.stream;
    // notifyListeners();
  }

  static disposed(int index) {
    streamController[index].onCancel;
    streamController[index].close();
    print("ok");
  }

  static removeTweetFromStreamControllerThenFetchToUpdateUI(
      int index, String tweetId, BuildContext context) async {
    //fetch then add
    dynamic tweet = await Provider.of<TweetsViewModel>(context, listen: false)
        .fetchTweetByTweetIdWithoutAddingToStream(tweetId);
    print(tweet[0].tweet.likeCount);
    // tweetsList.insert(index, tweet[0]);
    // streamController[index].add(tweetsList);
    // notifyListeners();
  }

  static StreamController getStreamController(int index) {
    // notifyListeners();
    return streamController[index];
  }

  static StreamController addStreamController(
      StreamController streamControlleri, int index) {
    streamController.insert(index, streamControlleri);
    return streamController[index];
  }
  // Stream getStream() {
  //   notifyListeners();
  //   return stream;
  // }
}
