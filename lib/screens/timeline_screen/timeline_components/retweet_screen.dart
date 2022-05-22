import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/add_tweet_screen.dart';

import 'custom_page_route.dart';
class RetweetScreen extends StatelessWidget {
  RetweetScreen({required this.index,required this.doOrUndo});
  String doOrUndo;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery. of(context). size. height/3.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35),),
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //retweet or undo retweet button
            GestureDetector(
              onTap: ()
              {
                // doOrUndo=='do'?Provider.of<TweetsViewModel>(context,listen: false).retweet(index):Provider.of<TweetsViewModel>(context,listen: false).undoRetweet(index);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.retweet,
                    color: Colors.grey,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(doOrUndo=='do'?'Retweet':'Undo Retweet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: doOrUndo=='do'?Colors.black:Colors.red),)
                ],
              ),
            ),
            // Quote Tweet
            GestureDetector(
              onTap: ()
              {
                Navigator.of(context).push(
                  CustomPageRoute
                    (child:AddTweetScreen(
                     hintText: '', tweetOrReply: '',
                  ),beginX: 0,beginY: 1),

                );

              },
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.pencil,
                    color: Colors.grey,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Quote Tweet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),)
                ],
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.blueGrey.shade200),
                minimumSize: Size(double.infinity,40),
                elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],

        ),
      ),

    );
  }
}
