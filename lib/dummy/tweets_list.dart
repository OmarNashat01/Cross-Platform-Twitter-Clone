
import 'package:twitter/models/tweet_card_data.dart';
import 'package:twitter/dummy/users_data.dart';
class TweetsList
{

 static final List<TweetCardData>_tweetsList=
    [
      TweetCardData(name: UsersData.getOtherUsersData()[0].name, title: UsersData.getOtherUsersData()[0].title, profilePicture: UsersData.getOtherUsersData()[0].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'lovely nature' ,imageURL:'assets/tweets_images/nature.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[2].name, title: UsersData.getOtherUsersData()[2].title, profilePicture: UsersData.getOtherUsersData()[2].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'dogs are beautiful' ,imageURL:'assets/tweets_images/dog.jpeg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[1].name, title: UsersData.getOtherUsersData()[1].title, profilePicture: UsersData.getOtherUsersData()[1].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"Don't try so hard to fit in, and certainly don't try so hard to be different just try hard to be you.I don't mind if people look at me like I'm crazy. I'm just being me." ,imageURL:'assets/tweets_images/zendatweet.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:"In nature, nothing is perfect and everything is perfect. Trees can be contorted, bent in weird ways, and they're still beautiful." "Those who contemplate the beauty of the earth find reserves of strength that will endure as long as life lasts." ,imageURL:'assets/tweets_images/heaven.jpg' ),
      TweetCardData(name: UsersData.getOtherUsersData()[3].name, title: UsersData.getOtherUsersData()[3].title, profilePicture: UsersData.getOtherUsersData()[3].profilePicture, imageType: TweetImage.picture, existence: TextExistence.exist,text:'nice one' ,imageURL:'assets/images/waseem.jpg' ),

    ];

    static List<TweetCardData>getTweetsList()
    {
      return _tweetsList;
    }
    static int getTweetsNumbers()
    {
      return _tweetsList.length;
    }
    void addTweet(TweetCardData newTweet)
    {
      _tweetsList.add(newTweet);
    }
}