import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/user_model.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/add_tweet_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/custom_page_route.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import 'package:twitter/themes.dart';
import '../../constants.dart';
import '../../providers/notifications_provider.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import '../timeline_screen/timeline_components/navigation_drawer.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

class FollowersScreen extends StatefulWidget {
  static const routeName = '/followers-screen';

  String userId;
  FollowersScreen({required this.userId});

  @override
  State<StatefulWidget> createState() {
    return FollowersScreen_state();
  }
}

class FollowersScreen_state extends State<FollowersScreen>
    with SingleTickerProviderStateMixin {
  final controller = ScrollController();

  double getOffset() {
    double o;
    if (_scrollController.hasClients) {
      o = _scrollController.offset;
    } else {
      o = 0.0;
    }
    return o;
  }

  late Future<User> user;
  late ScrollController _scrollController;

  late TabController _tabController =
      TabController(initialIndex: 0, length: 4, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _scrollController = ScrollController();
    user = Provider.of<UserProvider>(context, listen: false)
        .fetchUserByUserId(widget.userId);

    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
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
          body: SafeArea(
            child: NestedScrollView(
              controller: controller,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                    floating: true,
                    pinned: true,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    forceElevated: innerBoxIsScrolled,
                    shadowColor: Colors.white,
                    automaticallyImplyLeading: false,
                    title: TextButton(
                      onPressed: () {
                        controller.animateTo(0.0,
                            curve: Curves.easeIn,
                            duration: const Duration(seconds: 1));
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfilePicture(
                            profilePictureFunctionality: () {
                              Scaffold.of(context).openDrawer();
                            },
                            profilePictureImage:
                                Auth.profilePicUrl, // TODO: to be changed
                            profilePictureSize: 15,
                          ),
                          //twitter icon in the appbar
                          const Text(
                            'Followers',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TimelineScreen(
                                        firstTime: false,
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.grey,
                              )),
                          //sparkle icon in the appbar
                        ],
                      ),
                    )),
              ],
              body: FutureBuilder(
                future: user,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) return const CircularLoader();
                  return ListView.builder(
                    itemCount: snapshot.data.followers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                              snapshot.data.followers[index].profilePicUrl),
                          title: Text(snapshot.data.followers[index].name),
                          subtitle:
                              Text('@${snapshot.data.follower[index].username}'),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          bottomNavigationBar: TimelineBottomBar(
            contextt: context,
            controller: controller,
            popTimeLine: true,
            popSearch: true,
            popNotifications: false,
          ),
        ));
  }
}
