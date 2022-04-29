import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import '../timeline_screen/timeline_components/profile_picture.dart';
import '../timeline_screen/timeline_components/navigation_drawer.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';


class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications-screen';

  @override
  State<StatefulWidget> createState() {
    return NotificationsScreen_state();
  }
}

class NotificationsScreen_state extends State<NotificationsScreen>{

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
                          Text('Notifications', style: TextStyle(
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
                  // construct the profile details widget here
                  // SizedBox(
                  //   height: 180,
                  //   child: Center(
                  //     child: Text(
                  //       'Profile Details Goes here',
                  //     ),
                  //   ),
                  // ),

                  // the tab bar with two items
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            text: 'All',
                          ),
                          Tab(
                            text: 'Mentions',
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
                            child: ListView(
                              children: const <Widget>[
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // second tab bar viiew widget
                        Container(
                          child: Center(
                            child: ListView(
                              children: const <Widget>[
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                              ],
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