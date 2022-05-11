import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import'package:twitter/dummy/timeline_list.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import '../../../models/tweet_complete_model.dart';
import '../../../providers/tweets_view_model.dart';
import '../../../providers/video_provider.dart';
class VideoDetailScreen extends StatelessWidget {
  int index;
  TweetMain tweet;
  double isMuted;
  VideoPlayerController videoPlayerController;
  VideoDetailScreen({required this.index,required this.tweet,required this.videoPlayerController,required this.isMuted});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.blueGrey,
        body: GestureDetector(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                      Icon(
                        Icons.more_horiz_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Dismissible(
                    movementDuration: Duration(microseconds: 100),
                    resizeDuration: Duration(microseconds: 100),
                    direction: DismissDirection.vertical,
                    key: const Key('key'),
                    onDismissed: (_) {
                      Provider.of<VideoPlayerProvider>(context,listen: false).isPlayed=true;
                      Navigator.of(context).pop();
                    },
                    child: Center(child: VideoPlayerWidget(videoPlayerController:videoPlayerController,isMuted: isMuted,))
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10,right: 10,left: 10,top: 5),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                                Provider.of<VideoPlayerProvider>(context).isPlayed?Icons.pause:Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onTap: (){
                              if( Provider.of<VideoPlayerProvider>(context,listen:false).isPlayed==true) {
                                Provider.of<VideoPlayerProvider>(
                                    context, listen: false).pauseVideo(
                                    videoPlayerController);
                              }
                              else
                                {
                                  Provider.of<VideoPlayerProvider>(
                                      context, listen: false).playVideo(
                                      videoPlayerController);
                                }
                            },
                          ),
                        ],
                      ),
                    ),
                    TweetBottomBar(tweet:tweet,index:index,iconsBoundry: Colors.white,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10,right: 10,left: 10,top: 5),
                      child: TextField(
                        scrollPadding: EdgeInsets.only(bottom:100,top: 100),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white54, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white54, width: 1),
                            ),

                            // filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Tweet your reply",
                            fillColor: Colors.transparent),
                      ),
                    )
                  ],
                ),

              ]
          ),
        ),
      ),
    );
  }
}