import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/services/tweets_service.dart';
import '../models/tweet_complete_model.dart';

class ImageVideoDetailsProvider extends ChangeNotifier
{
  bool upperLowerDetails=true;

  void hideUpperLowerDetails()
  {
    upperLowerDetails=false;
    notifyListeners();
  }
  void showUpperLowerDetails()
  {
    upperLowerDetails=true;
    notifyListeners();
  }

}
