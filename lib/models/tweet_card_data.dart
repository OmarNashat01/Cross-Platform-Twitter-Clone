

import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';

enum TweetImage {
 picture,
 video,
 nothing
}
enum TextExistence {
 exist,
 notExist
}
class TweetCardData
{
 TweetCardData({required this.name,required this.title,required this.profilePicture,this.imageURL,required this.imageType,this.text,required this.existence,this.nComments=0,this.nRetweets=0,this.nLove=0, this.innerTweet,this.haveInnerTweet});
 String name;
 String title;
 String profilePicture;
 //------------------------------------------
 String? text;
 TextExistence existence;
 //------------------------------------------
 String? imageURL;
 TweetImage imageType;
 //------------------------------------------
int nComments;
int nRetweets;
int nLove;
bool isLiked=false;
bool isRetweeted=false;
TweetCard? innerTweet;
bool ?haveInnerTweet=false;
}