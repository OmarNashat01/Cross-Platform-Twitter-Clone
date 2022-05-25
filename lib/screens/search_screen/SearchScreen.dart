import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/providers/search_tweets_provider.dart';
import 'package:twitter/screens/settings_screen/settings_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import '../search_results_screen/search_results_screen.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import '../timeline_screen/timeline_components/navigation_drawer.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  State<StatefulWidget> createState() {
    return SearchScreen_state();
  }
}

class SearchScreen_state extends State<SearchScreen> {
  final _searchQueryController = TextEditingController();

  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            body: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorWidth: 2,
                    cursorColor: kOnPrimaryColor,
                    controller: _searchQueryController,
                    onFieldSubmitted: (query) {
                      Provider.of<SearchTweetsProvider>(context, listen: false)
                          .query = query;

                      Navigator.of(context)
                          .pushNamed(SearchResultsScreen.routeName);
                    },
                    style: const TextStyle(fontSize: 15),
                    decoration: decorateFields('Search Twitter'),
                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration decorateFields(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.grey,
    focusColor: Colors.grey,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: kOnPrimaryColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: kOnPrimaryColor,
      ),
    ),
  );
}
