import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/retweet_screen.dart';

import '../../../constants.dart';
import '../../../models/tweet_complete_model.dart';
import 'add_tweet_screen.dart';
import 'custom_page_route.dart';

class TweetBottomBar extends StatefulWidget {
  TweetMain tweet;
  int index;
  Color iconsBoundry;
   Function ?likeInfoCallBack;
  TweetBottomBar({
    Key? key,
    required this.index,
    required this.iconsBoundry,
    required this.tweet,
     this.likeInfoCallBack
  }) : super(key: key);

  @override
  State<TweetBottomBar> createState() => _TweetBottomBarState();
}

class _TweetBottomBarState extends State<TweetBottomBar> {
  dynamic liked;

  @override

  dynamic likeCount;

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
                CustomPageRoute(
                    child: AddTweetScreen(
                        hintText: "Tweet your reply",
                        tweetOrReply: "reply",
                        replying: true,
                        tweet: widget.tweet,
                        name: widget.tweet.outerTweet.username),
                    beginX: 0,
                    beginY: 1),
              );
            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.comment,
                  color: widget.iconsBoundry,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.tweet.getCommentCount() > 0
                    ? Text(
                        widget.tweet.getCommentCount().toString(),
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
              showModalBottomSheet(context: context, builder: (context)=>RetweetScreen(tweet:widget.tweet,index: widget.index,doOrUndo: 'do',),);
            },
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.retweet,
                  color: widget.iconsBoundry,
                  // color: Provider.of<TweetsViewModel>(context).getTweetsList()[index].isRetweeted==false?iconsBoundry:Colors.green,
                  size: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.tweet.getRetweetCount() > 0
                    ? Text(
                        widget.tweet.getRetweetCount().toString(),
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
                isLiked: widget.tweet.outerTweet.isLiked,
                likeCount:widget.tweet.outerTweet.likeCount,
                likeBuilder: (isLiked) {
                  final color = isLiked ? Colors.red : Colors.transparent;
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: color,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.heart,
                          color: isLiked ? Colors.red :widget.iconsBoundry,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
                countBuilder: (count, isLiked, text) {
                  return count! > 0
                      ? Text(
                          text,
                          style: isLiked? loved : titleName,
                        )
                      : const SizedBox.shrink();
                },
                onTap: (isLiked) async {

                  await Provider.of<TweetsViewModel>(context,listen: false).likeUnlike(widget.tweet.outerTweet.tweetId,widget.tweet);
                  dynamic tweeta=await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetId(widget.tweet.outerTweet.tweetId);
                    Provider.of<TimelineProvider>(context,listen: false).updateLikeInfoOfTweet(widget.index,tweeta[0].outerTweet.likeCount,widget.tweet.outerTweet.isLiked);
                    setState(() {
                    widget.tweet.outerTweet.likeCount=tweeta[0].outerTweet.likeCount;
                    widget.tweet.outerTweet.isLiked=widget.tweet.outerTweet.isLiked;
                    widget.likeInfoCallBack!(widget.tweet.outerTweet.isLiked,widget.tweet.outerTweet.likeCount,);
                    });

                    // isLiked==true?isLiked=false:isLiked=true;
                },
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          //--share tweet
          GestureDetector(
            onTap: () {},
            child: Icon(
              FontAwesomeIcons.arrowUpFromBracket,
              color:
              widget.iconsBoundry,
              size: 18,
            ),
          ),

          //-----------------------------------------------------------------
        ],
      ),
    );
  }
}
