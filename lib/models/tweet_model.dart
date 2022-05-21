import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:flutter/material.dart';

class Tweet {
  Tweet(
      {required this.tweetId,
      required this.userId,
      required this.profilePicUrl,
      required this.username,
      required this.text,
      required this.commentCount,
      required this.retweetCount,
      required this.likeCount,
      required this.createdAt,
      required this.videos,
      required this.images,
      required this.comments,
      required this.likerIds,
      required this.name,
      required this.followersCount,
      required this.followingCount,
      required this.bio});

  String tweetId;
  String userId;
  String name;
  String username;
  String profilePicUrl;
  String text;
  String? bio;
  int followingCount;
  int followersCount;

  String createdAt;

  //videos content------------------------------------------
  List<dynamic> videos;

  //Images content------------------------------------------
  List<dynamic> images;

  //------------------------------------------
  //likes------------------------------------------
  int likeCount;
  List<dynamic> likerIds;

  //comments------------------------------------------
  int commentCount;
  List<dynamic> comments;

  //retweets------------------------------------------
  int retweetCount;

//-----------------------------------------------------

  //reading from json
  factory Tweet.fromJson(Map<String, dynamic> jsonData) {
    return Tweet(
        tweetId: jsonData["tweet_id"],
        userId: jsonData["user_id"],
        profilePicUrl: jsonData["prof_pic_url"],
        name: jsonData["name"],
        username: jsonData["username"],
        bio: jsonData["bio"],
        followersCount: jsonData["followers_count"],
        followingCount: jsonData["following_count"],
        createdAt: jsonData["created_at"],
        text: jsonData['text'],
        videos: jsonData['videos'],
        images: jsonData['images'],
        likeCount: jsonData['like_count'],
        likerIds: jsonData['liked_by_ids'],
        commentCount: jsonData['comment_count'],
        retweetCount: jsonData['retweet_count'],
        comments: jsonData['comments']);
  }
}
