import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:uuid/uuid.dart';
import 'package:twitter/models/likers_model.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/models/comment_model.dart';
import 'package:http/http.dart'as http;

import '../constants.dart';
import '../models/image_model.dart';
import '../models/images_model.dart';
import '../models/replies_model.dart';
import '../models/reply_model.dart';
import '../models/tweets_model.dart';
import '../models/video_model.dart';
class TweetsApi {

  Future<List<TweetMain>?> fetchMyTweets() async
  {
    final Uri uri = Uri.parse('$backendUrl/tweets/all/me');
    http.Response response = await http.get(uri, headers: {
      "x-access-token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MjY1NTFmNDRkNTc4NmY0MzdjYmIyNWIiLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTY4MjM0MzQ5MX0.8xbJXtfITqlxM1YwdaRV1kr1qXRtvQJ3glhjxNdOPD4"
    });
    String data = response.body;
    var de = jsonDecode(data);
      var jsonData = jsonDecode(data)["tweets"];
      print(jsonData);
    if (jsonData.length>0) {
      List<dynamic>tweetsWithComments = [];
      List<dynamic>tweetsWithoutComments = [];
      List<dynamic> tweetsList = [];
      List<int>tWCIndices = [];
      List<int>tNCIndices = [];
      for (int i = 0; i < jsonData.length; i++) {
        if (jsonData[i].length == 17) {
          tweetsWithComments.add(jsonData[i]);
          tWCIndices.add(i); //2,3
        }
        else {
          tweetsWithoutComments.add(jsonData[i]);
          tNCIndices.add(i); //0,1,4
        }
      }
      List<dynamic>tweetsGood = [];
      List<dynamic>tweetsBad = [];
      //see if comments in this
      tweetsGood = tweetsWithComments.map((e) => Tweet.fromJson(e, false))
          .toList(); //[2],[3]
      tweetsBad = tweetsWithoutComments.map((e) => Tweet.fromJson(e, true))
          .toList(); //[0],[1],[4]
      for (int i = 0; i < tWCIndices.length; i++) {
        tweetsList.insert(tWCIndices[i], tweetsGood[i]);
      }
      for (int i = 0; i < tNCIndices.length; i++) {
        tweetsList.insert(tNCIndices[i], tweetsBad[i]);
      }
      //----------------------------------------------------------------------
      List<TweetMain>tweetsMain = [];
      List<dynamic>comments = [];
      List<dynamic>likers = [];
      List<dynamic>images = [];
      List<dynamic>videos = [];
      //--------------------------------------------------------------------------
      for (int i = 0; i < tweetsList.length; i++) {
        if (jsonData[i].length == 17) {
          List<List<dynamic>>replies = [];
          if (tweetsList[i].comments.length > 0) {
            comments =
                tweetsList[i].comments.map((e) => Comment.fromJson(e)).toList();

            for (int i = 0; i < comments.length; i++) {
              List<dynamic>reply = comments[i].repliesList.map((e) =>
                  Reply.fromJson(e)).toList();
              replies.add(reply);
            }
          }
          if (tweetsList[i].likerIds.length > 0) {
            likers = tweetsList[i].likerIds.toList();
          }
          if (tweetsList[i].images.length > 0) {
            images =
                tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
          }
          if (tweetsList[i].videos.length > 0) {
            videos =
                tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
          }
          TweetMain tweetIMain = TweetMain(tweet: tweetsList[i],
              comments: comments,
              replies: replies,
              likers: likers,
              videos: videos,
              images: images);
          tweetsMain.add(tweetIMain);
          //print(tweetIMain.getTweetprofilePicUrl());
        }

        else {
          //handle it like the above
          if (tweetsList[i].userId == Auth.userId) {
            images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
            videos =
                tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
            TweetMain tweetIMain = TweetMain(
                tweet: tweetsList[i], videos: videos, images: images);
            tweetsMain.add(tweetIMain);
          }
        }
      }
      return tweetsMain;
    }
  }

