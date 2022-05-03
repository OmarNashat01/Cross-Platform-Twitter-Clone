import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/stream_controller_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/add_tweet_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/quote_tweet_card.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:twitter/services/tweets_service.dart';
import '../../providers/tweets_view_model.dart';
import '../../providers/user_provider.dart';
import 'timeline_components/custom_page_route.dart';
import 'timeline_components/profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'timeline_components/navigation_drawer.dart';
import 'package:twitter/models/tweet_model.dart';

// ignore_for_file: prefer_const_constructors
class TimelineScreen extends StatefulWidget {
  static const routeName = '/timeline-screen';

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  ScrollController ?controller;
  final StreamController _streamController=StreamController();
  Stream ?_stream;
  // fetchingStreamController(String user_id)async
  // {
  //   Provider.of<TweetsViewModel>(context,listen: false).fetchTweets(user_id);
  //   _streamController=Provider.of<TweetsViewModel>(context,listen: false).getStreamController();
  //   _stream=_streamController.stream;
  // }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=ScrollController();
    Provider.of<TweetsViewModel>(context,listen: false).fetchMyTweets(context,0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // await Provider.of<TweetsViewModel>(context,listen: false).addTweet();
          // Provider.of<StreamControllerProvider>(context,listen: false).updateTweetStream(context);
          Navigator.of(context).push(
            CustomPageRoute
            (child:AddTweetScreen(hintText: "What's happening?",tweetOrReply: "Tweet"),beginX: 0,beginY: 1),
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
                      curve: Curves.easeIn, duration: Duration(milliseconds: 200));
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
        body: StreamBuilder(
            stream: Provider.of<StreamControllerProvider>(context).addStreamController(_streamController,0).stream,
            builder: (BuildContext context,AsyncSnapshot snapshot,)
            {

              switch(snapshot.connectionState)
              {
                case ConnectionState.none:
                  return Text('press button to start');
                case ConnectionState.waiting:
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(
                        value: 0.8,
                      )
                  );
                default:
                  if(snapshot.hasError)
                  {
                    return Text('error');
                  }

                  else
                  {
                    return Scrollbar(
                      radius: Radius.circular(30),
                      isAlwaysShown: true,
                      child: RefreshIndicator(
                        color: Colors.grey,
                        onRefresh: () {
                          return Provider.of<TweetsViewModel>(context, listen: false).fetchRandomTweetsOfRandomUsers(context,2,0);
                        },
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index){
                            //print(snapshot.data.length);
                            return TweetCard(index: index,tweet: snapshot.data[index],);
                          },
                          itemCount:snapshot.data.length,
                        ),
                      ),
                    );
                  }
              }

            }
        ),

         ),
        ),

      //------------------------------------------------------------------------
      //bottom appbar where each icon has its own function
      bottomNavigationBar: TimelineBottomBar(controller: controller!,pop: false,),
    );
  }
}
// StreamBuilder(
// stream: Provider.of<TweetsViewModel>(context,listen: true).fetchTweets()as Stream,
//     builder: (BuildContext context,AsyncSnapshot snapshot,)
// {
//
// switch(snapshot.connectionState)
// {
// case ConnectionState.none:
// return Text('press button to start');
// case ConnectionState.waiting:
// return Text("waiting");
// default:
// if(snapshot.hasError)
// {
// return Text('error');
// }
// else
// {
// return Scrollbar(
// radius: Radius.circular(30),
// isAlwaysShown: true,
// child: RefreshIndicator(
// color: Colors.grey,
// onRefresh: ()async=>Provider.of<TweetsViewModel>(context,listen: false).fetchTweets(),
// child: ListView.builder(
// physics: const BouncingScrollPhysics(),
// itemBuilder: (context, index){
// return TweetCard(index: index,tweet: snapshot.data[index],);
// },
// itemCount:snapshot.data.length,
// ),
// ),
// );
// }
// }
//
// }
// ),
