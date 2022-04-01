import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class TimelineBottomBar extends StatelessWidget {
  const TimelineBottomBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          [
            //home icon which on short press goes upward to the the screen beginning and on long press open bottom sheet making you able to create new account
            GestureDetector(
              onTap: ()
              {
                controller.animateTo(0.0,
                    curve: Curves.easeIn, duration: Duration(seconds: 1));
              },
              onLongPress: ()
              {
                showModalBottomSheet(
                  context: context,
                  builder:(context)=>
                      Container(
                        height: 50,
                      ),
                );
              },
              child: Icon(
                FontAwesomeIcons.house,
              ),
            ),
            GestureDetector(
              onTap: ()
              {
                print('searching');
              },
              child: Icon(
                Icons.search_outlined,
                size: 30,
              ),
            ),
            Icon(
              FontAwesomeIcons.microphone,
            ),
            Icon(
              FontAwesomeIcons.bell,
            ),
            Icon(
              Icons.mail_outline_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
