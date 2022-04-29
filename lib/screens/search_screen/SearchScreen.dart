import 'package:flutter/material.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:twitter/dummy/timeline_list.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
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

class SearchScreen_state extends State<SearchScreen>{

  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer:
          NavigationDrawer(),

          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue,
            child: Icon(
              FontAwesomeIcons.plus,
              size: 20,
            ),
          ),

          body: SafeArea(
            child: NestedScrollView(
              controller: controller,
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
              [
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
                        controller.animateTo(0.0, curve: Curves.easeIn, duration: Duration(seconds: 1));
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProfilePicture(
                            profilePictureFunctionality: () {
                              Scaffold.of(context).openDrawer();
                            },
                            profilePictureImage: UsersData
                                .getMyData()
                                .profilePicture,
                            profilePictureSize: 15,
                          ),
                          //twitter icon in the appbar
                          Text('Search', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),),
                          IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){ return TimelineScreen(); },
                              ),
                            );
                          }, icon: Icon(Icons.settings, color: Colors.grey,)),
                          //sparkle icon in the appbar
                        ],
                      ),
                    )),
              ],
              body: Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Search Twitter',
                        ),
                      ),
                    ),
                  ),

                  // the tab bar with two items
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            text: 'Trending',
                          ),
                          Tab(
                            text: 'News',
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        // first tab bar view widget
                        Container(
                          child: Center(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              itemBuilder: (context, index) {
                                return Text('');//TweetCard(index: index);
                              },
                              itemCount: 0,
                            ),
                          ),
                        ),

                        // second tab bar viiew widget
                        Container(
                          child: Center(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              itemBuilder: (context, index) {
                                return Text('');//TweetCard(index: index);
                              },
                              itemCount: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),
          ),
          bottomNavigationBar: TimelineBottomBar(controller: controller,pop: true,),

        ),
      ),
    );
  }
}