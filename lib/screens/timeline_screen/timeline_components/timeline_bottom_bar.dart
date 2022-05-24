import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter/screens/notifications_screen/NotificationsScreen.dart';
import 'package:twitter/screens/search_screen/SearchScreen.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';

class TimelineBottomBar extends StatelessWidget {
  TimelineBottomBar({
    Key? key,
    required this.contextt,
    required this.controller,
    required this.popTimeLine,
    required this.popSearch,
    required this.popNotifications,
  }) : super(key: key);
  bool popTimeLine;
  bool popSearch;
  bool popNotifications;

  final ScrollController controller;
  final BuildContext contextt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //home icon which on short press goes upward to the the screen beginning and on long press open bottom sheet making you able to create new account
            GestureDetector(
              onTap: () {},
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: 50,
                  ),
                );
              },
              child: IconButton(
                onPressed: () {
                  popTimeLine == false
                      ? controller.animateTo(0.0,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 200))
                      :   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TimelineScreen(firstTime: false)),
                  );

                },
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  color: (popTimeLine == false ? Colors.black : Colors.grey),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                popSearch == false
                    ? controller.animateTo(0.0,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 200))
                    : Navigator.of(context)
                        .pushReplacementNamed(SearchScreen.routeName);
              },
              icon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: (popSearch == false ? Colors.black : Colors.grey),
              ),
            ),
            IconButton(
              onPressed: () {
                popNotifications == false
                    ? controller.animateTo(0.0,
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 200))
                    : Navigator.of(context)
                        .pushReplacementNamed(NotificationsScreen.routeName);
              },
              icon: FaIcon(
                FontAwesomeIcons.solidBell,
                color: (popNotifications == false ? Colors.black : Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
