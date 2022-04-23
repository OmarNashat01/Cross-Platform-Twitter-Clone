
import 'package:flutter/cupertino.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/dummy/users_data.dart';
import 'dart:math';
class TimelineList extends ChangeNotifier
{

  //these are the tweets that are shown to the user when he is connected to timeline
  static final List<Tweet>_retweetList=
  [
    Tweet(username: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicUrl: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'lovely nature' ,imageUrl:'assets/tweets_images/nature.jpg' ),
    Tweet(username: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicUrl: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'dogs are beautiful' ,imageUrl:'assets/tweets_images/dog.jpeg' ),
    Tweet(username: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicUrl: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"Don't try so hard to fit in, and certainly don't try so hard to be different just try hard to be you.I don't mind if people look at me like I'm crazy. I'm just being me." ,imageUrl:'assets/tweets_images/zendatweet.jpg' ),
    Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"In nature, nothing is perfect and everything is perfect. Trees can be contorted, bent in weird ways, and they're still beautiful." "Those who contemplate the beauty of the earth find reserves of strength that will endure as long as life lasts." ,imageUrl:'assets/tweets_images/heaven.jpg' ),
    Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'nice one' ,imageUrl:'assets/images/waseem.jpg' ),

  ];
   static final List<Tweet>_tweetList=
    [
      Tweet(username: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicUrl: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'lovely nature' ,imageUrl:'assets/tweets_images/nature.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicUrl: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'dogs are beautiful' ,imageUrl:'assets/tweets_images/dog.jpeg' ),
      Tweet(username: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicUrl: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"Don't try so hard to fit in, and certainly don't try so hard to be different just try hard to be you.I don't mind if people look at me like I'm crazy. I'm just being me." ,imageUrl:'assets/tweets_images/zendatweet.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"In nature, nothing is perfect and everything is perfect. Trees can be contorted, bent in weird ways, and they're still beautiful." "Those who contemplate the beauty of the earth find reserves of strength that will endure as long as life lasts." ,imageUrl:'assets/tweets_images/heaven.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'nice one' ,imageUrl:'assets/images/waseem.jpg' ),

    ];
   //these are the tweets that are shown to the user randomly each time refreshing the feed
    static final List<Tweet>randomTweets=
    [
      Tweet(username: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicUrl: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'Ramadan Kareem everyone ' ,imageUrl:'assets/tweets_images/ramadan.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicUrl: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'MoSalah amazing today' ,imageUrl:'assets/tweets_images/mosalah.jpeg' ),
      Tweet(username: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicUrl: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"Good morning every one, have a great day you all." ,imageUrl:'assets/tweets_images/zendayaMorning.png' ),
      Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"In nature, nothing is perfect and everything is perfect. Trees can be contorted, bent in weird ways, and they're still beautiful." "Those who contemplate the beauty of the earth find reserves of strength that will endure as long as life lasts." ,imageUrl:'assets/tweets_images/natureLove.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'wish you all a nice day,i think everyone should start his day with coffee hahahha' ,imageUrl:'assets/tweets_images/morningCoffee.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicUrl: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:'lovely nature' ,imageUrl:'assets/tweets_images/nature.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicUrl: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.nothing, textExistence: TextExistence.exist,text:'hello guys how are you today, i wish you all to have a great day'  ),
      Tweet(username: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicUrl: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"I don't mind if people look at me like I'm crazy. I'm just being me." ,imageUrl:'assets/tweets_images/zendayaLit.jpg' ),
      Tweet(username: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicUrl: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, textExistence: TextExistence.exist,text:"The moon was looking extraordinary last night." ,imageUrl:'assets/tweets_images/moon.jpg' ),

    ];
   //getTweets is for usage of provider as it is not static

      List<Tweet>getTweetsList()
    {
      return _tweetList;
    }
     static int  getTweetsNumbers()
    {
      return _tweetList.length;
    }
      void addTweet(Tweet newTweet)
    {
      _tweetList.insert(0,newTweet);
      notifyListeners();
    }
   void retweet(int index)
   {
     _retweetList.insert(0,_tweetList[index]);
     _tweetList[index].isRetweeted=true;
     _tweetList[index].retweetCount++;
     notifyListeners();
   }
  void undoRetweet(int index)
  {
    _retweetList.remove(_tweetList[index]);
    _tweetList[index].isRetweeted=false;
    _tweetList[index].retweetCount--;
    notifyListeners();
  }
   Future <void> addRandomTweetOnRefresh() async
   {
     await Future.delayed(const Duration(milliseconds: 500));
     final _random = new Random();
     Tweet randomTweet = randomTweets[_random.nextInt(randomTweets.length)];
     addTweet(randomTweet);
   }
   ///////////////////////////////////////////
   void reactLove(bool liked,int index)
   {
     if(liked==true)
     {
       getTweetsList()[index].likeCount++;
       getTweetsList()[index].isLiked=true;
     }
     else
     {
       getTweetsList()[index].likeCount--;
       getTweetsList()[index]. isLiked=false;
     }
     notifyListeners();
   }

}