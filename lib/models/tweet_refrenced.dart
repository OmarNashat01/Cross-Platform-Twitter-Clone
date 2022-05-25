import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:flutter/material.dart';

class TweetReferenced {
  TweetReferenced(
      {required this.tweetId,
        required this.userId,
        required this.profilePicUrl,
        required this.username,
        required this.text,
        required this.commentCount,
        required this.retweetCount,
        required this.videos,
        required this.images,
        required this.likeCount,
        required this.comments,
        required this.likerIds
      });

  String tweetId;
  String userId;
  String username;
  String profilePicUrl;
  String text;
  //should be modified
  bool isLiked=false;

  //videos content------------------------------------------
  List<dynamic> videos;

  //Images content------------------------------------------
  List<dynamic> images;
  List<dynamic> comments;
  List<dynamic> likerIds;

  //------------------------------------------
  //likes------------------------------------------
  int likeCount;
  //comments------------------------------------------
  int commentCount;

  //retweets------------------------------------------
  int retweetCount;

//-----------------------------------------------------

  //reading from json
  void setTweetLike(bool liked)
  {
    isLiked=liked;
  }
  factory TweetReferenced.fromJson(Map<String, dynamic> jsonData) {
    return TweetReferenced(
      tweetId: jsonData["tweet_id"],
      userId: jsonData["user_id"],
      profilePicUrl: jsonData["prof_pic_url"],
      username: jsonData["username"],
      text: jsonData['text'],
      videos: jsonData['videos'],
      images: jsonData['images'],
      commentCount: jsonData['comment_count'],
      retweetCount: jsonData['retweet_count'],
      likeCount: jsonData['like_count'],
      likerIds: jsonData['liker_by_ids'],
      comments: jsonData['comments'],
    );
  }
}
