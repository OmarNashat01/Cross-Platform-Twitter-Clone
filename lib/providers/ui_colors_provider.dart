import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/stream_controller_provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class UIColorProvider extends ChangeNotifier
{
  void changeTweetThreeDotsColor(TweetMain tweet,Color color)
  {
    tweet.threeDotsColor=color;
    notifyListeners();
  }
  Color getTweetThreeDotsColor(TweetMain tweet)
  {
    return tweet.threeDotsColor;
  }

}
