// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/comments_provider.dart';
import 'package:twitter/providers/list_view_tweet_provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/providers/ui_colors_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/add_tweet_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/quote_tweet_card.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:twitter/services/tweets_service.dart';
import 'package:video_player/video_player.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../providers/tweets_view_model.dart';

// ignore_for_file: prefer_const_constructors
class TweetPage extends StatefulWidget {
  TweetPage(
      {required this.tweetCard,
      required this.tweet,
      required this.shiftTweets,
      required this.userId,
        required this.realUserId,
      });
  String realUserId;
  TweetMain tweet;
  TweetCard tweetCard;
  bool shiftTweets = false;
  String userId;
  @override
  State<TweetPage> createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  ScrollController controller = ScrollController();
  dynamic tweetsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CommentsProvider>(context, listen: false).commentsList = [];
    if (widget.tweet.comments != []) {
      for (int i = 0; i < widget.tweet.comments.length; i++) {
        Provider.of<TweetsViewModel>(context, listen: false)
            .fetchTweetByTweetIdForTweetComments(
                context, widget.tweet.comments[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: controller,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              //floating is true to make twitter app bar to appear when scroll up,
              floating: true,
              snap: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              forceElevated: innerBoxIsScrolled,
              shadowColor: Colors.white,
              title: TextButton(
                onPressed: () {
                  //this makes when i press on the bar it goes to the first tweet in timeline
                  controller.animateTo(0.0,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 200));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Center(
                    child: Text(
                      "Tweet",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 19),
                    ),
                  ),
                ),
              ),
            ),
          ],
          //--------------------------------------------------------------------
          //tweets list viewer
          body: Scrollbar(
            radius: Radius.circular(30),
            thumbVisibility: true,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                widget.tweetCard,
                ListView.custom(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  cacheExtent: 1000,
                  physics: const BouncingScrollPhysics(),
                  childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) {

                        return TweetCard(
                          isTweetInner: false,
                          realUserId: widget.userId,
                          userId: widget.userId,
                          shiftTweets: true,
                          index: index,
                          tweet: Provider.of<CommentsProvider>(context)
                              .commentsList[index],
                          videoPlayerController:
                              widget.tweetCard.videoPlayerController,
                          tweetPage: false,
                        );
                      },
                      childCount: Provider.of<CommentsProvider>(context)
                          .commentsList
                          .length,
                      findChildIndexCallback: (Key key) {
                        final ValueKey valueKey = key as ValueKey;
                        final String data = valueKey.value;
                        return Provider.of<CommentsProvider>(context,
                                listen: false)
                            .commentsList
                            .indexOf(data);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),

      //------------------------------------------------------------------------
      //bottom appbar where each icon has its own function
      bottomNavigationBar: TimelineBottomBar(
        contextt: context,
        controller: controller,
        popTimeLine: true,
        popSearch: true,
        popNotifications: true,
      ),
    );
  }
}