  Future<List<TweetMain>?> fetchRandomTweetsOfRandomUsers(int page) async
  {
    final queryParameters = {
      'page': page,
    };
    // final Uri uri = Uri.parse('$backendUrl/tweets/random?page=:page');
    final uri = Uri.parse('$backendUrl/tweets/random?page=$page')
    ;
    // final uri = Uri.http(
    //     Http().getBackendBaseUrl(), '/tweets/random', queryParameters);
    http.Response response = await http.get(uri, headers: {
      "x-access-token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MjY1NTFmNDRkNTc4NmY0MzdjYmIyNWIiLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTY4MjM0MzQ5MX0.8xbJXtfITqlxM1YwdaRV1kr1qXRtvQJ3glhjxNdOPD4"
    },);
    String data = response.body;
    var de = jsonDecode(data);
    if (jsonDecode(data)["404"] != "tweets are unavailable") {
      var jsonData = jsonDecode(data)["tweets"];
      List<dynamic>tweetsWithComments = [];
      List<dynamic>tweetsWithoutComments = [];
      List<dynamic> tweetsList = [];
      List<int>tWCIndices = [];
      List<int>tNCIndices = [];
      for (int i = 0; i < jsonData.length; i++) {
        if (jsonData[i].length == 17) {
          tweetsWithComments.add(jsonData[i]);
          tWCIndices.add(i); //2,3
        }
        else {
          tweetsWithoutComments.add(jsonData[i]);
          tNCIndices.add(i); //0,1,4
        }
      }
      List<dynamic>tweetsGood = [];
      List<dynamic>tweetsBad = [];
      //see if comments in this
      tweetsGood = tweetsWithComments.map((e) => Tweet.fromJson(e, false))
          .toList(); //[2],[3]
      tweetsBad = tweetsWithoutComments.map((e) => Tweet.fromJson(e, true))
          .toList(); //[0],[1],[4]
      for (int i = 0; i < tWCIndices.length; i++) {
        tweetsList.insert(tWCIndices[i], tweetsGood[i]);
      }
      for (int i = 0; i < tNCIndices.length; i++) {
        tweetsList.insert(tNCIndices[i], tweetsBad[i]);
      }
      //----------------------------------------------------------------------
      List<TweetMain>tweetsMain = [];
      List<dynamic>comments = [];
      List<dynamic>likers = [];
      List<dynamic>images = [];
      List<dynamic>videos = [];
      //--------------------------------------------------------------------------
      for (int i = 0; i < tweetsList.length; i++) {
        if (jsonData[i].length == 17) {
          List<List<dynamic>>replies = [];
          if (tweetsList[i].comments.length > 0) {
            comments =
                tweetsList[i].comments.map((e) => Comment.fromJson(e)).toList();

            for (int i = 0; i < comments.length; i++) {
              List<dynamic>reply = comments[i].repliesList.map((e) =>
                  Reply.fromJson(e)).toList();
              replies.add(reply);
            }
          }
          if (tweetsList[i].likerIds.length > 0) {
            likers = tweetsList[i].likerIds.toList();
          }
          if (tweetsList[i].images.length > 0) {
            images =
                tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
          }
          if (tweetsList[i].videos.length > 0) {
            videos =
                tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
          }
          TweetMain tweetIMain = TweetMain(tweet: tweetsList[i],
              comments: comments,
              replies: replies,
              likers: likers,
              videos: videos,
              images: images);
          tweetsMain.add(tweetIMain);
          //print(tweetIMain.getTweetprofilePicUrl());
        }

        else {
          //handle it like the above
          if (tweetsList[i].userId == Auth.userId) {
            images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
            videos =
                tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
            TweetMain tweetIMain = TweetMain(
                tweet: tweetsList[i], videos: videos, images: images);
            tweetsMain.add(tweetIMain);
          }
        }
      }
      return tweetsMain;
    }
  }

  Future<List<TweetMain>> fetchTweetsOfCertainUser(String userId) async
  {
    final queryParameters = {
      'user_id': userId,
      //'token': _email,
    };
    final uri =
    Uri.http(Http().getMobileBaseUrl(), '/tweets/all', queryParameters);
    // final Uri url = Uri.parse('http://192.168.1.8:8000/tweets/all');
    http.Response response = await http.get(
        uri);
    String data = response.body;
    var jsonData = jsonDecode(data);
    List<dynamic>dataGood = [];
    List<dynamic>dataBad = [];
    List<dynamic> tweetsList = [];
    print(jsonData.length);

    for (int i = 0; i < jsonData.length; i++) {
      if (jsonData[i].length == 17) {
        dataGood.add(jsonData[i]);
      }
      else {
        dataBad.add(jsonData[i]);
        print(dataBad[0]);
      }
    }
    List<dynamic>tweetsGood = [];
    List<dynamic>tweetsBad = [];
    tweetsGood = dataGood.map((e) => Tweet.fromJson(e, false)).toList();
    tweetsBad = dataBad.map((e) => Tweet.fromJson(e, true)).toList();
    for (int i = 0; i < tweetsBad.length; i++) {
      tweetsGood.insert(0, tweetsBad[i]);
    }
    tweetsList = tweetsGood;
    //----------------------------------------------------------------------
    List<TweetMain>tweetsMain = [];
    List<dynamic>comments;
    List<dynamic>likers;
    List<dynamic>images;
    List<dynamic>videos;
    //--------------------------------------------------------------------------
    for (int i = 0; i < tweetsList.length; i++) {
      if (tweetsList.length == 17) {
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
        //check if the you the auth are from the likers of the this specific tweet to let the tweet stay liked

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
      }
      else {
        images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
        TweetMain tweetIMain = TweetMain(
            tweet: tweetsList[i], videos: videos, images: images);
        tweetsMain.add(tweetIMain);
      }
    }
    return tweetsMain;
  }

