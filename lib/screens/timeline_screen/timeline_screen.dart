// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/list_view_tweet_provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/providers/ui_colors_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/add_tweet_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/quote_tweet_card.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:twitter/services/tweets_service.dart';
import 'package:video_player/video_player.dart';
import '../../providers/tweets_view_model.dart';
import '../../providers/user_provider.dart';
import 'timeline_components/custom_page_route.dart';
import 'timeline_components/profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'timeline_components/navigation_drawer.dart';
import 'package:visibility_detector/visibility_detector.dart';
// ignore_for_file: prefer_const_constructors
class TimelineScreen extends StatefulWidget {
  TimelineScreen({required this.firstTime});
  static const routeName = '/timeline-screen';
  bool firstTime=true;
  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  ScrollController? controller;
  dynamic videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    if(widget.firstTime==true) {
      Provider.of<TweetsViewModel>(context, listen: false).fetchRandomTweetsOfRandomUsers(
          context,Provider.of<TweetsViewModel>(context,listen: false).pageNumber);
      // Provider.of<TweetsViewModel>(context, listen: false).fetchMyTweets(
      //     context);
    }
    super.initState();
    controller = ScrollController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CustomPageRoute(
                child: AddTweetScreen(
                    hintText: "What's happening?", tweetOrReply: "tweet"),
                beginX: 0,
                beginY: 1),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
      drawer:
          NavigationDrawer(), //to open profile content when user press the profile picture in the timeline appbar
      backgroundColor: Colors.white,
      //here i make twitter own app bar which appears and disappears depending on user scrolling
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
              automaticallyImplyLeading: false,
              title: TextButton(
                onPressed: () {
                  //this makes when i press on the bar it goes to the first tweet in timeline
                  controller?.animateTo(0.0,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 200));
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //profile picture in timeline appbar
                    ProfilePicture(
                      profilePictureFunctionality: () {
                        Scaffold.of(context).openDrawer();
                      },
                      profilePictureImage: Auth.profilePicUrl,
                      profilePictureSize: timelineProfilePicSize,
                    ),
                    //twitter icon in the appbar
                    SvgPicture.asset(
                      kLogoPath,
                      width: 20,
                      height: 20,
                      color: Colors.lightBlue,
                    ),
                    //sparkle icon in the appbar
                    GestureDetector(
                      onTap: () {},
                      child: FaIcon(
                        Icons.star_outline_sharp,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
          //--------------------------------------------------------------------
          //tweets list viewer
                       body:  Scrollbar(
                        radius: Radius.circular(30),
                        thumbVisibility: true,
                        child: RefreshIndicator(
                          color: Colors.grey,
                          onRefresh: () {
                            return Provider.of<TweetsViewModel>(context, listen: false).fetchMyTweets(context);
                          },
                          child: ListView.custom(

                            physics: const BouncingScrollPhysics(),
                            childrenDelegate:SliverChildBuilderDelegate ((context, index) {
                              print(Provider.of<TimelineProvider>(context).timelineList.length);
                              if(index==Provider.of<TimelineProvider>(context,listen: false).timelineList.length-1)
                                {
                                   Provider.of<TweetsViewModel>(context, listen: false).fetchRandomTweetsOfRandomUsers(context,Provider.of<TweetsViewModel>(context).pageNumber);
                                   return Center(child: Container(width:20,height:20,child: CircularProgressIndicator(color: Colors.grey,strokeWidth:2,)));
                                }
                                return TweetCard(
                                  realUserId: "",
                                  isTweetInner: false,
                                  userId: "",
                                  shiftTweets: false,
                                  tweetPage:false,
                                  index: index,
                                  tweet: Provider.of<TimelineProvider>(context).timelineList[index],
                                );

                            },
                            childCount: Provider.of<TimelineProvider>(context).timelineList.length,
                                findChildIndexCallback: (Key key) {
                                  final ValueKey  valueKey = key as ValueKey ;
                                  final String data = valueKey.value;
                                  return Provider.of<TimelineProvider>(context).timelineList.indexOf(data);
                                }
                          ),
                          ),
                        ),
                      ),

        ),
      ),

      //------------------------------------------------------------------------
      //bottom appbar where each icon has its own function
      bottomNavigationBar: TimelineBottomBar(
        contextt: context,
        controller: controller!,
        popTimeLine: false,
        popSearch: true,
        popNotifications: true,
      ),
    );
  }
}
