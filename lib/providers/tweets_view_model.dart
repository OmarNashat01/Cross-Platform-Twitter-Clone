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

  Future<void> fetchMyTweets(
      BuildContext context, int streamControllerIndex) async {
    addedDataToStream = await TweetsApi().fetchMyTweets();
    StreamControllerProvider.updateMyStreamController(
        addedDataToStream, streamControllerIndex);
    notifyListeners();
  }

  Future<void> fetchUserTweets(
      BuildContext context, int streamControllerIndex, String userId) async {
    addedDataToStream = await TweetsApi().fetchUserTweets(userId);
    StreamControllerProvider.updateUserStreamController(
        addedDataToStream, streamControllerIndex);
    notifyListeners();
  }

  Future<void> fetchRandomTweetsOfRandomUsers(
      BuildContext context, int page, int streamControllerIndex) async {
    addedDataToStream = await TweetsApi().fetchRandomTweetsOfRandomUsers(page);
    StreamControllerProvider.updateMyStreamController(
        addedDataToStream, streamControllerIndex);
    notifyListeners();
  }

  // Future<void> fetchTweetByTweetId(BuildContext context,String tweetId,int streamControllerIndex) async
  // {
  //   addedDataToStream = await TweetsApi().fetchTweetByTweetId(tweetId);
  //   Provider.of<StreamControllerProvider>(context,listen: false).updateStreamController(addedDataToStream,streamControllerIndex);
  //   notifyListeners();
  // }
  Future<List<dynamic>> fetchTweetByTweetIdWithoutAddingToStream(
      String tweetId) async {
    return TweetsApi().fetchTweetByTweetId(tweetId);
  }

  // Future<void> deleteTweet(String tweetId) async
  // {
  //    await TweetsApi().deleteTweet(tweetId: tweetId);
  //   //=Provider.of<StreamControllerProvider>(context,listen: false).updateStreamController(addedDataToStream);
  //   notifyListeners();
  // }
  Future<void> addTweet(
      {required String text,
      required List<dynamic> images,
      required List<dynamic> videos}) async {
    await TweetsApi().addTweet(text: text, images: images, videos: videos);
    notifyListeners();
  }
  // Future<void> likeTweet({required String tweetId}) async
  // {
  //   await TweetsApi().addLike(tweetId: tweetId);
  //   notifyListeners();
  // }
  // List<TweetMain> getTweetsList()
  // {
  //   return _tweetsList;
  // }
  // StreamController getStreamController()
  // {
  //   return streamController;
  // }
}
