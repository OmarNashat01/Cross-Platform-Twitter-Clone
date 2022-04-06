
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/dummy/tweets_list.dart';
import 'package:twitter/dummy/users_data.dart';
import 'package:twitter/models/tweet_card_data.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'package:extended_text_field/extended_text_field.dart';
class AddTweetScreen extends StatelessWidget {

  final controller = ScrollController();
  String? title;
  String text = "No Value Entered";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //here a nested scroll view widget needs ti be done


          appBar:AppBar(
            automaticallyImplyLeading: false,


            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Text(
                    'Cancel',
                    style: titleName,
                  ),
                  onTap: ()
                  {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    text=title!;
                    Provider.of<TweetsList>(context,listen: false).addTweet(TweetCardData(name: UsersData.getMyData().name, title: UsersData.getMyData().title, profilePicture: UsersData.getMyData().profilePicture, imageType: TweetImage.nothing, existence: TextExistence.exist,text: text));
                    print(Provider.of<TweetsList>(context,listen: false).getTweetsList().length);
                   Navigator.pop(context);
                  },
                  child: Text('Tweet',style:TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    primary: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        body: Column(
          children:[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,),
                  child: ProfilePicture(profilePictureFunctionality: (){}, profilePictureImage: UsersData.getMyData().profilePicture, profilePictureSize: navigationDrawerProfilePicSize),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText:"What's happening?",
                  ),
                  autofocus: true,
                  showCursor: true,
                  cursorHeight: 20,
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  onChanged: (value) => title = value,
                ),
              ),
            ),
          ] ,
        )

    );
  }
}