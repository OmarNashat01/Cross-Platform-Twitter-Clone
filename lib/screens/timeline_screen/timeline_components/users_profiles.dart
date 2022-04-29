import 'dart:async';
import 'dart:ui';
import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/screens/search_screen/SearchScreen.dart';
import 'package:twitter/providers/stream_controller_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'dart:math' as math;
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import 'package:twitter/screens/profile_screen/edit_profile_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

import '../../../models/user_model.dart';
import '../../../providers/tweets_view_model.dart';
import '../../../providers/user_provider.dart';
import '../../../themes.dart';

class UsersProfile extends StatefulWidget {
  static const routeName = '/profile-screen';
  UsersProfile({required this.user});
  User user;
  @override
  State<StatefulWidget> createState() {
    return UsersProfile_state();
  }
}
int x=1;
class UsersProfile_state extends State<UsersProfile> with SingleTickerProviderStateMixin {
  bool isMyProfile = true;
  var top = 0.0;

  double getOffset(){
    double o;
    if(_scrollController.hasClients){
      o = _scrollController.offset;
    }
    else {
      o = 0.0;
    }
    return o;
  }

  late ScrollController _scrollController;
  StreamController tweetsStreamController=StreamController();//index 1
  // StreamController tweetsStreamController=StreamController();

