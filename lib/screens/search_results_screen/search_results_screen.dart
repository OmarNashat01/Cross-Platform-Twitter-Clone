import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/search_tweet_model.dart';
import 'package:twitter/models/search_tweets_model.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/search_tweets_provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/screens/settings_screen/settings_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/add_tweet_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/custom_page_route.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import '../../providers/comments_provider.dart';
import '../../themes.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import '../timeline_screen/timeline_components/navigation_drawer.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

import '../timeline_screen/timeline_components/tweet_card.dart';

class SearchResultsScreen extends StatefulWidget {
  static const routeName = '/search-results-screen';

  @override
  State<StatefulWidget> createState() {
    return SearchResultsScreen_state();
  }
}

class SearchResultsScreen_state extends State<SearchResultsScreen> {
  final _searchQueryController = TextEditingController();
  final controller = ScrollController();

  late Future<List<SearchTweet>> tweets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        centerTitle: true,
      ),
      bottomNavigationBar: TimelineBottomBar(
        contextt: context,
        controller: controller,
        popTimeLine: true,
        popSearch: false,
        popNotifications: true,
      ),
      drawer: NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CustomPageRoute(
              child: AddTweetScreen(
                  hintText: "What's happening?", tweetOrReply: "tweet"),
              beginX: 0,
              beginY: 1,
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<SearchTweetsProvider>(context, listen: false)
            .searchAllTweets(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null)
            return Center(child: Text('No results found'));
          log('${snapshot.data[0].text}');

          return Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                SearchTweet searchTweet = snapshot.data[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TweetCard(
                    realUserId: "",
                    userId: searchTweet.userId,
                    shiftTweets: false,
                    tweetPage: false,
                    index: index,
                    tweet: TweetMain(
                      outerTweet: Tweet(
                        commentCount: searchTweet.commentCount,
                        comments: searchTweet.comments,
                        createdAt: searchTweet.createdAt,
                        followersCount: searchTweet.followersCount,
                        followingCount: searchTweet.followingCount,
                        images: searchTweet.images ?? [],
                        likeCount: searchTweet.likeCount,
                        likerIds: searchTweet.likedByIds,
                        name: searchTweet.name,
                        profilePicUrl: searchTweet.profilePicUrl,
                        retweetCount: searchTweet.retweetCount,
                        text: searchTweet.text,
                        tweetId: searchTweet.tweetId,
                        userId: searchTweet.userId,
                        username: searchTweet.userName ?? '',
                        videos: searchTweet.videos ?? [],
                      ),
                      comments: searchTweet.comments,
                      images: searchTweet.images ?? [],
                      likers: searchTweet.likedByIds,
                      videos: searchTweet.videos ?? [],
                    ),
                  ),
                );

                // Card(
                //   child: ListTile(
                //     // leading: ,
                //     title: Text(snapshot.data[index].name),
                //     subtitle: Text(snapshot.data[index].text),
                //     isThreeLine: true,
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
    // SafeArea(
    //   child: NestedScrollView(
    //     body: Text(''),
    //     controller: controller,
    //     floatHeaderSlivers: true,
    //     headerSliverBuilder: (context, innerBoxIsScrolled) => [
    //       SliverAppBar(
    //         floating: true,
    //         pinned: true,
    //         centerTitle: true,
    //         backgroundColor: Colors.white,
    //         forceElevated: innerBoxIsScrolled,
    //         shadowColor: Colors.white,
    //         automaticallyImplyLeading: false,
    //         title: TextButton(
    //           onPressed: () {
    //             Navigator.pushNamed(context, TimelineScreen.routeName);
    //           },
    //           style: ButtonStyle(
    //             overlayColor: MaterialStateColor.resolveWith(
    //               (states) => Colors.transparent,
    //             ),
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               ProfilePicture(
    //                 profilePictureFunctionality: () {
    //                   Scaffold.of(context).openDrawer();
    //                 },
    //                 profilePictureImage: Auth.profilePicUrl.isEmpty
    //                     ? kDefaultPictureUrl
    //                     : Auth.profilePicUrl,
    //                 profilePictureSize: 15,
    //               ),
    //               //twitter icon in the appbar
    //               const Text(
    //                 'Search',
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 20,
    //                   color: kOnPrimaryColor,
    //                 ),
    //               ),
    //               IconButton(
    //                 onPressed: () {
    //                   Navigator.of(context)
    //                       .pushNamed(SettingsScreen.routeName);
    //                 },
    //                 icon: const Icon(
    //                   Icons.settings,
    //                   color: Colors.grey,
    //                 ),
    //               ),
    //               //sparkle icon in the appbar
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),

    // the tab bar with two items
    // SizedBox(
    //   height: 50,
    //   child: AppBar(
    //     bottom: const TabBar(
    //       labelColor: kOnPrimaryColor,
    //       tabs: [
    //         Tab(
    //           text: 'Trending',
    //         ),
    //         Tab(
    //           text: 'News',
    //         ),
    //       ],
    //     ),
    //   ),
    // ),

    // Expanded(
    //   child: TabBarView(
    //     children: [
    //       // first tab bar view widget
    //       Container(
    //         child: Center(
    //           child: ListView.builder(
    //             physics: const BouncingScrollPhysics(),
    //             padding: const EdgeInsets.symmetric(vertical: 20),
    //             itemBuilder: (context, index) {
    //               return const Text(''); //TweetCard(index: index);
    //             },
    //             itemCount: 0,
    //           ),
    //         ),
    //       ),

    //       // second tab bar viiew widget
    //       Container(
    //         child: Center(
    //           child: ListView.builder(
    //             physics: const BouncingScrollPhysics(),
    //             padding: const EdgeInsets.symmetric(vertical: 20),
    //             itemBuilder: (context, index) {
    //               return const Text(''); //TweetCard(index: index);
    //             },
    //             itemCount: 0,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // ),
    // );
  }
}
