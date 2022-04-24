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
  Future<void>addTweet()async
  {
    final Uri url = Uri.parse('http://10.0.2.2:8000/tweets');
    http.Response response = await http.post(url,
        body: {

            "tweet_id": "1232",
            "user_id": "121",
            "name": "abdallah fawzy",
            "username": "abdallah",
            "prof_pic_url": "assets/images/myProfilepic.jpeg",
            "bio": "hello",
            "followers_count": 0,
            "following_count": 0,
            "text": "okaaaaaaay",
            "created_at": "2022-04-23T03:33:05.603Z",
            "videos": [
              {
                "url": "string",
                "alt_text": "string",
                "height": 0,
                "width": 0
              }
            ],
            "images": [
              {
                "url": "assets/tweets_images/morningCoffee.jpg",
                "alt_text": "string",
                "height": 200,
                "width": 200
              }
            ],
            "like_count": 0,
            "liker_ids": [
              "string"
            ],
            "comment_count": 0,
            "retweet_count": 0,
            "comments": [
              {
                "user_id": "",
                "username": "",
                "prof_pic_url": "",
                "text": "",
                "created_at": "",
                "replies": [
                  {
                    "user_id": "",
                    "username": "",
                    "Text": ""
                  }
                ]
              }
            ]
          }
    );
    if(response.statusCode==200)
      {
        print('good');
      }
    else
      {
        print('bad');
      }

  }

}