import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/users_profiles.dart';

import '../../../models/user_model.dart';
import 'custom_page_route.dart';
import 'image_detail_screen.dart';

//TweetCard class is the widget responsible for rendering the tweet card at the timeline and any needed place
//the tweet need information to be rendered
//this information will come from class which is TweetCardData
class TweetCard extends StatelessWidget {
  TweetCard({required this.index, required this.tweet,required this.user});
  int index;
  TweetMain tweet;
   Future<User> user;
  @override
  Widget build(BuildContext context) {

    return Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 26, right: 26),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        children: [
                          //--here is the profile picture of the one who tweeted
                          FutureBuilder(
                            future:user,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
                            {
                              switch(snapshot.connectionState)
                              {
                                case ConnectionState.none:
                                  return Text('press button to start');
                                case ConnectionState.waiting:
                                  return Container(
                                      alignment: Alignment.topCenter,
                                      margin: EdgeInsets.only(top: 20),
                                      child: CircularProgressIndicator(
                                        value: 0.8,
                                      )
                                  );
                                default:
                                  if(snapshot.hasError)
                                  {
                                    return Text('error');
                                  }
                                  else
                                    {
                                      return ProfilePicture (
                                          profilePictureFunctionality: () {
                                            Navigator.of(context).push(
                                              CustomPageRoute(
                                                  child: (UsersProfile(user:snapshot.data)), beginX: 1, beginY: 0),
                                            );
                                          },
                                          profilePictureImage:tweet.getTweetprofilePicUrl(),
                                          profilePictureSize: navigationDrawerProfilePicSize);
                                    }
                              }
                            },
                          ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //here is the name and title of the one who tweeted
                        Text( tweet.getname(),
                            style: boldName),
                        Text(tweet.getusername()),
                      ],
                    ),
                  ),
                ],
              ),

              //--for decoration sized box
              SizedBox(height: 5,),
              //--here is the text of the tweet
                    tweet.getTweettext()!=""
                  ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          tweet.getTweettext(),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                            //max lines of writing a tweet is 8 like in the main twitter
                            maxLines: 8,
                            style: tweetsTexts,
                          ),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
             //--for decoration sized box
             SizedBox(height: 5,),

        //--here is the image of the tweet
            GestureDetector(
          onTap: ()
          {
            Navigator.of(context).push(
              CustomPageRoute
                (child:ImageDetailScreen(
                tweet: tweet,
                index: index,
              ),beginX: 0,beginY: 1),
            );
          },
               child: tweet.images.length>0?
               Image.network(
                 tweet.images[0].url,
           fit: BoxFit.cover,
           width: double.infinity,
           alignment: Alignment.center,
                 ):
                   SizedBox.shrink(),
            ),


        //the row of icons for your reactions on the tweet
        TweetBottomBar(tweet:tweet,index: index,iconsBoundry: Colors.grey.shade600,),


        //decoration of tweet at the bottom (divider)
        const SizedBox(
          height: 5,
        ),
        //decoration of tweet at the bottom (divider)
        const Divider(
          thickness: 1.5,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}


