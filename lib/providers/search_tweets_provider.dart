import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:twitter/models/search_tweet_model.dart';
import 'package:twitter/services/search_tweets_service.dart';

import '../models/search_tweets_model.dart';

class SearchTweetsProvider with ChangeNotifier {
  String _query = '';
  set query(query) => _query = query;
  String get query => _query;

  Future<List<SearchTweet>> searchAllTweets() async {
    List<SearchTweet> searchTweetsList =
        await SearchTweetsApi().searchAllTweets(query);
    // log('mshit');

    return searchTweetsList;
  }
}
