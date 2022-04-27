import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';
class StreamControllerProvider extends ChangeNotifier {
  StreamController streamController = StreamController();

  dynamic tweetsList=[];
  Stream stream = StreamController().stream;

  updateStreamController(dynamic data) {
    if(data!=null) {
      for (int i = 0; i < data.length; i++) {
        tweetsList.insert(0, data[i]);
      }
    }
    streamController.add(tweetsList);
    stream = streamController.stream;
    notifyListeners();
  }
  removeTweetFromStreamControllerThenFetchToUpdateUI(int index,String tweetId,BuildContext context) async
  {
    //fetch then add
    dynamic tweet=await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetIdWithoutAddingToStream(tweetId);
    print(tweet[0].tweet.likeCount);
    tweetsList.insert(index, tweet[0]);
    streamController.add(tweetsList);
    stream = streamController.stream;
    notifyListeners();
  }
  StreamController getStreamController() {
    notifyListeners();
    return streamController;
  }

  Stream getStream() {
    notifyListeners();
    return stream;
  }
}