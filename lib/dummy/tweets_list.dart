
import 'package:flutter/cupertino.dart';
import 'package:twitter/models/tweet_card_data.dart';
import 'package:twitter/dummy/users_data.dart';
import 'dart:math';
class TweetsList extends ChangeNotifier
{

  //these are the tweets that are shown to the user when he is connected to timeline
   static final List<TweetCardData>_tweetsList=
    [
      TweetCardData(name: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicture: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'lovely nature' ,imageURL:'assets/tweets_images/nature.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicture: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'dogs are beautiful' ,imageURL:'assets/tweets_images/dog.jpeg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicture: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"Don't try so hard to fit in, and certainly don't try so hard to be different just try hard to be you.I don't mind if people look at me like I'm crazy. I'm just being me." ,imageURL:'assets/tweets_images/zendatweet.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"In nature, nothing is perfect and everything is perfect. Trees can be contorted, bent in weird ways, and they're still beautiful." "Those who contemplate the beauty of the earth find reserves of strength that will endure as long as life lasts." ,imageURL:'assets/tweets_images/heaven.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'nice one' ,imageURL:'assets/images/waseem.jpg' ),

    ];
   //these are the tweets that are shown to the user randomly each time refreshing the feed
    static final List<TweetCardData>randomTweets=
    [
      TweetCardData(name: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicture: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'Ramadan Kareem everyone ' ,imageURL:'assets/tweets_images/ramadan.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicture: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'MoSalah amazing today' ,imageURL:'assets/tweets_images/mosalah.jpeg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicture: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"Good morning every one, have a great day you all." ,imageURL:'assets/tweets_images/zendayaMorning.png' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"In nature, nothing is perfect and everything is perfect. Trees can be contorted, bent in weird ways, and they're still beautiful." "Those who contemplate the beauty of the earth find reserves of strength that will endure as long as life lasts." ,imageURL:'assets/tweets_images/natureLove.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'wish you all a nice day,i think everyone should start his day with coffee hahahha' ,imageURL:'assets/tweets_images/morningCoffee.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicture: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'lovely nature' ,imageURL:'assets/tweets_images/nature.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicture: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.nothing, existence: TextExistence.exist,text:'hello guys how are you today, i wish you all to have a great day'  ),
      TweetCardData(name: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicture: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"I don't mind if people look at me like I'm crazy. I'm just being me." ,imageURL:'assets/tweets_images/zendayaLit.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"The moon was looking extraordinary last night." ,imageURL:'assets/tweets_images/moon.jpg' ),

    ];
   //getTweets is for usage of provider as it is not static

      List<TweetCardData>getTweetsList()
    {
      return _tweetsList;
    }
     static int  getTweetsNumbers()
    {
      return _tweetsList.length;
    }
      void addTweet(TweetCardData newTweet)
    {
      _tweetsList.insert(0,newTweet);
      notifyListeners();
    }
   Future <void> addRandomTweetOnRefresh() async
   {
     await Future.delayed(const Duration(milliseconds: 500));
     final _random = new Random();
     TweetCardData randomTweet = randomTweets[_random.nextInt(randomTweets.length)];
     addTweet(randomTweet);
   }
   ///////////////////////////////////////////
   void reactLove(bool liked,int index)
   {
     if(liked==true)
     {
       getTweetsList()[index].nLove++;
       getTweetsList()[index].isLiked=true;
     }
     else
     {
       getTweetsList()[index].nLove--;
       getTweetsList()[index]. isLiked=false;
     }
     notifyListeners();
   }

}