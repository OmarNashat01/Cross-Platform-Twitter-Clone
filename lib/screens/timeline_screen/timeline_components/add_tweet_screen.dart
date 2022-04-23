

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/tweet_card_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_card.dart';

class AddTweetScreen extends StatelessWidget {
  AddTweetScreen({this.index,this.quote});
  bool? quote=false;//this quote is to check if this add tweet sreen is opened from add floating button itself or from quote tweet
  int? index;
  final controller = ScrollController();
  String? title;
  String text = "No Value Entered";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //here a nested scroll view widget needs ti be done
      body: SafeArea(
        child: NestedScrollView(
            floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)=>
          [
            SliverAppBar(
              forceElevated: innerBoxIsScrolled,
              pinned: true,
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
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      text = title!;
                      //if i am adding a tweet from scratch do this without showing the inner tweet
                      quote==false?Provider.of<TimelineList>(context, listen: false).addTweet(
                          TweetCardData(
                              name: UsersData.getMyData().name,
                              title: UsersData.getMyData().title,
                              profilePicture: UsersData.getMyData().profilePicture,
                              imageType: TweetImage.nothing,
                              existence: TextExistence.exist,
                              text: text))
                      //else i am adding a tweet from scratch having the inner tweet
                      : TweetCardData(
                          name: UsersData.getMyData().name,
                          title: UsersData.getMyData().title,
                          profilePicture: UsersData.getMyData().profilePicture,
                          imageType: TweetImage.nothing,
                          existence: TextExistence.exist,
                          text: text,
                        innerTweet: TweetCard(index: index!),
                        haveInnerTweet: true,
                      );
                      int count=0;
                      quote==true?Navigator.of(context).popUntil((_) => count++ >= 2):Navigator.pop(context);
                    },
                    child: Text(
                      'Tweet',
                      style: TextStyle(
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
          physics: BouncingScrollPhysics(),
          body: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ProfilePicture(
                          profilePictureFunctionality: () {},
                          profilePictureImage: UsersData.getMyData().profilePicture,
                          profilePictureSize: navigationDrawerProfilePicSize),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: "What's happening?",
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
                            quote==true?
                            TweetCard(index:index!)
                                :SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],

          )

        ),
      ),

       );
  }
}