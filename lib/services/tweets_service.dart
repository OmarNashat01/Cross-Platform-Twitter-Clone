import 'dart:async';
import 'dart:convert';
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
class TweetsApi
{

  Future<List<TweetMain>>fetchMyTweets()async
  {
    final Uri uri = Uri.parse('http://192.168.1.8:8000/tweets/all/me');
    http.Response response = await http.get(uri);
    String data=response.body;
    var jsonData=jsonDecode(data);
    List<dynamic>tweetsWithComments=[];
    List<dynamic>tweetsWithoutComments=[];
    List<dynamic> tweetsList=[];
    for(int i=0;i<jsonData.length;i++)
    {
      if(jsonData[i].length==17) {
        tweetsWithComments.add(jsonData[i]);
      }
      else
      {
        tweetsWithoutComments.add(jsonData[i]);
        print(tweetsWithoutComments[0]);
      }
    }
    List<dynamic>tweetsGood=[];
    List<dynamic>tweetsBad=[];
    tweetsGood= tweetsWithComments.map((e) => Tweet.fromJson(e,false)).toList();
    tweetsBad= tweetsWithoutComments.map((e) => Tweet.fromJson(e,true)).toList();
    for(int i=0;i<tweetsBad.length;i++)
    {
      tweetsGood.insert(0, tweetsBad[i]);
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
      if (tweetsList.length==17) {
        if (tweetsList[i].userId == Auth.userId) {
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
          for (int i = 0; i < likers.length; i++) {
            if (Auth.userId == likers[i]) {
              tweetsList[i].isLiked = true;
              print('your repsone is ${tweetsList[i].isLiked}');
            }
          }
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
      }
      else
      {
        if(tweetsList[i].userId==Auth.userId) {
          images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
          videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
          TweetMain tweetIMain = TweetMain(
              tweet: tweetsList[i], videos: videos, images: images);
          tweetsMain.add(tweetIMain);
        }

      }
    }
    return tweetsMain;
  }
  Future<List<TweetMain>>fetchRandomTweetsOfRandomUsers(int page)async
  {

    final queryParameters = {
      'page': page,
      //'token': _email,
    };
    final uri = Uri.http(Http().getMobileBaseUrl(), '/tweets/random', queryParameters);
    http.Response response = await http.get(uri);
    String data=response.body;
    var jsonData=jsonDecode(data);
    List<dynamic>dataWithComments=[];
    List<dynamic>dataWithoutComments=[];
    List<dynamic> tweetsList=[];
    print(jsonData.length);

    for(int i=0;i<jsonData.length;i++)
    {
      if(jsonData[i].length==17) {
        dataWithComments.add(jsonData[i]);
      }
      else
      {
        dataWithoutComments.add(jsonData[i]);
        print(dataWithoutComments[0]);
      }
    }
    List<dynamic>tweetsGood=[];
    List<dynamic>tweetsBad=[];
    tweetsGood= dataWithComments.map((e) => Tweet.fromJson(e,false)).toList();
    tweetsBad= dataWithoutComments.map((e) => Tweet.fromJson(e,true)).toList();
    for(int i=0;i<tweetsBad.length;i++)
    {
      tweetsGood.insert(0, tweetsBad[i]);
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
        for(int i=0;i<likers.length;i++)
        {
          if(Auth.userId==likers[i])
          {
            tweetsList[i].isLiked=true;
            print('your repsone is ${tweetsList[i].isLiked}');
          }
        }
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
      else
      {
        images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
        TweetMain tweetIMain = TweetMain(tweet: tweetsList[i], videos: videos, images: images);
        tweetsMain.add(tweetIMain);

      }
    }
    return tweetsMain;
  }
  Future<List<TweetMain>>fetchTweetsOfCertainUser(String userId)async
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
        for(int i=0;i<likers.length;i++)
        {
          if(Auth.userId==likers[i])
          {
            tweetsList[i].isLiked=true;
            print('your repsone is ${tweetsList[i].isLiked}');
          }
        }
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
      else
      {
        images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
        TweetMain tweetIMain = TweetMain(tweet: tweetsList[i], videos: videos, images: images);
        tweetsMain.add(tweetIMain);

      }
    }
    return tweetsMain;
  }
  Future<TweetMain>fetchTweetByTweetId(String tweetId)async
  {

    final queryParameters = {
      'tweet_id': tweetId,
      //'token': _email,
    };
    final uri = Uri.http(Http().getMobileBaseUrl(), '/tweets/tweet_id', queryParameters);
    http.Response response = await http.get(uri);
    String data=response.body;
    var jsonData=jsonDecode(data);
    dynamic tweet;

      if(jsonData[0].length==17) {
        tweet= jsonData.map((e) => Tweet.fromJson(e,false)).toList();
      }
      else
      {
        tweet= jsonData.map((e) => Tweet.fromJson(e,true)).toList();

      }
    //----------------------------------------------------------------------
    TweetMain tweetMain;
    List<dynamic>comments;
    List<dynamic>likers;
    List<dynamic>images;
    List<dynamic>videos;
    //--------------------------------------------------------------------------

      if (tweet.length==17)
      {
        List<List<dynamic>>replies = [];
        comments = tweet.comments.map((e) => Comment.fromJson(e)).toList();
        for (int i = 0; i < comments.length; i++) {
          List<dynamic>reply = comments[i].repliesList.map((e) => Reply.fromJson(e)).toList();
          replies.add(reply);
        }
        likers = tweet.likerIds.toList();
        //check if the you the auth are from the likers of the this specific tweet to let the tweet stay liked
        for(int i=0;i<likers.length;i++)
        {
          if(Auth.userId==likers[i])
          {
            tweet.isLiked=true;
          }
        }
        images = tweet.images.map((e) => Imagei.fromJson(e)).toList();
        videos = tweet.videos.map((e) => Video.fromJson(e)).toList();
        TweetMain tweetIMain = TweetMain(tweet: tweet,
            comments: comments,
            replies: replies,
            likers: likers,
            videos: videos,
            images: images);
        tweetMain=tweetIMain;
      }
      else
      {
        images = tweet.images.map((e) => Imagei.fromJson(e)).toList();
        videos = tweet.videos.map((e) => Video.fromJson(e)).toList();
        TweetMain tweetIMain = TweetMain(tweet: tweet, videos: videos, images: images);
        tweetMain=tweetIMain;

      }

    return tweetMain;
  }
  Future<void>addTweet({required String text,required String dateOfCreation})async
  {

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://192.168.1.8:8000/tweets'));
    var uuid = Uuid();
    request.body = json.encode({
      "id": uuid.v4(),//random id
      "tweet_id": uuid.v4(),//random id for tweet created
      "user_id": Auth.userId,
      "name": Auth.name,
      "username": Auth.username,
      "prof_pic_url": Auth.profilePicUrl,
      "bio": Auth.bio,
      "followers_count": 100,
      "following_count": 200,
      "text": text,
      "created_at": dateOfCreation,
      "like_count": 0,
      "comment_count": 0,
      "retweet_count": 0,
      "images": [
        {
          "url": "assets/tweets_images/zendayaLit.jpg",
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
  Future<void>addLike({required String tweetId})async
  {


    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://192.168.1.8:8000/users/likes'));
    request.body = json.encode({
      "tweet_id": tweetId,//random id for tweet created
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
// final queryParameters = {
//   'user_id': userId,
//   //'token': _email,
// };
// final uri =
// Uri.http(Http().getMobileBaseUrl(), '/tweets/all', queryParameters);
// // final Uri url = Uri.parse('http://192.168.1.8:8000/tweets/all');
// http.Response response = await http.get(
// uri);
// String data=response.body;
// var jsonData=jsonDecode(data);
// List<dynamic>dataGood=[];
// List<dynamic>dataBad=[];
// List<dynamic> tweetsList=[];
// print(jsonData.length);
//
// for(int i=0;i<jsonData.length;i++)
// {
// if(jsonData[i].length==17) {
// dataGood.add(jsonData[i]);
// }
// else
// {
// dataBad.add(jsonData[i]);
// print(dataBad[0]);
// }
// }
// List<dynamic>tweetsGood=[];
// List<dynamic>tweetsBad=[];
// tweetsGood= dataGood.map((e) => Tweet.fromJson(e,false)).toList();
// tweetsBad= dataBad.map((e) => Tweet.fromJson(e,true)).toList();
// for(int i=0;i<tweetsBad.length;i++)
// {
// tweetsGood.insert(0, tweetsBad[i]);
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
// if (tweetsList.length==17)
// {
// List<List<dynamic>>replies = [];
// comments =
// tweetsList[i].comments.map((e) => Comment.fromJson(e))
//     .toList();
// for (int i = 0; i < comments.length; i++) {
// List<dynamic>reply = comments[i].repliesList.map((e) =>
// Reply.fromJson(e)).toList();
// replies.add(reply);
// }
// likers = tweetsList[i].likerIds.toList();
// //check if the you the auth are from the likers of the this specific tweet to let the tweet stay liked
// for(int i=0;i<likers.length;i++)
// {
// if(Auth.userId==likers[i])
// {
// tweetsList[i].isLiked=true;
// print('your repsone is ${tweetsList[i].isLiked}');
// }
// }
// images = tweetsList[i].images.map((e) => Imagei.fromJson(e))
//     .toList();
// videos =
// tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
// TweetMain tweetIMain = TweetMain(tweet: tweetsList[i],
// comments: comments,
// replies: replies,
// likers: likers,
// videos: videos,
// images: images);
// tweetsMain.add(tweetIMain);
// }
// else
// {
// images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
// videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
// TweetMain tweetIMain = TweetMain(tweet: tweetsList[i], videos: videos, images: images);
// tweetsMain.add(tweetIMain);
//
// }
// }
// return tweetsMain;
