import 'dart:convert';
import 'dart:developer';

import 'package:twitter/models/search_tweet_model.dart';
import 'package:twitter/models/search_tweets_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class SearchTweetsApi {
  Future<List<SearchTweet>> searchAllTweets(String query) async {
    final queryParameters = {'q': query};

    final uri =
        Uri.http(Http().getBaseUrl(), '/tweets/search/all', queryParameters);
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json; charset=UTF-8",
      "x-access-token": Auth.token,
    });

    // if (response.statusCode == 204) {
    //   log('BAD: No available tweets found (SEARCH ALL TWEETS)');
    // } else if (response.statusCode == 200) {
    String data = response.body;

    // log('${response.body}');

    List<dynamic> allTweets = jsonDecode(data)['all_tweets']; // list of jsons 
    List<SearchTweet> decodedTweets = allTweets
        .map((e) => SearchTweet.fromJson(e))
        .toList(); // list of objects



    return decodedTweets;
    // } else {
    //   log('BAD: Unauthorized');
    // }
  }
}
