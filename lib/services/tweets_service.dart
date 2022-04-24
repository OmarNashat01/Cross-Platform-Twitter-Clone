import 'dart:convert';
import 'dart:ui';

import 'package:twitter/models/likers_model.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/models/comment_model.dart';
import 'package:http/http.dart'as http;

import '../models/image_model.dart';
import '../models/images_model.dart';
import '../models/replies_model.dart';
import '../models/reply_model.dart';
import '../models/tweets_model.dart';
import '../models/video_model.dart';
class TweetsApi
{

  Future<List<TweetMain>>fetchTweets()async
  {

      final Uri url = Uri.parse('http://10.0.2.2:8000/tweets');
      http.Response response = await http.get(
          url);

          String data=response.body;
           var jsonData=jsonDecode(data);
          // Tweets tweets=Tweets.fromJson(jsonData);
          // print(tweets.tweets[0]);
          List<dynamic> tweetsList= jsonData.map((e) => Tweet.fromJson(e)).toList();
          List<TweetMain>tweetsMain=[];
          List<dynamic>comments;
          List<dynamic>likers;
          List<dynamic>images;
          List<dynamic>videos;
          for(int i=0;i<tweetsList.length;i++) {
            List<List<dynamic>>replies=[];
            comments = tweetsList[i].comments.map((e) => Comment.fromJson(e)).toList();
            for(int i=0;i<comments.length;i++)
              {
                List<dynamic>reply = comments[i].repliesList.map((e) => Reply.fromJson(e)).toList();
                replies.add(reply);
              }
            likers=tweetsList[i].likerIds.toList();
            images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
            videos=tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
            TweetMain tweetIMain=TweetMain(tweet:tweetsList[i] ,comments:comments ,replies: replies,likers:likers ,videos:videos ,images:images );
            tweetsMain.add(tweetIMain);
          }
          return tweetsMain;

  }
}