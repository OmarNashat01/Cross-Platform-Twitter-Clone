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
  Future<void> addTweet({required String text,required String dateOfCreation}) async
  {
    await TweetsApi().addTweet(text:text ,dateOfCreation:dateOfCreation );
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