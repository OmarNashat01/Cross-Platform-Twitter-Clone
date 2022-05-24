import 'package:flutter/cupertino.dart';

class TimelineProvider extends ChangeNotifier {
  dynamic tweet;
  updateLikeInfoOfTweet( int likeCount, bool isLiked) {
    tweet.tweet.likeCount = likeCount;
    tweet.tweet.isLiked = isLiked;
    notifyListeners();
  }
}