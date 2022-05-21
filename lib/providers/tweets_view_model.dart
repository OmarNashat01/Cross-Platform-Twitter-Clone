import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/comment_model.dart';
import 'package:twitter/providers/comments_provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class TweetsViewModel extends ChangeNotifier {
  dynamic addedDataToStream;
  int pageNumber=1;
  ///=StreamController streamController;

//this function fetch tweets from api call and then update the stream

  Future<void> fetchMyTweets(
      BuildContext context) async {
    addedDataToStream = await TweetsApi().fetchMyTweets();
    Provider.of<TimelineProvider>(context,listen: false).updateMyTimeline(
        addedDataToStream);
    notifyListeners();
  }

  // Future<void> fetchUserTweets(
  //     BuildContext context, int streamControllerIndex, String userId) async {
  //   addedDataToStream = await TweetsApi().fetchUserTweets(userId);
  //   TimelineProvider.updateUserStreamController(
  //       addedDataToStream, streamControllerIndex);
  //   notifyListeners();
  // }
  void updateRandomTweetsPageNumber()
  {
    pageNumber=pageNumber+1;
    notifyListeners();
  }
  Future<void> fetchRandomTweetsOfRandomUsers(BuildContext context, int page) async {
    addedDataToStream = await TweetsApi().fetchRandomTweetsOfRandomUsers(page);
    Provider.of<TimelineProvider>(context,listen: false).updateMyTimelineDuringPagination(addedDataToStream);
    updateRandomTweetsPageNumber();
    notifyListeners();
  }

  Future<void> fetchTweetByTweetIdForTweetComments(BuildContext context, String tweetId) async
  {
    addedDataToStream= await TweetsApi().fetchTweetByTweetId(tweetId);

    Provider.of<CommentsProvider>(context,listen: false).updateTweetCommentList(addedDataToStream);
    notifyListeners();
  }

  Future<void> addTweet(
      {required String text,
      required List<dynamic> images,
      required List<dynamic> videos}) async {
    await TweetsApi().addTweet(text: text, images: images, videos: videos);
    notifyListeners();
  }
  Future<void>getAddedTweet(BuildContext context)async
  {
   addedDataToStream= await TweetsApi().getAddedTweet();
   List<TweetMain>addedTweet=[];
   addedTweet.add(addedDataToStream);
   Provider.of<TimelineProvider>(context,listen: false).updateMyTimeline(addedTweet);
    // notifyListeners();
  }
  Future<void>  deleteTweet(BuildContext context,
      String tweetId,tweetIndex) async {

     TweetsApi().deleteTweet(tweetId: tweetId);
     Provider.of<TimelineProvider>(context,listen: false).removeTweetFromTimeline(tweetIndex);
     notifyListeners();
  }
}