  Future<List<TweetMain>> fetchTweetByTweetId(String tweetId) async
  {
    print("hello");
    final queryParameters = {
      'tweet_id': tweetId,
      //'token': _email,
    };
    final uri = Uri.http(Http().getMobileBaseUrl(), '/tweets', queryParameters);
    http.Response response = await http.get(uri,
    );
    String data = response.body;
    var jsonData = jsonDecode(data);
    print(jsonData[0]);
    print(jsonData[0].length);
    List<dynamic> tweet;
    print("hello");
    if (jsonData[0].length == 17) {
      tweet = jsonData.map((e) => Tweet.fromJson(e, false)).toList();
    }
    else {
      tweet = jsonData.map((e) => Tweet.fromJson(e, true)).toList();
    }
    //----------------------------------------------------------------------
    TweetMain tweetMain;
    List<dynamic>comments=[];
    List<dynamic>likers=[];
    List<dynamic>images=[];
    List<dynamic>videos=[];
    //--------------------------------------------------------------------------
    if (jsonData[0].length == 17) {
      List<List<dynamic>>replies = [];
      comments = tweet[0].comments.map((e) => Comment.fromJson(e)).toList();
      for (int i = 0; i < comments.length; i++) {
        List<dynamic>reply = comments[i].repliesList.map((e) =>
            Reply.fromJson(e)).toList();
        replies.add(reply);
      }
      likers = tweet[0].likerIds.toList();
      //check if the you the auth are from the likers of the this specific tweet to let the tweet stay liked

      images = tweet[0].images.map((e) => Imagei.fromJson(e)).toList();
      videos = tweet[0].videos.map((e) => Video.fromJson(e)).toList();
      TweetMain tweetIMain = TweetMain(tweet: tweet[0],
          comments: comments,
          replies: replies,
          likers: likers,
          videos: videos,
          images: images);
      tweetMain = tweetIMain;
    }
    else {
      if(tweet[0].images.length>0) {


        images = tweet[0].images.map((e) => Imagei.fromJson(e)).toList();

      }
      if(tweet[0].videos.length>0) {
        videos = tweet[0].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetIMain = TweetMain(
          tweet: tweet[0], videos: videos, images: images);
      tweetMain = tweetIMain;
    }
    print("hello");
    List<TweetMain>tweetSent = [];
    tweetSent.add(tweetMain);
    return tweetSent;
  }

  //add tweet is done using mock server for now as testing in backend stop

  Future<void>addTweet({required String text,required List<dynamic>images,required List<dynamic>videos})async
  {
    var headers = {
      'x-access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MjY1NTFmNDRkNTc4NmY0MzdjYmIyNWIiLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTY4MjM0MzQ5MX0.8xbJXtfITqlxM1YwdaRV1kr1qXRtvQJ3glhjxNdOPD4',
      'follow_redirects': 'true',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://45.79.245.94:5000/tweets/'));
    request.body = json.encode({
      "text": "wholaaaaa",
      "images": [],
      "videos": []
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
  // Future<void> addTweet(
  //     {required String dateOfCreation, required String id, required String tweetId, required String text, required List<
  //         dynamic>images, required List<dynamic>videos}) async
  // {
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request(
  //       'POST', Uri.parse('$androidMobileBaseUrl/tweets'));
  //   request.body = json.encode({
  //     "id": id, //random id
  //     "tweet_id": tweetId, //random id for tweet created
  //     "user_id": Auth.userId,
  //     "name": "mohamed",
  //     "username": "Maho",
  //     "prof_pic_url": "https://pbs.twimg.com/media/EEI178KWsAEC79p.jpg",
  //     "bio": Auth.bio,
  //     "followers_count": 100,
  //     "following_count": 200,
  //     "text": text,
  //     "created_at": dateOfCreation,
  //     "like_count": 0,
  //     "comment_count": 0,
  //     "retweet_count": 0,
  //     "images": images,
  //     "videos": videos,
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   print(response.toString());
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }
    Future<void> deleteTweet({required String tweetId}) async
    {
      final queryParameters = {
        'tweet_id': tweetId,
        //'token': _email,
      };
      final uri = Uri.http(
          Http().getMobileBaseUrl(), '/tweets', queryParameters);
      http.Response response = await http.delete(uri);
      if (response.statusCode == 200) {
        print("tweet with id$tweetId is deleted successfully ");
      }
    }

    Future<void> addLike({required String tweetId}) async
    {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('http://192.168.1.8:8000/users/likes'));
      request.body = json.encode({
        "tweet_id": tweetId, //random id for tweet created
        "user_id": Auth.userId,
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
//final Uri uri = Uri.parse('http://192.168.1.8:8000/tweets/all/me');
// http.Response response = await http.get(uri);
// String data=response.body;
// var jsonData=jsonDecode(data);
// List<dynamic>tweetsWithComments=[];
// List<dynamic>tweetsWithoutComments=[];
// List<dynamic> tweetsList=[];
// for(int i=0;i<jsonData.length;i++)
// {
//   if(jsonData[i].length==17) {
//     tweetsWithComments.add(jsonData[i]);
//   }
//   else
//   {
//     tweetsWithoutComments.add(jsonData[i]);
//     print(tweetsWithoutComments[0]);
//   }
// }
// List<dynamic>tweetsGood=[];
// List<dynamic>tweetsBad=[];
// tweetsGood= tweetsWithComments.map((e) => Tweet.fromJson(e,false)).toList();
// tweetsBad= tweetsWithoutComments.map((e) => Tweet.fromJson(e,true)).toList();
// for(int i=0;i<tweetsBad.length;i++)
// {
//   tweetsGood.insert(0, tweetsBad[i]);
// }
// tweetsList=tweetsGood;
// //----------------------------------------------------------------------
// List<TweetMain>tweetsMain=[];
// List<dynamic>comments;
// List<dynamic>likers;
// List<dynamic>images;
// List<dynamic>videos;
// //--------------------------------------------------------------------------
// for (int i = 0; i < tweetsList.length; i++) {
//   if (tweetsList.length==17) {
//     if (tweetsList[i].userId == Auth.userId) {
//       List<List<dynamic>>replies = [];
//       comments =
//           tweetsList[i].comments.map((e) => Comment.fromJson(e))
//               .toList();
//       for (int i = 0; i < comments.length; i++) {
//         List<dynamic>reply = comments[i].repliesList.map((e) =>
//             Reply.fromJson(e)).toList();
//         replies.add(reply);
//       }
//       likers = tweetsList[i].likerIds.toList();
//       //check if the you the auth are from the likers of the this specific tweet to let the tweet stay liked
//
//
//       images = tweetsList[i].images.map((e) => Imagei.fromJson(e))
//           .toList();
//       videos =
//           tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
//       TweetMain tweetIMain = TweetMain(tweet: tweetsList[i],
//           comments: comments,
//           replies: replies,
//           likers: likers,
//           videos: videos,
//           images: images);
//       tweetsMain.add(tweetIMain);
//     }
//   }
//   else
//   {
//     if(tweetsList[i].userId==Auth.userId) {
//       images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
//       videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
//       TweetMain tweetIMain = TweetMain(
//           tweet: tweetsList[i], videos: videos, images: images);
//       tweetsMain.add(tweetIMain);
//     }
//
//   }
// }
// return tweetsMain;

///mock server post tweet
// var headers = {
//   'Content-Type': 'application/json'
// };
// var request = http.Request('POST', Uri.parse('http://192.168.1.8:8000/tweets'));
// request.body = json.encode({
// "id": id,//random id
// "tweet_id": tweetId,//random id for tweet created
// "user_id": Auth.userId,
// "name": Auth.name,
// "username": Auth.username,
// "prof_pic_url": Auth.profilePicUrl,
// "bio": Auth.bio,
// "followers_count": 100,
// "following_count": 200,
// "text": text,
// "created_at": dateOfCreation,
// "like_count": 0,
// "comment_count": 0,
// "retweet_count": 0,
// "images": [
// {
// "url": "assets/tweets_images/zendayaLit.jpg",
// "alt_text": "string",
// "height": 200,
// "width": 200
// }
// ],
// "videos": [
// {
// "url": "string",
// "alt_text": "string",
// "height": 0,
// "width": 0
// }
// ]
// });
// request.headers.addAll(headers);
// http.StreamedResponse response = await request.send();
// print(response.toString());
// if (response.statusCode == 200) {
// print(await response.stream.bytesToString());
// }
// else {
// print(response.reasonPhrase);
///---------------------------------------------------------------------------------------------
///backend post request
///
// //
// Future<void>addTweet({required String text,required List<dynamic>images,required List<dynamic>videos})async
// {
//   final Uri uri = Uri.parse('$backendUrl/tweets');
//   http.Response response = await http.post(uri,headers: {"x-access-token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MjY1NTFmNDRkNTc4NmY0MzdjYmIyNWIiLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTY4MjM0MzQ5MX0.8xbJXtfITqlxM1YwdaRV1kr1qXRtvQJ3glhjxNdOPD4"}
//   ,body:  json.encode({
//
//         "Text": text,
//         "images": images,
//         "videos":videos
//       })
//   );
//
//
//
// }
