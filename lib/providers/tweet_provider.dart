import 'package:flutter/cupertino.dart';

class TimelineProvider extends ChangeNotifier {
  dynamic tweet;
  updateLikeInfoOfTweet( int likeCount, bool isLiked) {
    tweet.outerTweet.likeCount = likeCount;
    tweet.outerTweet.isLiked = isLiked;
    notifyListeners();
  }
}