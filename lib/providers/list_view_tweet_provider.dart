import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/stream_controller_provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class ListViewTweetProvider extends ChangeNotifier
{
  int index=0;
  void changeTweetIndex()
  {
    index=1;
    notifyListeners();
  }


}
