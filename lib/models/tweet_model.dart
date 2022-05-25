import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:flutter/material.dart';

class Tweet {
  //followers
  //folllowing
  //name
  //type
  //quoted
  //tweet refrenced
  Tweet(
      {required this.tweetId,
      required this.userId,
      required this.profilePicUrl,
      required this.username,
       this.text,
      required this.commentCount,
      required this.retweetCount,
      required this.likeCount,
      required this.createdAt,
      required this.videos,
      required this.images,
      required this.comments,
      required this.likerIds,
       this.name,
       this.followersCount,
       this.followingCount,
         this.type,
        this.tweetReferenced,
        this.quoted
      });
//main things
  String tweetId;
  String userId;
  String ?name;
  String username;
  String profilePicUrl;
  String ?text;
  String createdAt;
  int ?followingCount;
  int ?followersCount;
  //should be modified
  bool isLiked=false;
  String? type;

  //videos content------------------------------------------
  List<dynamic> videos;

  //Images content------------------------------------------
  List<dynamic> images;

  //------------------------------------------
  dynamic tweetReferenced;
  bool ?quoted;
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
  void setTweetLike(bool liked)
  {
    isLiked=liked;
  }
  factory Tweet.fromJson(Map<String, dynamic> jsonData,String type) {
    if(type=="simpleTweetWithType") {
      return Tweet(
        tweetId: jsonData["tweet_id"],
        userId: jsonData["user_id"],
        profilePicUrl: jsonData["prof_pic_url"],
        name: jsonData["name"],
        username: jsonData["username"],
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
        comments: jsonData['comments'],
        type: jsonData['type'],
      );
    }
    else if (type=="simpleTweetWithoutType")
      {
        return Tweet(
          tweetId: jsonData["tweet_id"],
          userId: jsonData["user_id"],
          profilePicUrl: jsonData["prof_pic_url"],
          name: jsonData["name"],
          username: jsonData["username"],
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
          comments: jsonData['comments'],
        );
      }
    else if (type=="referencedTweet")
      {
        return Tweet(
          tweetId: jsonData["tweet_id"],
          userId: jsonData["user_id"],
          profilePicUrl: jsonData["prof_pic_url"],
          username: jsonData["username"],
          createdAt: jsonData["created_at"],
          text: jsonData['text'],
          videos: jsonData['videos'],
          images: jsonData['images'],
          likeCount: jsonData['like_count'],
          likerIds: jsonData['liker_by_ids'],
          commentCount: jsonData['comment_count'],
          retweetCount: jsonData['retweet_count'],
          comments: jsonData['comments'],
        );

      }
    // type=="retweet"
    else
    {
      print("a7a");
      return Tweet(
        tweetId: jsonData["tweet_id"],
        userId: jsonData["user_id"],
        tweetReferenced: jsonData["tweet_refrenced"],
        quoted: jsonData["quoted"],
        profilePicUrl: jsonData["prof_pic_url"],
        name: jsonData["name"],
        text: jsonData['text'],
        username: jsonData["username"],
        followersCount: jsonData["followers_count"],
        followingCount: jsonData["following_count"],
        createdAt: jsonData["created_at"],
        videos: jsonData['videos'],
        images: jsonData['images'],
        likeCount: jsonData['like_count'],
        likerIds: jsonData['liked_by_ids'],
        commentCount: jsonData['comment_count'],
        retweetCount: jsonData['retweet_count'],
        comments: jsonData['comments'],
      );
    }
  }
}
