import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/stream_controller_provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';
class TweetsViewModel extends ChangeNotifier {
  dynamic addedDataToStream;
///=StreamController streamController;

//this function fetch tweets from api call and then update the stream

  Future<void> fetchMyTweets(BuildContext context) async
  {
    addedDataToStream = await TweetsApi().fetchMyTweets();
    Provider.of<StreamControllerProvider>(context,listen: false).updateStreamController(addedDataToStream);
    notifyListeners();
  }
  Future<void> fetchTweetByTweetId(BuildContext context,String tweetId) async
  {
    addedDataToStream = await TweetsApi().fetchTweetByTweetId(tweetId);
    Provider.of<StreamControllerProvider>(context,listen: false).updateStreamController(addedDataToStream);
    notifyListeners();
  }
  Future<List<dynamic>> fetchTweetByTweetIdWithoutAddingToStream(String tweetId) async
  {
     return  TweetsApi().fetchTweetByTweetId(tweetId);
  }
  Future<void> deleteTweet(String tweetId) async
  {
     await TweetsApi().deleteTweet(tweetId: tweetId);
    //=Provider.of<StreamControllerProvider>(context,listen: false).updateStreamController(addedDataToStream);
    notifyListeners();
  }
  Future<void> addTweet({required String text,required String dateOfCreation}) async
  {
    await TweetsApi().addTweet(text:text ,dateOfCreation:dateOfCreation );
    notifyListeners();
  }
  Future<void> likeTweet({required String tweet_id}) async
  {
    await TweetsApi().addLike(tweetId: tweet_id);
    notifyListeners();
  }
  // List<TweetMain> getTweetsList()
  // {
  //   return _tweetsList;
  // }
  // StreamController getStreamController()
  // {
  //   return streamController;
  // }
}