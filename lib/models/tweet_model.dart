

import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:flutter/material.dart';
enum TweetImage {
 picture,
 video,
 nothing
}
enum TextExistence {
 exist,
 notExist
}
class Tweet
{
 Tweet({required this.tweetId,required this.userId,required this.profilePicUrl,required this.username, this.title, this.imageType,required this.text, this.textExistence,required this.commentCount,required this.retweetCount,required this.likeCount, this.innerTweet,this.haveInnerTweet,required this.createdAt,required this.videos,required this.images, this.comments, this.likerIds,required this.name,required this.followersCount,required this.followingCount,required this.bio});
 String tweetId;
 String userId;
 String name;
 String username;
 String profilePicUrl;
 String text;
 String bio;
 int followingCount;
 int followersCount;
 //
 TextExistence? textExistence;
 //
 String? title;
 String createdAt;
 //
 TweetImage? imageType;
 //videos content------------------------------------------
  List<dynamic>videos;
 //Images content------------------------------------------
 List<dynamic>images;
 //------------------------------------------
 //likes------------------------------------------
 int likeCount;
 bool? isLiked=false;
 List<dynamic>?likerIds;
 //comments------------------------------------------
 int commentCount;
 List<dynamic>?comments;
 //retweets------------------------------------------
 int retweetCount;
 bool? isRetweeted=false;
//-----------------------------------------------------
 TweetCard? innerTweet;
 bool ?haveInnerTweet=false;

 //reading from json
 factory Tweet.fromJson(Map<String,dynamic> jsonData,bool isAdded)
 {
if(isAdded==true)
 {
  return Tweet(tweetId: jsonData["tweet_id"], userId: jsonData["user_id"], profilePicUrl: jsonData["prof_pic_url"],name:jsonData["name"] , username: jsonData["username"],bio: jsonData["bio"] ,followersCount: jsonData["followers_count"],followingCount: jsonData["following_count"],createdAt: jsonData["created_at"], text: jsonData['text'],videos:jsonData['videos'] ,images:jsonData['images'] ,likeCount:jsonData['like_count'] ,commentCount:jsonData['comment_count'] ,retweetCount:jsonData['retweet_count'] );

 }
else
 {
  return Tweet(tweetId: jsonData["tweet_id"], userId: jsonData["user_id"], profilePicUrl: jsonData["prof_pic_url"],name:jsonData["name"] , username: jsonData["username"],bio: jsonData["bio"] ,followersCount: jsonData["followers_count"],followingCount: jsonData["following_count"],createdAt: jsonData["created_at"], text: jsonData['text'],videos:jsonData['videos'] ,images:jsonData['images'] ,likeCount:jsonData['like_count'] ,likerIds: jsonData['liker_ids'],commentCount:jsonData['comment_count'] ,retweetCount:jsonData['retweet_count'] ,comments: jsonData['comments']);

 }


   }
 }
