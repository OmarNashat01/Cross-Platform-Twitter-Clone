import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:twitter/dummy/tweets_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/models/tweet_card_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';

//TweetCard class is the widget responsible for rendering the tweet card at the timeline and any needed place
//the tweet need information to be rendered
//this information will come from class which is TweetCardData
class TweetCard extends StatelessWidget {
  TweetCard({required this.index});
  final int index;
  @override

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26,right: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //--here is the profile picture of the one who tweeted
                  ProfilePicture(
                      profilePictureFunctionality: () {},
                      profilePictureImage:
                      TweetsList.getTweetsList()[index].profilePicture,
                      profilePictureSize: navigationDrawerProfilePicSize),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //here is the name and title of the one who tweeted
                        Text( TweetsList.getTweetsList()[index].name,
                            style: boldName),
                        Text(TweetsList.getTweetsList()[index].title,
                            style: titleName),
                      ],
                    ),
                  ),
                ],
              ),

              //--for decoration sized box
              SizedBox(height: 5,),
              //--here is the text of the tweet
              TweetsList.getTweetsList()[index].existence == TextExistence.exist
                  ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          TweetsList.getTweetsList()[index].text!,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                            //max lines of writing a tweet is 8 like in the main twitter
                            maxLines: 8,
                            style: tweetsTexts,
                          ),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
             //--for decoration sized box
             SizedBox(height: 5,),
        //--here is the image of the tweet
        TweetsList.getTweetsList()[index].imageType == TweetImage.picture
            ? Image.asset(
          TweetsList.getTweetsList()[index].imageURL!,
          fit: BoxFit.cover,
          width: double.infinity,
          alignment: Alignment.center,
              )
            : const SizedBox.shrink(),

        //the row of icons for your reactions on the tweet
        Padding(
          padding: const EdgeInsets.only(left: 26,right: 26),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //comment button on tweet
              GestureDetector(
                onTap: ()
                {

                },
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.comment,
                      size: 18,
                    ),
                    SizedBox(width: 10,),
                    TweetsList.getTweetsList()[index].nComments>0?Text( TweetsList.getTweetsList()[index].nComments.toString(),style: titleName,):const SizedBox.shrink()
                  ],
                ),

              ),
              //retweet button on tweet
              GestureDetector(
                onTap: ()
                {

                },
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.retweet,
                      size: 18,
                    ),
                    SizedBox(width: 10,),
                    TweetsList.getTweetsList()[index].nRetweets>0?Text(  TweetsList.getTweetsList()[index].nRetweets.toString(),style: titleName,):const SizedBox.shrink()
                  ],
                ),
              ),

              //--this is functionality of the love button on the tweets
              Row(
                children:[
                   LikeButton(
                    isLiked:  TweetsList.getTweetsList()[index].isLiked,
                     likeCount:  TweetsList.getTweetsList()[index].nLove,
                     likeBuilder: (isLiked)
                     {
                       final color=isLiked?Colors.red:Colors.grey.shade500;
                       return(Icon(Icons.favorite,color:color));
                     },
                     countBuilder: (count,isLiked,text)
                       {
                         final color=isLiked?Colors.black:Colors.grey;
                         return TweetsList.getTweetsList()[index].nLove>0?Text( text,style: titleName,):const SizedBox.shrink();

                       },
                     onTap: (isLiked)async
                       {
                         return !isLiked;
                       },
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              //--share tweet
              GestureDetector(
                onTap: ()
                {

                },
                child: const Icon(
                  FontAwesomeIcons.arrowUpFromBracket,
                  size: 18,
                ),
              ),

              //-----------------------------------------------------------------

            ],
          ),
        ),


        //decoration of tweet at the bottom (divider)
        const SizedBox(
          height: 8,
        ),
        //decoration of tweet at the bottom (divider)
        const Divider(
          thickness: 1.5,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
