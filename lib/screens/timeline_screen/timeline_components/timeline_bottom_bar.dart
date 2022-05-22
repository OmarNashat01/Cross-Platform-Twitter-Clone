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
    required this.pop,
  }) : super(key: key);
  bool pop;
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
                  pop == false
                      ? controller.animateTo(0.0,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 200))
                      :   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimelineScreen(firstTime: false)),
                  );

                },
                icon: const Icon(
                  FontAwesomeIcons.house,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchScreen();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            const Icon(
              FontAwesomeIcons.microphone,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NotificationsScreen();
                    },
                  ),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.bell,
              ),
            ),
            const Icon(
              Icons.mail_outline_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
