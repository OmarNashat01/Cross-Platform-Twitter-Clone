import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:twitter/providers/image_videos_details_provider.dart';
import 'package:twitter/providers/ui_colors_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/video_player_widget.dart';
import 'package:video_player/video_player.dart';
import '../../../models/tweet_complete_model.dart';
class ImageVideoDetailScreen extends StatefulWidget {
  int index;
  TweetMain tweet;
  bool image;
  dynamic isMuted;
  bool video;
  dynamic videoPlayerController;
  ImageVideoDetailScreen({required this.index,required this.tweet,required this.image,required this.video,this.videoPlayerController,this.isMuted});
  @override
  State<ImageVideoDetailScreen> createState() => _ImageVideoDetailScreenState();
}

class _ImageVideoDetailScreenState extends State<ImageVideoDetailScreen> {
  String convertToMinutesSeconds(Duration duration){
    final minutes=duration.inMinutes;
    final seconds=duration.inSeconds;
    return'$minutes:$seconds';
  }
  double progress=0.0;
  GlobalKey imageKey = GlobalKey();
  PaletteColor? color;
  Duration ?videoLength;
  Duration ?videoPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.videoPlayerController.addListie
    color;
    _updatePalette();
    Provider.of<UIColorProvider>(context,listen: false).opacity=1;
  }
  _updatePalette ()async
  {
    // var image = await ExportVideoFrame.exportImageBySeconds(widget.videoPlayerController, duration, 0);

    PaletteGenerator ?paletteGenerator;
    widget.image==true?  paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.tweet.images[0].url),
    ): null;

    color=paletteGenerator?.darkVibrantColor;
    Provider.of<UIColorProvider>(context,listen: false).imageDetailColor=color?.color;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
     // label=widget.videoPlayerController.value.position.toString().split(".")[0];
    return Scaffold(
      backgroundColor:widget.image==true?Provider.of<UIColorProvider>(context).imageDetailColor:Colors.blueGrey,
      appBar: Provider.of<ImageVideoDetailsProvider>(context).upperLowerDetails==true?AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading:false,title: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: const Icon(
                Icons.close_outlined,
                color: Colors.white,
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            const Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),):AppBar(backgroundColor: Colors.transparent,automaticallyImplyLeading: false,),
      body: GestureDetector(
         dragStartBehavior: DragStartBehavior.down,
        onTap: ()
        {
          Provider.of<ImageVideoDetailsProvider>(context,listen: false).upperLowerDetails==true?Provider.of<ImageVideoDetailsProvider>(context,listen: false).hideUpperLowerDetails():Provider.of<ImageVideoDetailsProvider>(context,listen: false).showUpperLowerDetails();

        },
        child: Dismissible(
          movementDuration: const Duration(microseconds: 100),
          resizeDuration: const Duration(microseconds: 100),
          direction: DismissDirection.vertical,
          key: imageKey,

          onDismissed: (_) {
            if(widget.video)
            {widget.isMuted==0?widget.videoPlayerController.setVolume(0.0):widget.videoPlayerController.setVolume(1.0);}
            Navigator.of(context).pop();
          },
          //--------------------------------------------------------------------
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            widget.image==true?Column(
              children: [
                const SizedBox(height: 30,),
                Image.network(
                  widget.tweet.images[0].url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ],
            ):Column(
              children: [
                const SizedBox(height: 37,),
                VideoPlayerWidget(videoPlayerController:widget.videoPlayerController,isMuted: widget.isMuted,inDetailVideo: true,),
              ],
            ),
            ]
          ),
        ),
      ),
      bottomNavigationBar: Provider.of<ImageVideoDetailsProvider>(context).upperLowerDetails==true?
      Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (widget.video==true&&widget.videoPlayerController!=null)?
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        widget.videoPlayerController.value.isPlaying?widget.videoPlayerController.pause():widget.videoPlayerController.play();
                      });
                    },
                    child: Icon(
                        widget.videoPlayerController?.value.isPlaying?Icons.pause:Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: VideoProgressIndicator(widget.videoPlayerController, allowScrubbing: true)),
                  Text("  ${convertToMinutesSeconds(widget.videoPlayerController.value.position)} / ${convertToMinutesSeconds(widget.videoPlayerController.value.duration)}",style: TextStyle(color: Colors.white),)
                ],
              ):const SizedBox.shrink(),
              (widget.video==true&&widget.videoPlayerController!=null)?const SizedBox(height: 15,):const SizedBox.shrink(),
              TweetBottomBar(tweet:widget.tweet,index: widget.index,iconsBoundry: Colors.white,),
              const SizedBox(height: 15,),
              SizedBox(
                height: 35,
                child: TextField(
                  scrollPadding: const EdgeInsets.only(bottom:100,top: 100),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade500, width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                      ),

                      // filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Tweet your reply",
                      fillColor: Colors.transparent),
                ),
              ),
              const SizedBox(height: 25,),

            ],
          ),
        ),
      ):widget.image==true?const SizedBox(height: 105,):const SizedBox(height: 144,),
    );
  }
}