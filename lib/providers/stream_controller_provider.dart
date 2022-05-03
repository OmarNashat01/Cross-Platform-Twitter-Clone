import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';
class StreamControllerProvider extends ChangeNotifier {
  List<StreamController> streamController=[];

  dynamic myTweetsList=[];
  dynamic userTweetsList=[];
  updateMyStreamController(dynamic data,int index) {
     if(data!=null) {
       for (int i = 0; i < data.length; i++) {
        myTweetsList.add(data[i]);
       }
    }
    streamController[index].add(myTweetsList);
    //stream = streamController.stream;
    notifyListeners();
  }
  updateUserStreamController(dynamic data,int index) {

    streamController[index].add(data);
    //stream = streamController.stream;
    notifyListeners();
  }

  disposed(int index)
  {
    streamController[index].onCancel;
    streamController[index].close();
    print("ok");
  }

  removeTweetFromStreamControllerThenFetchToUpdateUI(int index,String tweetId,BuildContext context) async
  {
    //fetch then add
    dynamic tweet=await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetIdWithoutAddingToStream(tweetId);
    print(tweet[0].tweet.likeCount);
    // tweetsList.insert(index, tweet[0]);
    // streamController[index].add(tweetsList);
    notifyListeners();
  }
  StreamController getStreamController(int index) {
    notifyListeners();
    return streamController[index];
  }
  StreamController addStreamController(StreamController streamControlleri,int index)
  {
    streamController.insert(index, streamControlleri);
    return streamController[index];
  }
  // Stream getStream() {
  //   notifyListeners();
  //   return stream;
  // }
}