import 'package:flutter/material.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/screens/profile_screen/edit_profile_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  @override
  State<StatefulWidget> createState() {
    return ProfileScreen_state();
  }
}

class ProfileScreen_state extends State<ProfileScreen>{

  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                    pinned: false,
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
                          //profile picture in timeline appbar
                          IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){ return TimelineScreen(); },
                              ),
                            );
                          }, icon: Icon(Icons.keyboard_return, color: Colors.black,)),
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
                    )),
                SliverToBoxAdapter(
                  child: Container(

                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfilePicture(
                              profilePictureFunctionality: () {
                                Scaffold.of(context).openDrawer();
                              },
                              profilePictureImage: UsersData
                                  .getMyData()
                                  .profilePicture,
                              profilePictureSize: 40,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context){ return EditProfileScreen(); },
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.cyan),
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          UsersData.getMyData().name,
                          style: boldName,
                        ),
                        Text(
                          UsersData.getMyData().title,
                          style: titleName,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'A 20-year Computer Student working as a graphic desogner.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  UsersData.getMyData()
                                      .followingNumber
                                      .toString(),
                                  style: boldName,
                                ),
                                followingString,
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  UsersData.getMyData()
                                      .followersNumber
                                      .toString(),
                                  style: boldName,
                                ),
                                followersString,
                              ],
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            text: 'Tweets',
                          ),
                          Tab(
                            text: 'Media',
                          ),
                          Tab(
                            text: 'Likes',
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
                              padding: EdgeInsets.symmetric(vertical: 40),
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
                              padding: EdgeInsets.symmetric(vertical: 40),
                              itemBuilder: (context, index) {
                                return Text('');//TweetCard(index: index);
                              },
                              itemCount: 0,
                            ),
                          ),
                        ),
                        // third tab bar viiew widget
                        Container(
                          child: Center(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 40),
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
          bottomNavigationBar: TimelineBottomBar(controller: controller),

        ),
      ),
    );
  }
}