  // StreamController tweetsStreamController=StreamController();
  // Stream ?tweetsStream;
  // StreamController tweetsStreamController=StreamController();
  // Stream ?tweetsStream;
  late TabController _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _scrollController = ScrollController();
    x=x+1;
    Provider.of<TweetsViewModel>(context,listen: false).fetchUserTweets(context,x,widget.user.id);
    print(x);
    _scrollController.addListener(() {
      setState(() {
      });
    });
  }

  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TimelineBottomBar(controller: controller,pop: true,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 4,
              child: CustomNestedScrollView(
                physics: BouncingScrollPhysics(),
                overscrollType: CustomOverscroll.outer,
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      stretch: true,
                      elevation: 0,
                      expandedHeight: 120,
                      collapsedHeight: 80,
                      backgroundColor: Colors.black,
                      leading: Container(
                        height: 90,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ElevatedButton(
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){ return TimelineScreen(); },
                            ),
                          );
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white,size: 20,),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            maximumSize: Size(30, 30),
                            minimumSize: Size(30, 30),

                            padding: EdgeInsets.all(0),
                            primary: Colors.black.withOpacity(0.5), // <-- Button color
                            onPrimary: Colors.blue, // <-- Splash color
                          ),
                        ),
                      ),
                      actions: [
                        Container(
                          height: 90,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ElevatedButton(
                            onPressed: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){ return SearchScreen(); },
                              ),
                            );
                            },
                            child: Icon(Icons.search, color: Colors.white,size: 20,),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              maximumSize: Size(30, 30),
                              minimumSize: Size(30, 30),

                              padding: EdgeInsets.all(0),
                              primary: Colors.black.withOpacity(0.5), // <-- Button color
                              onPrimary: Colors.blue, // <-- Splash color
                            ),
                          ),
                        ),
                      ],


                      pinned: true,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          top = constraints.biggest.height;
                          return FlexibleSpaceBar(
                            stretchModes: [
                              StretchMode.blurBackground,
                              StretchMode.zoomBackground,
                            ],
                            centerTitle: true,
                            title: AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: top <= 100 ? 1.0 : 0.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.user.name,
                                      style: header_titleName,
                                    ),
                                    Text(
                                      widget.user.tweetCount.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.white
                                      ),
                                    ),
                                  ],
                                )

                            ),
                            background: Stack(
                              children: [
                                Container(
                                  child: Image.network(widget.user.coverPicUrl, fit: BoxFit.cover,),
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          );
                        },),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        transform: Matrix4.translationValues(0, -20, 0),
                        width: double.infinity,
                        color: Colors.green[600],
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Transform(
                                  transform: Matrix4.identity()..scale(getOffset() < 35 ? 0.0 : 0.7),
                                  alignment: Alignment.bottomCenter,
                                  child: CircleAvatar(
                                    radius: 45,
                                    backgroundColor: AppColor.white,
                                    child: CircleAvatar(
                                      radius: 40,
                                      child: ProfilePicture(
                                        profilePictureFunctionality: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        profilePictureImage: widget.user.profilePicUrl,
                                        profilePictureSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    if (isMyProfile) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context){ return EditProfileScreen(); },
                                        ),
                                      );
                                    } else {
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 35,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isMyProfile
                                          ? TwitterColor.white
                                          : TwitterColor.dodgetBlue,
                                      border: Border.all(
                                          color: isMyProfile
                                              ? Colors.black87.withAlpha(180)
                                              : Colors.blue,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isMyProfile ?
                                        'Edit' : 'Following',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: isMyProfile
                                              ? Colors.black87.withAlpha(180)
                                              : TwitterColor.white,
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
                              widget.user.name,
                              style: bio_titleName,
                            ),
                            Text(
                              widget.user.username,
                              style: bio_UserName,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            widget.user.bio!=null?
                            Text(
                              widget.user.bio!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ):SizedBox.shrink(),
                            SizedBox(
                              height: 15,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.location_on_outlined, size: 14, color: Colors.black54,),
                                  ),
                                  TextSpan(
                                      text: widget.user.location,
                                      style: TextStyle(fontSize: 12, color: Colors.black54)
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.sports_basketball_outlined, size: 14, color: Colors.black54,),
                                  ),
                                  TextSpan(
                                      text: " Born ${widget.user.dateOfBirth}",
                                      style: TextStyle(fontSize: 12, color: Colors.black54)
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.calendar_month_outlined, size: 14, color: Colors.black54,),
                                  ),
                                  TextSpan(
                                      text: " Joined ${widget.user.creationDate}",
                                      style: TextStyle(fontSize: 12, color: Colors.black54)
                                  ),
                                ],
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
                                     widget.user.followingCount.toString(),
                                      style: boldName,
                                    ),
                                    followingString,
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.user.followersCount.toString(),
                                      style: boldName,
                                    ),
                                    followersString,
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 50,
                        maxHeight: 50,
                        child: Container(
                          color: Colors.white,
                          child: AppBar(
                            bottom: TabBar(
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(width: 4.0, color: Colors.blue),

                              ),
                              onTap: (int index)
                              {
                                setState(() {
                                  x=x+1;
                                  print(x);
                                });

                              },
                              controller: _tabController,
                              isScrollable: true,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black54,
                              indicatorWeight: 2,
                              indicatorColor: Colors.blue,
                              tabs: [
                                Tab(
                                  text: 'Tweets',
                                ),
                                Tab(
                                  text: 'Tweets & replies',
                                ),
                                Tab(
                                  text: 'Media',
                                ),
                                Tab(
                                  text: 'Likes',
                                ),
                              ],
                            ),
                            shape: Border(bottom: BorderSide(color: Colors.black12, width: 1),),
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      StreamBuilder(
                          stream: Provider.of<StreamControllerProvider>(context).addStreamController(tweetsStreamController, x).stream,
                          builder: (BuildContext context,AsyncSnapshot snapshot,)
                          {
                            switch(snapshot.connectionState)
                            {
                              case ConnectionState.none:
                                return Text('press button to start');
                              case ConnectionState.waiting:
                                return const CircularProgressIndicator();
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
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return TweetCard(index: index,tweet: snapshot.data[index],user:Provider.of<UserProvider>(context).fetchUserByUserId(widget.user.id),);
                                      },
                                      itemCount:snapshot.data.length,
                                    ),
                                  );
                                }
                            }

                          }
                      ),
                      StreamBuilder(
                          builder: (BuildContext context,AsyncSnapshot snapshot,)
                          {

                            switch(snapshot.connectionState)
                            {
                              case ConnectionState.none:
                                return Text('press button to start');
                              case ConnectionState.waiting:
                                return Text("waiting");
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
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return TweetCard(index: index,tweet: snapshot.data[index],user:Provider.of<UserProvider>(context).fetchUserByUserId(widget.user.id));
                                      },
                                      itemCount:snapshot.data.length,
                                    ),
                                  );
                                }
                            }

                          }
                      ),
                      StreamBuilder(
                          builder: (BuildContext context,AsyncSnapshot snapshot,)
                          {

                            switch(snapshot.connectionState)
                            {
                              case ConnectionState.none:
                                return Text('press button to start');
                              case ConnectionState.waiting:
                                return Text("waiting");
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
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return TweetCard(index: index,tweet: snapshot.data[index],user:Provider.of<UserProvider>(context).fetchUserByUserId(widget.user.id));
                                      },
                                      itemCount:snapshot.data.length,
                                    ),
                                  );
                                }
                            }

                          }
                      ),
                      StreamBuilder(
                          builder: (BuildContext context,AsyncSnapshot snapshot,)
                          {

                            switch(snapshot.connectionState)
                            {
                              case ConnectionState.none:
                                return Text('press button to start');
                              case ConnectionState.waiting:
                                return Text("waiting");
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
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return TweetCard(index: index,tweet: snapshot.data[index],user:Provider.of<UserProvider>(context).fetchUserByUserId(widget.user.id));
                                      },
                                      itemCount:snapshot.data.length,
                                    ),
                                  );
                                }
                            }

                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildPic(),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Container(
                height: 90,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){ return TimelineScreen(); },
                    ),
                  );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white,size: 20,),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    maximumSize: Size(30, 30),
                    minimumSize: Size(30, 30),

                    padding: EdgeInsets.all(0),
                    primary: Colors.black.withOpacity(0.5), // <-- Button color
                    onPrimary: Colors.blue, // <-- Splash color
                  ),
                ),
              ),
                Container(
                  height: 90,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){ return TimelineScreen(); },
                      ),
                    );
                    },
                    child: Icon(Icons.search, color: Colors.white,size: 20,),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      maximumSize: Size(30, 30),
                      minimumSize: Size(30, 30),

                      padding: EdgeInsets.all(0),
                      primary: Colors.black.withOpacity(0.5), // <-- Button color
                      onPrimary: Colors.blue, // <-- Splash color
                    ),
                  ),
                ),],
            ),*/
          ],
        ),
      ),
    );
  }


  Widget buildPic (){
    final double defaultMargin = 120;
    final double defaultStart = 100;
    final double defaultEnd = defaultStart /2;

    double top = defaultMargin;
    double scale = 1.0;
    double Picscale = 1.0;
    double offset = 0;


    if(_scrollController.hasClients){
      offset = _scrollController.offset;
      top -= offset;

      if(offset < defaultMargin - defaultStart) {
        scale = 1.0;
        Picscale = 1.0;

      }
      else if(offset < defaultStart - defaultEnd){
        scale = (defaultMargin -defaultEnd - offset) /defaultEnd;
        Picscale = offset > 35 ? Picscale = 0.0 : (defaultMargin -defaultEnd - offset) /defaultEnd;

      }
      else {
        scale = 0.0;
        Picscale = 0.0;

      }
    }



    return Positioned(

      top: top-20,
      left: 20,
      child: Transform(
        transform: Matrix4.identity()..scale(Picscale),
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          radius: 45,
          backgroundColor: AppColor.white,
          child: CircleAvatar(
            radius: 40,
            child: ProfilePicture(
              profilePictureFunctionality: () {
                Scaffold.of(context).openDrawer();
              },
              profilePictureImage:widget.user.profilePicUrl,
              profilePictureSize: 40,
            ),
          ),
        ),
      ),);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}