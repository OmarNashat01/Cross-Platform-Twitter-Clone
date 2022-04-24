import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';
class TweetsViewModel extends ChangeNotifier {
  List<TweetMain> _tweetsList = [];

  Future<List<TweetMain>> fetchTweets() async
  {
    _tweetsList = await TweetsApi().fetchTweets();
    notifyListeners();
    return _tweetsList;
  }

  Future<void> addTweet() async
  {
    await TweetsApi().addTweet();
    notifyListeners();
  }
}