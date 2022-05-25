import 'dart:ui';

import 'package:twitter/models/tweet_model.dart';
class TweetMain
{
  TweetMain({required this.outerTweet, required this.comments,required this.images,required this.videos, required this.likers,this.innerTweet});
  Tweet outerTweet;
  Tweet?innerTweet;
  List<dynamic>comments;
  List<dynamic>likers;
  List<dynamic>images;
  List<dynamic>videos;
  Color threeDotsColor=const Color(0xffAFD9F4);

  //tweet info getters------------------------------------
  //get tweet id
  String getTweetId()
  {
    return outerTweet.tweetId;
  }
  //get user id of user who made the tweet
  String getuserId()
  {
    return outerTweet.userId;
  }
  //get name of user who made the tweet
  //get username of user who made the tweet
  String getusername()
  {
    return outerTweet.username;
  }
  //get profilePicUrl of user who made the tweet
  String getTweetprofilePicUrl()
  {
    return outerTweet.profilePicUrl;
  }
  //get text  tweet
  // String getTweettext()
  // {
  //   return outerTweet.text;
  // }
  //get bio of user who made the tweet
  // String? getTweetbio()
  // {
  //   return outerTweet.bio;
  // }
  //get followingCount of user who made the tweet

  //comments getters-------------------------------------
  int getCommentCount()
{
  return outerTweet.commentCount;
}
  int getRetweetCount()
  {
    return outerTweet.retweetCount;
  }
  int getLikesCount()
  {
    return outerTweet.likeCount;
  }
}