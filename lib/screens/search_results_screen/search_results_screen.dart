import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/screens/settings_screen/settings_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import '../timeline_screen/timeline_components/navigation_drawer.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    final query = ModalRoute.of(context)!.settings.arguments;
    log('Query: $query');

    return Scaffold(
      bottomNavigationBar: TimelineBottomBar(
        contextt: context,
        controller: controller,
        popTimeLine: true,
        popSearch: false,
        popNotifications: true,
      ),
      drawer: NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          body: Text(''),
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
                  Navigator.pushNamed(context, TimelineScreen.routeName);
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfilePicture(
                      profilePictureFunctionality: () {
                        Scaffold.of(context).openDrawer();
                      },
                      profilePictureImage: Auth.profilePicUrl.isEmpty
                          ? kDefaultPictureUrl
                          : Auth.profilePicUrl,
                      profilePictureSize: 15,
                    ),
                    //twitter icon in the appbar
                    const Text(
                      'Search',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kOnPrimaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SettingsScreen.routeName);
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                    ),
                    //sparkle icon in the appbar
                  ],
                ),
              ),
            ),
          ],
        ),

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
      ),
    );
  }
}
