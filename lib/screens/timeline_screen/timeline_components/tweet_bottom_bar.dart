import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/retweet_screen.dart';

import '../../../constants.dart';
import '../../../dummy/timeline_list.dart';
import '../../../models/tweet_complete_model.dart';
import '../../../providers/stream_controller_provider.dart';
import '../../../providers/tweets_view_model.dart';
import 'add_tweet_screen.dart';
import 'custom_page_route.dart';

class TweetBottomBar extends StatelessWidget {
   TweetBottomBar({
    Key? key,
    required this.index,
    required this.iconsBoundry,
     required this.tweet,
  }) : super(key: key);
   TweetMain tweet;
   int index;
   Color iconsBoundry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //comment button on tweet
          GestureDetector(
            onTap: () {
              ///i should get here the id of this tweet to insert the reply to this specific tweet
              Navigator.of(context).push(
                CustomPageRoute
                  (child:AddTweetScreen(hintText: "Tweet your reply",tweetOrReply: "Reply",replying:true,name:tweet.tweet.username),beginX: 0,beginY: 1),
              );
            },
            child: Row(
              children: [
                 Icon(
                  FontAwesomeIcons.comment,
                  color: iconsBoundry,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                tweet.getCommentCount() >
                        0
                    ? Text(
                  tweet.getCommentCount()
                            .toString(),
                        style: titleName,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          //retweet button on tweet
          GestureDetector(
            onTap: () {
              // Provider.of<TweetsViewModel>(context,listen: false).getTweetsList()[index].isRetweeted==false?showModalBottomSheet(context: context, builder: (context)=>RetweetScreen(index: index,doOrUndo: 'do',),)
              // :showModalBottomSheet(context: context, builder: (context)=>RetweetScreen(index: index,doOrUndo: 'undo',),);
              },
            child: Row(
              children: [
                 Icon(
                  FontAwesomeIcons.retweet,
                  // color: Provider.of<TweetsViewModel>(context).getTweetsList()[index].isRetweeted==false?iconsBoundry:Colors.green,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                tweet.getRetweetCount()>
                        0
                    ? Text(
                 tweet.getRetweetCount()
                            .toString(),
                        //style:Provider.of<TweetsViewModel>(context).getTweetsList()[index].isRetweeted==false?notRetweeted:retweeted,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),

          //--this is functionality of the love button on the tweets
          Row(
            children: [
              LikeButton(

                isLiked:tweet.tweet.isLiked,
                likeCount: tweet.tweet.likeCount,
                likeBuilder: (isLiked) {
                  final color = isLiked ? Colors.red : Colors.transparent;
                  return Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: color,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.heart,
                          color: isLiked ? Colors.red : iconsBoundry,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
                countBuilder: (count, isLiked, text) {
                  return tweet.getLikesCount()> 0 ? Text(text, style: isLiked?loved:titleName,) : const SizedBox.shrink();
                },
                onTap: (isLiked) async {
                  tweet.tweet.isLiked=!isLiked;
                  print("tweet id is : ${tweet.tweet.tweetId}");
                  print("is liked of this tweet is : ${tweet.tweet.isLiked}");

                  //await Provider.of<TweetsViewModel>(context,listen: false).likeTweet(tweetId: tweet.tweet.tweetId);
                  await Provider.of<StreamControllerProvider>(context,listen: false).removeTweetFromStreamControllerThenFetchToUpdateUI(index, tweet.tweet.tweetId, context);

                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          //--share tweet
          GestureDetector(
            onTap: () {},
            child:  Icon(
              FontAwesomeIcons.arrowUpFromBracket,
              color: iconsBoundry,
              size: 18,
            ),
          ),

          //-----------------------------------------------------------------
        ],
      ),
    );
  }
}
