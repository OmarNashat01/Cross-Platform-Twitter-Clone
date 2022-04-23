

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
 Tweet({required this.tweetId,required this.userId,required this.profilePicUrl,required this.username,required this.title,required this.imageUrl, this.imageType,required this.text, this.textExistence,this.commentCount=0,this.retweetCount=0,this.likeCount=0, this.innerTweet,this.haveInnerTweet,required this.createdAt, required this.imageAltText,required this.imageHeight,required this.imageWidth,required this.videoAltText,required this.videoHeight,required this.videoUrl,required this.videoWidth});
 String tweetId;
 String userId;
 String username;
 String profilePicUrl;
 String text;
 //
 TextExistence? textExistence;
 //
 String title;
 String createdAt;
 //
 TweetImage? imageType;
 //videos content------------------------------------------
 String videoUrl;
 String videoAltText;
 String videoHeight;
 String videoWidth;
 //List<String>videos;
 //Images content------------------------------------------
 String imageUrl;
 String imageAltText;
 String imageHeight;
 String imageWidth;
 //List<String>images;
 //------------------------------------------
 //likes------------------------------------------
 int likeCount;
 bool? isLiked=false;
 //List<String>likerIds;
 //comments------------------------------------------
 int commentCount;
 //List<String>comments;
 //retweets------------------------------------------
 int retweetCount;
 bool? isRetweeted=false;
//-----------------------------------------------------
 TweetCard? innerTweet;
 bool ?haveInnerTweet=false;

 //reading from json
 factory Tweet.fromJson(Map<String,dynamic> jsonData)
 {

  return Tweet(tweetId: jsonData["tweet_id"], userId: jsonData["user_id"], profilePicUrl: jsonData["prof_pic_url"], username: jsonData["username"], title: jsonData["username"], imageUrl: jsonData["assets/tweets_images/moon.jpg"], createdAt: jsonData["created_at"], imageAltText: jsonData["alt_text"], imageHeight: jsonData["height"], imageWidth: jsonData["width"], videoAltText: jsonData["alt_text"], videoHeight: jsonData["height"], videoUrl: jsonData["url"], videoWidth: jsonData["width"], text: jsonData['text']);
 }
}