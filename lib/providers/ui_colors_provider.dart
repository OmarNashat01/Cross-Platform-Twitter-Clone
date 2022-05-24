
import 'package:flutter/material.dart';
import '../models/tweet_complete_model.dart';

class UIColorProvider extends ChangeNotifier
{
  dynamic imageDetailColor;
  dynamic opacity;
  void changeTweetThreeDotsColor(TweetMain tweet,Color color)
  {
    tweet.threeDotsColor=color;
    notifyListeners();
  }
  Color getTweetThreeDotsColor(TweetMain tweet)
  {
    return tweet.threeDotsColor;
  }
  void increaseTransparency()
  {
    opacity=opacity-0.0005;
     imageDetailColor=imageDetailColor.withOpacity(opacity);
     notifyListeners();
  }
  void decreaseTransparency()
  {

    opacity=opacity+0.0005;
    imageDetailColor=imageDetailColor.withOpacity(opacity);
    notifyListeners();
  }
}
