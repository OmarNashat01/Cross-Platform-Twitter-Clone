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
import '../models/small_user_model.dart';
import '../models/tweets_model.dart';
import '../models/user_model.dart';
import '../models/video_model.dart';
class UsersApi {

  Future<User> fetchUserByUserId(String userId) async
  {
    // final queryParameters = {
    //   'user_id': userId,
    // };
    // final Uri uri = Uri.parse('$backendUrl/tweets/random?page=:page');
    final uri = Uri.parse('$backendUrl/users/user_id?_id=$userId')
    ;
    // final uri = Uri.http(
    //     Http().getBackendBaseUrl(), '/tweets/random', queryParameters);
    http.Response response = await http.get(uri, headers: {
      "x-access-token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MjY1NTFmNDRkNTc4NmY0MzdjYmIyNWIiLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTY4MjM0MzQ5MX0.8xbJXtfITqlxM1YwdaRV1kr1qXRtvQJ3glhjxNdOPD4"
    },);
    String data = response.body;
    var jsonData = jsonDecode(data)["user"];
    List<dynamic>j=[];
    j.add(jsonData);
    List<dynamic> userList = j.map((e) => User.fromJson(e)).toList();
    //----------------------------------------------------------------------
    List<dynamic>followersList = [];
    List<dynamic>followingList = [];

    //--------------------------------------------------------------------------

    followersList =
        userList[0].followers.map((e) => SmallUser.fromJson(e)).toList();

    //check if the you the auth are from the likers of the this specific tweet to let the tweet stay liked

    followingList = userList[0].following.map((e) => SmallUser.fromJson(e)).toList();

    User user = User(username: userList[0].username,
        name: userList[0].name,
        followingCount: userList[0].followingCount,
        followersCount: userList[0].followersCount,
        followers: followersList,
        following: followingList,
        tweetCount: userList[0].tweetCount,
        admin: userList[0].admin,
        email: userList[0].email,
        dateOfBirth: userList[0].dateOfBirth,
        creationDate: userList[0].creationDate,
        id: userList[0].id,
        location: userList[0].location,
        profilePicUrl: userList[0].profilePicUrl,
        coverPicUrl: userList[0].coverPicUrl,
        gender: userList[0].gender);

    return user;
  }
}

