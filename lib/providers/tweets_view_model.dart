import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';
class TweetsViewModel extends ChangeNotifier {
  TweetsViewModel({required this.streamController});
  List<TweetMain> _tweetsList = [];
StreamController streamController;

  Future<List<TweetMain>> fetchTweets() async
  {
    _tweetsList = await TweetsApi().fetchTweets();
    streamController.add(_tweetsList);
    notifyListeners();
    return _tweetsList;
  }
  Future<void>changeTweetText()async
  {
    _tweetsList[0].tweet.text='we';
    notifyListeners();
  }
  Future<void> addTweet() async
  {
    await TweetsApi().addTweet();
    notifyListeners();
  }
  List<TweetMain> getTweetsList()
  {
    return _tweetsList;
  }
  StreamController getStreamController()
  {
    return streamController;
  }
}