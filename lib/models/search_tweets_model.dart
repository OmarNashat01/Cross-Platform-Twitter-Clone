import 'dart:developer';

import 'package:twitter/models/search_tweet_model.dart';

class SearchTweets {
  List<SearchTweet> allTweets;
  SearchTweets({required this.allTweets});

  factory SearchTweets.fromJson(Map<String, dynamic> jsonData) {
    return SearchTweets(allTweets: jsonData['all_tweets']);
  }
}
