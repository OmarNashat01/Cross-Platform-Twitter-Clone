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

class TweetBottomBar extends StatelessWidget {
   TweetBottomBar({
    Key? key,
    required this.index,
    required this.iconsBoundry,
  }) : super(key: key);

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
            onTap: () {},
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
                Provider.of<TweetsViewModel>(context).getTweetsList()[index].getCommentCount() >
                        0
                    ? Text(
                  Provider.of<TweetsViewModel>(context).getTweetsList()[index].getCommentCount()
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
                Provider.of<TweetsViewModel>(context).getTweetsList()[index].getRetweetCount()>
                        0
                    ? Text(
                  Provider.of<TweetsViewModel>(context).getTweetsList()[index].getRetweetCount()
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

                isLiked:Provider.of<TweetsViewModel>(context)
                    .getTweetsList()[index]
                    .tweet.isLiked,
                likeCount: Provider.of<TweetsViewModel>(context).getStreamController()[index],
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
                  return Provider.of<TweetsViewModel>(context,listen: false).getTweetsList()[index].getLikesCount()> 0 ? Text(text, style: isLiked?loved:titleName,) : const SizedBox.shrink();
                },
                onTap: (isLiked) async {
                  Provider.of<TweetsViewModel>(context,listen: false).likeTweet(tweet_id: Provider.of<TweetsViewModel>(context,listen: false).getTweetsList()[index].tweet.tweetId);
                  Provider.of<StreamControllerProvider>(context,listen: false).updateTweetStream(context,"126");
                print(Provider.of<TweetsViewModel>(context,listen: false).getTweetsList()[index].tweet.tweetId);
                   Provider.of<TweetsViewModel>(context, listen: false).getTweetsList()[index].tweet.isLiked=!isLiked;
                  return !isLiked;
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
