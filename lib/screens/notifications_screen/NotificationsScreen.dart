import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';
import '../../constants.dart';
import '../../providers/notifications_provider.dart';
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

class NotificationsScreen_state extends State<NotificationsScreen> {
  final controller = ScrollController();

  fetchNotifications(BuildContext context) {
    final notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);

    notificationsProvider.fetch().then((res) {
      switch (res.statusCode) {
        case 200: // Success
          log('${res.body}');
          final response = jsonDecode(res.body);
          final jsonNotificationsList = response['notifications'];
          notificationsProvider.setNotificationsList(jsonNotificationsList);
          break;
        case 204: // User does not have notifications
          break;
        case 401: // Unauthorized
          break;
        case 404: // User id not found
          break;
        default: // Invalid status code

      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
                            'Notifications',
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
                                      return TimelineScreen(firstTime: false,);
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
                      bottom: const TabBar(
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
                            child: Consumer<NotificationsProvider>(
                              builder: (context, val, child) => ListView(
                                children: val.notificationsList == []
                                    ? [const Text('shit')]
                                    : val.notificationsList,
                              ),
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
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
                                    trailing: Icon(Icons.more_vert),
                                    isThreeLine: true,
                                  ),
                                ),
                                Card(
                                  child: ListTile(
                                    leading: FlutterLogo(size: 50.0),
                                    title: Text('Ahmed Mostafa'),
                                    subtitle: Text(
                                        'A sufficiently long subtitle warrants three lines.'),
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
