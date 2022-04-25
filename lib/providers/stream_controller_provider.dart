import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';
class StreamControllerProvider extends ChangeNotifier {
  StreamController streamController=StreamController();
  Stream stream=StreamController().stream;
  updateTweetStream(BuildContext context) async
  {
    Provider.of<TweetsViewModel>(context,listen: false).fetchTweets();
    streamController=Provider.of<TweetsViewModel>(context,listen: false).getStreamController();
    stream=streamController.stream;
    notifyListeners();
  }
  StreamController getStreamController()
  {
    notifyListeners();
    return streamController;
  }
  Stream getStream()
  {
    notifyListeners();
    return stream;
  }
}