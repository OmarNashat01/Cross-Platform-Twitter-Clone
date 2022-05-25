import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:twitter/models/retweet_complete_model.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/models/comment_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/image_model.dart';
import '../models/likers_model.dart';
import '../models/reply_model.dart';
import '../models/retweet_model.dart';
import '../models/tweet_refrenced.dart';
import '../models/video_model.dart';

class TweetsApi {
  Future<List<TweetMain>?> fetchMyTweets() async {
    final Uri uri = Uri.parse('$backendUrl/tweets/all/me');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var de = jsonDecode(data);
    var jsonData = jsonDecode(data)["tweets"];

    List<dynamic> tweetsList = [];

    //see if comments in this
    tweetsList = jsonData.map((e) => Tweet.fromJson(e,"simpleTweetWithType")).toList(); //[2],[3]
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];

    //--------------------------------------------------------------------------
    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds.map((e) => Likers.fromJson(e)).toList();
        for (int j = 0; j < likers.length; j++) {
          if (likers[j].likerId == Auth.userId) {
            tweetsList[i].isLiked = true;
            break;
          }
        }
      }
      // print("tweet number $i isLiked = ${tweetsList[i].isLiked}");
      if (tweetsList[i].images.length > 1) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetIMain = TweetMain(
          outerTweet: tweetsList[i],
          comments: comments,
          likers: likers,
          videos: videos,
          images: images);
      tweetsMain.add(tweetIMain);
    }
    return tweetsMain;
  }

  Future<List<TweetMain>?> fetchUserTweets(String userId) async {
    final Uri uri = Uri.parse('$backendUrl/tweets/all?Id=$userId');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var jsonData = jsonDecode(data)["tweets"];
    List<dynamic> tweetsList = [];

    //see if comments in this
    tweetsList = jsonData.map((e) => Tweet.fromJson(e,"simpleTweetWithType")).toList(); //[2],[3]
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];
    //--------------------------------------------------------------------------
    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds
          ..map((e) => Likers.fromJson(e)).toList();
      }
      if (tweetsList[i].images.length > 1) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetIMain = TweetMain(
          outerTweet: tweetsList[i],
          comments: comments,
          likers: likers,
          videos: videos,
          images: images);
      tweetsMain.add(tweetIMain);
    }
    return tweetsMain;
  }
  Future<List<TweetMain>?> fetchLikedUserTweets(String userId) async {
    final Uri uri = Uri.parse('$backendUrl/tweets/all/liked?Id=$userId');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var jsonData = jsonDecode(data)["tweets"];
    List<dynamic> tweetsList = [];

    //see if comments in this
    tweetsList = jsonData.map((e) => Tweet.fromJson(e,"simpleTweetWithType")).toList(); //[2],[3]
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];
    //--------------------------------------------------------------------------
    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds
          ..map((e) => Likers.fromJson(e)).toList();
      }
      if (tweetsList[i].images.length > 1) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetIMain = TweetMain(
          outerTweet: tweetsList[i],
          comments: comments,
          likers: likers,
          videos: videos,
          images: images);
      tweetsMain.add(tweetIMain);
    }
    return tweetsMain;
  }
  Future<List<TweetMain>?> fetchRandomTweetsOfRandomUsers(int page) async {
    final queryParameters = {
      'page': page,
    };
    // final Uri uri = Uri.parse('$backendUrl/tweets/random?page=:page');
    final uri = Uri.parse('$backendUrl/tweets/random?page=$page');
    // final uri = Uri.http(
    //     Http().getBackendBaseUrl(), '/tweets/random', queryParameters);
    http.Response response = await http.get(
      uri,
      headers: {
        "x-access-token":
        Auth.token      },
    );
    String data = response.body;
    var de = jsonDecode(data);
    if (jsonDecode(data)["404"] != "tweets are unavailable") {
      var jsonData = jsonDecode(data)["tweets"];
      List<dynamic> tweetsList = [];
      //see if comments in this
      tweetsList = jsonData.map((e) => Tweet.fromJson(e,"simpleTweetWithType")).toList(); //[2],[3]
      //----------------------------------------------------------------------
      List<TweetMain> tweetsMain = [];
      List<dynamic> comments = [];
      List<dynamic> likers = [];
      List<dynamic> images = [];
      List<dynamic> videos = [];
      //--------------------------------------------------------------------------
      for (int i = 0; i < tweetsList.length; i++) {
        images = [];
        comments = [];
        likers = [];
        videos = [];
        if (tweetsList[i].comments.length > 0) {
          comments = tweetsList[i].comments.toList();
        }
        if (tweetsList[i].likerIds.length > 0) {
          likers =
              tweetsList[i].likerIds.map((e) => Likers.fromJson(e)).toList();
          for (int j = 0; j < likers.length; j++) {
            if (likers[j].likerId == Auth.userId) {
              tweetsList[i].isLiked = true;
              break;
            }
          }
        }
        if (tweetsList[i].images.length > 0) {
          images = tweetsList[i].images.map((e) => Imagei.fromJson(e)).toList();
        }
        if (tweetsList[i].videos.length > 0) {
          videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
        }
        TweetMain tweetIMain = TweetMain(
            outerTweet: tweetsList[i],
            comments: comments,
            likers: likers,
            videos: videos,
            images: images);
        tweetsMain.add(tweetIMain);
      }
      return tweetsMain;
    }
    return null;
  }
  Future<List<TweetMain>?> fetchHomeUserTweets(String userId) async {
    final Uri uri = Uri.parse('$backendUrl/tweets/retweets/all?Id=$userId');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var jsonData = jsonDecode(data)["retweets"];
    List<dynamic> tweetsList = [];
    print(jsonData[0]);
    tweetsList = jsonData.map((e) => Tweet.fromJson(e,"retweet")).toList(); //[2],[3]
    //----------------------------------------------------------------------
    print(tweetsList);
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];
    List<dynamic> tweetReferenced=[];
    //--------------------------------------------------------------------------

    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      List<dynamic> tweetReferenced=[];
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds.map((e) => Likers.fromJson(e)).toList();
        for (int j = 0; j < likers.length; j++) {
          if (likers[j].likerId == Auth.userId) {
            tweetsList[i].isLiked = true;
            break;
          }
        }
      }
      if (tweetsList[i].images.length > 0) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      List<dynamic> s = [];
      s.add(tweetsList[i].tweetReferenced);
      if(tweetsList[i].tweetReferenced!="None"&&tweetsList[i].quoted==true) {
        tweetReferenced =
            s.map((e) => Tweet.fromJson(e, "referencedTweet")).toList();
        tweetReferenced[i].quoted = false;
        tweetsList[i].tweetReferenced = tweetReferenced;
        TweetMain tweetMain = TweetMain(
            outerTweet: tweetsList[i],
            innerTweet: tweetReferenced[i],
            comments: comments,
            likers: likers,
            videos: videos,
            images: images);
        tweetsMain.add(tweetMain);
      }
      else if(tweetsList[i].tweetReferenced!="None"&&tweetsList[i].quoted==false)
        {
          tweetReferenced =
              s.map((e) => Tweet.fromJson(e, "referencedTweet")).toList();
          tweetReferenced[i].quoted = false;
          tweetsList[i].tweetReferenced = tweetReferenced;
          TweetMain tweetMain = TweetMain(
              outerTweet: tweetReferenced[i],
              comments: comments,
              likers: likers,
              videos: videos,
              images: images);
          tweetsMain.add(tweetMain);
        }
      else
        {
          TweetMain tweetMain = TweetMain(
              outerTweet: tweetsList[i],
              comments: comments,
              likers: likers,
              videos: videos,
              images: images);
          tweetsMain.add(tweetMain);
        }
    }
    print(tweetsMain[0].outerTweet.text);
    return tweetsMain;
  }



  Future<List<TweetMain>?> fetchTweetByTweetId(String tweetId) async {
    final Uri uri = Uri.parse('$backendUrl/tweets/tweet?Id=$tweetId');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var jsonData = jsonDecode(data)["tweet"];
    List<dynamic> d = [];
    d.add(jsonData);
    List<dynamic> tweetsList = [];
    print(jsonData);
    //see if comments in this

    tweetsList = d.map((e) => Tweet.fromJson(e,"simpleTweetWithoutType")).toList(); //[2],[3]
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];
    //--------------------------------------------------------------------------

    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds.map((e) => Likers.fromJson(e)).toList();
        for (int j = 0; j < likers.length; j++) {
          if (likers[j].likerId == Auth.userId) {
            tweetsList[i].isLiked = true;
            break;
          }
        }
      }
      if (tweetsList[i].images.length > 0) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetIMain = TweetMain(
          outerTweet: tweetsList[i],
          comments: comments,
          likers: likers,
          videos: videos,
          images: images);
      tweetsMain.add(tweetIMain);
    }
    return tweetsMain;
  }
  Future<List<TweetMain>?> fetchQuotedRetweet(String retweetId) async {
    final Uri uri = Uri.parse('$backendUrl/tweets/retweets/retweet?Id=$retweetId');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var jsonData = jsonDecode(data)["tweet"];
    List<dynamic> d = [];
    print(jsonData);
    d.add(jsonData);
    List<dynamic> tweetsList = [];

    //see if comments in this
    tweetsList = d.map((e) => Tweet.fromJson(e,"retweet")).toList(); //[2],[3]
    print(tweetsList);
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];
    List<dynamic> tweetReferenced=[];
    //--------------------------------------------------------------------------

    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      List<dynamic> s = [];
      s.add(tweetsList[i].tweetReferenced);
      tweetReferenced=s.map((e) => Tweet.fromJson(e,"referencedTweet")).toList();
      // print(tweetsList[i]);
      // print(tweetReferenced[i]);
      tweetsList[i].tweetReferenced=tweetReferenced;
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds.map((e) => Likers.fromJson(e)).toList();
        for (int j = 0; j < likers.length; j++) {
          if (likers[j].likerId == Auth.userId) {
            tweetsList[i].isLiked = true;
            break;
          }
        }
      }
      if (tweetsList[i].images.length > 0) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetMain = TweetMain(
          outerTweet: tweetsList[i],
          innerTweet: tweetReferenced[i],
          comments: comments,
          likers: likers,
          videos: videos,
          images: images);
      tweetsMain.add(tweetMain);
    }
    return tweetsMain;
  }
  Future<List<TweetMain>?> fetchRetweet(String retweetId) async {
    final Uri uri = Uri.parse('$backendUrl/tweets/retweets/retweet?Id=$retweetId');
    http.Response response = await http.get(uri, headers: {
      "x-access-token":
      Auth.token    });
    String data = response.body;
    var jsonData = jsonDecode(data)["tweet"];
    List<dynamic> d = [];
    print(jsonData);
    d.add(jsonData);
    List<dynamic> tweetsList = [];

    //see if comments in this
    tweetsList = d.map((e) => Tweet.fromJson(e,"retweet")).toList(); //[2],[3]
    print(tweetsList);
    //----------------------------------------------------------------------
    List<TweetMain> tweetsMain = [];
    List<dynamic> comments = [];
    List<dynamic> likers = [];
    List<dynamic> images = [];
    List<dynamic> videos = [];
    List<dynamic> tweetReferenced=[];
    //--------------------------------------------------------------------------

    for (int i = 0; i < tweetsList.length; i++) {
      images = [];
      comments = [];
      likers = [];
      videos = [];
      List<dynamic> s = [];
      s.add(tweetsList[i].tweetReferenced);
      tweetReferenced=s.map((e) => Tweet.fromJson(e,"referencedTweet")).toList();
      tweetReferenced[i].quoted=false;
      // print(tweetsList[i]);
      // print(tweetReferenced[i]);
      tweetsList[i].tweetReferenced=tweetReferenced;
      if (tweetsList[i].comments.length > 0) {
        comments = tweetsList[i].comments.toList();
      }
      if (tweetsList[i].likerIds.length > 0) {
        likers = tweetsList[i].likerIds.map((e) => Likers.fromJson(e)).toList();
        for (int j = 0; j < likers.length; j++) {
          if (likers[j].likerId == Auth.userId) {
            tweetsList[i].isLiked = true;
            break;
          }
        }
      }
      if (tweetsList[i].images.length > 0) {
        images = tweetsList[i].images.toList();
      }
      if (tweetsList[i].videos.length > 0) {
        videos = tweetsList[i].videos.map((e) => Video.fromJson(e)).toList();
      }
      TweetMain tweetMain = TweetMain(
          outerTweet:  tweetReferenced[i],
          comments: comments,
          likers: likers,
          videos: videos,
          images: images);
      tweetsMain.add(tweetMain);
    }
    print(tweetsMain[0].outerTweet.text);
    return tweetsMain;
  }
  //add tweet is done using mock server for now as testing in backend stop

  Future<String> addTweet({required String text, required List<dynamic> images, required List<dynamic> videos}) async {
    var headers = {
      'x-access-token':
          Auth.token
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$backendUrl/tweets'));
    request.fields.addAll({'text': text});
    for (int i = 0; i < images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('img', images[i]));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data =await response.stream.bytesToString();
      var jsonData = jsonDecode(data)["200"];
      String tweetId="";
      int idx = jsonData.indexOf(":");
      for (int i = 0; i < jsonData.length; i++) {
        if (jsonData[i] == ':') {
            tweetId=jsonData.substring(idx + 1).trim();
          break;
        }
      }
      return tweetId;

    } else {
      print(response.reasonPhrase);
      return "";
    }
  }
  Future<String> addQuotedRetweet({required bool quoted,required String tweetId,required String text, required List<dynamic> images, required List<dynamic> videos}) async {
    var headers = {
      'x-access-token':
      Auth.token    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$backendUrl/users/retweets'));
    request.fields.addAll({'text': text,"vid":"","quoted":"True","tweet_id":tweetId});
    for (int i = 0; i < images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('img', images[i]));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data =await response.stream.bytesToString();
      print(data);
      var jsonData = jsonDecode(data)["200"];
      String tweetId="";
      int idx = jsonData.indexOf(":");
      for (int i = 0; i < jsonData.length; i++) {
        if (jsonData[i] == ':') {
          tweetId=jsonData.substring(idx + 1).trim();
          break;
        }
      }
      return tweetId;

    } else {
      print(response.reasonPhrase);
      return "";
    }
  }
  Future<String> Retweet({required bool quoted,required String tweetId}) async {
    var headers = {
      'x-access-token':
      Auth.token    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$backendUrl/users/retweets'));
    request.fields.addAll({"quoted":"False","tweet_id":tweetId});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data =await response.stream.bytesToString();
      var jsonData = jsonDecode(data)["200"];
      String tweetId="";
      int idx = jsonData.indexOf(":");
      for (int i = 0; i < jsonData.length; i++) {
        if (jsonData[i] == ':') {
          tweetId=jsonData.substring(idx + 1).trim();
          break;
        }
      }
      return tweetId;

    } else {
      print(response.reasonPhrase);
      return "";
    }
  }

  Future<void> addComment({required String text, required List<dynamic> images, required List<dynamic> videos, required tweetId}) async {
    var headers = {
      'x-access-token':
      Auth.token    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$backendUrl/users/comments'));
    request.fields.addAll({
      'text': text,
      'tweet_id': tweetId,
    });
    for (int i = 0; i < images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('img', images[i]));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<TweetMain> getAddedTweet() async {
    dynamic myTweets = await fetchMyTweets();
    return myTweets.last;
  }

  Future<void> deleteTweet({required String tweetId}) async {
    var headers = {
      'x-access-token':
      Auth.token    };
    var request = http.Request(
        'DELETE', Uri.parse('$backendUrl/tweets?Id=$tweetId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> likeUnlike({required String tweetId, required TweetMain tweet}) async {
    var headers = {
      'x-access-token':
      Auth.token,      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$backendUrl/users/likes'));
    request.body = json.encode({"tweet_id": tweetId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      tweet.outerTweet.isLiked = true;
      print(await response.stream.bytesToString());
    } else if (response.statusCode == 406) {
      await deleteLike(tweetId: tweetId);
      tweet.outerTweet.isLiked = false;
    } else {
      print(response.reasonPhrase);
    }

    // SEND NOTIFICATION
    sendLikeNotification();
  }

  Future<void> sendLikeNotification() async {
    var response = await http.post(
      Uri.parse('${Http().getBaseUrl()}/users/notifications'),
      headers: {
        'Content-Type': 'application/json',
        'x-access-token': Auth.token
      },
      body: jsonEncode({
        "user_id": Auth.userId,
        "notification_type": "string", //! to be changed
      }),
    );

    if (response.statusCode == 200) {
      log('Like Notification SENT');
    } else {
      log('Like Notification Unauthorized');
    }
  }

  Future<void> deleteLike({required String tweetId}) async {
    var headers = {
      'x-access-token':
      Auth.token   ,   'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE',
        Uri.parse('$backendUrl/users/likes?Id=$tweetId'));
    request.body = json.encode({"tweet_id": "628a3d2885a8cfe478cb8bd5"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
