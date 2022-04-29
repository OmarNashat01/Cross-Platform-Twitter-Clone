

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/image_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/stream_controller_provider.dart';

class AddTweetScreen extends StatelessWidget {
  AddTweetScreen({required this.hintText,required this.tweetOrReply,this.replying,this.name});
  String? title;
  String?name;
  String text = "No Value Entered";
  String hintText;
  String tweetOrReply;
  bool?replying=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //here a nested scroll view widget needs ti be done
      appBar:
              AppBar(
                elevation: replying==true?1:0,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      child: TextButton(
                        onPressed: ()async {
                          text = title!;
                          List parts=[];
                          var image1;
                          int c=0;
                          int idx = text.indexOf(":");
                          for(int i=0;i<text.length;i++)
                          {
                            if(text[i]==':')
                            {
                              print('hola');
                              c=1;
                              parts = [text.substring(0,idx).trim(), text.substring(idx+1).trim()];
                              image1=[{ "url": parts[1], "alt_text": "7:45 pm", "height": 0, "width": 0}];
                              break;
                            }
                          }
                          if(c==0)
                          {
                            print("not hola");
                            parts.add(text);
                            image1=[];
                          }
                          print(parts[0]);
                          var now = new DateTime.now();
                          var formatter = new DateFormat('yyyy-MM-dd');
                          String formattedDate = formatter.format(now);
                          //if i am adding a tweet from scratch do this without showing the inner tweet
                          var uuid = Uuid();
                          String id=uuid.v4();
                          String tweetId=uuid.v4();
                          await Provider.of<TweetsViewModel>(context,listen: false).addTweet(text: parts[0],images: image1,videos: []);
                          //Provider.of<StreamControllerProvider>(context,listen: false).updateTweetStream(context,"126");
                          //await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetId(context,tweetId);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue.shade600),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),

                                )
                            )
                        ),
                        child: Text(tweetOrReply,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            body:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  replying==true?
                      Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 32,bottom: 3),
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:10,left: 32),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Replying to ',
                                        style: TextStyle(
                                          color: Colors.grey
                                        ),
                                      ),
                                      Text(
                                      name!,
                                      style: TextStyle(
                                      color: Colors.blue
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ):SizedBox.shrink(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProfilePicture(
                            profilePictureFunctionality: () {},
                            profilePictureImage: Auth.profilePicUrl,
                            profilePictureSize: navigationDrawerProfilePicSize),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              TextField(
                                decoration:  InputDecoration(
                                  hintText: hintText,
                                ),
                                autofocus: true,
                                showCursor: true,
                                cursorHeight: 20,
                                cursorColor: Colors.blue[600],
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) => title = value,
                              ),
                              //here will be the difference as if i qoute a tweet i will have the other user tweet here to quote it
                              // TweetCard(index:index!)

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            )

        );

  }
}
