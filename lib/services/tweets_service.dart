import 'dart:async';
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
          List<dynamic>dataGood=[];
          List<dynamic>dataBad=[];
       List<dynamic> tweetsList=[];
      print(jsonData.length);

      for(int i=0;i<jsonData.length;i++)
        {
          if(jsonData[i].length==17) {
            dataGood.add(jsonData[i]);
          }
          else
          {
            dataBad.add(jsonData[i]);
            print(dataBad[0]);
          }
        }
      List<dynamic>tweetsGood=[];
      List<dynamic>tweetsBad=[];
      tweetsGood= dataGood.map((e) => Tweet.fromJson(e,false)).toList();
      tweetsBad= dataBad.map((e) => Tweet.fromJson(e,true)).toList();
      for(int i=0;i<tweetsBad.length;i++)
        {
          tweetsGood.insert(0, tweetsBad[i]);
          print(tweetsBad[i].name);
        }
      tweetsList=tweetsGood;
      //----------------------------------------------------------------------
          List<TweetMain>tweetsMain=[];
          List<dynamic>comments;
          List<dynamic>likers;
          List<dynamic>images;
          List<dynamic>videos;
          //--------------------------------------------------------------------------
            for (int i = 0; i < tweetsList.length; i++) {
              if (tweetsList.length==17)
              {
                print('ana aho');
                List<List<dynamic>>replies = [];
                comments =
                    tweetsList[i].comments.map((e) => Comment.fromJson(e))
                        .toList();
                for (int i = 0; i < comments.length; i++) {
                  List<dynamic>reply = comments[i].repliesList.map((e) =>
                      Reply.fromJson(e)).toList();
                  replies.add(reply);
                }
                likers = tweetsList[i].likerIds.toList();
                images = tweetsList[i].images.map((e) => Imagei.fromJson(e))
                    .toList();
                videos =
                    tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
                TweetMain tweetIMain = TweetMain(tweet: tweetsList[i],
                    comments: comments,
                    replies: replies,
                    likers: likers,
                    videos: videos,
                    images: images);
                tweetsMain.add(tweetIMain);

              print('lol');
            }
          else
            {
              print('lolen');

                images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
                videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
                TweetMain tweetIMain = TweetMain(tweet: tweetsList[i], videos: videos, images: images);
                tweetsMain.add(tweetIMain);
              print('lolen');

            }
            }
      return tweetsMain;
  }
  Future<void>changeTweetText()async
  {
    final Uri url = Uri.parse('http://10.0.2.2:8000/tweets');
    http.Response response = await http.post(url,
        body: {
          "id":"10101",
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
  }
  Future<void>addTweet()async
  {
    List<Imagei>images=[];
    List<Video>videos=[];
    images.add(Imagei(url: "assets/tweets_images/moon.jpg", altText: "altText", height: 0, width: 0));
    videos.add(Video(url: "", altText: "altText", height: 0, width: 0));
    Tweet tweet=Tweet(tweetId: "3", userId: "126", profilePicUrl: "assets/images/mahmoud.jpg", username: "mohamed", text: "holaaaaa", commentCount: 1, retweetCount: 2, likeCount: 3, createdAt: "2022-04-23T03:33:05.603Z",  name: "mohamed", followersCount: 10, followingCount: 20, bio: 'okay', likerIds: [], videos:videos, images:images, comments: []);

    //TweetMain tweetAdded=TweetMain(tweet: tweet, images: images, videos: videos);
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://10.0.2.2:8000/tweets'));
    request.body = json.encode({
      "id": "51",
      "tweet_id": "tweet_id",
      "user_id": "tweet_id",
      "name": "tweet_id",
      "username": "tweet_id",
      "prof_pic_url": "tweet_id",
      "bio": "tweet_id",
      "followers_count": 0,
      "following_count": 0,
      "text": "tweet_id",
      "created_at": "tweet_id",
      "like_count": 0,
      "comment_count": 0,
      "retweet_count": 0,
      "images": [
        {
          "url": "assets/tweets_images/moon.jpg",
          "alt_text": "string",
          "height": 200,
          "width": 200
        }
      ],
      "videos": [
        {
          "url": "string",
          "alt_text": "string",
          "height": 0,
          "width": 0
        }
      ]
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.toString());
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }


}
