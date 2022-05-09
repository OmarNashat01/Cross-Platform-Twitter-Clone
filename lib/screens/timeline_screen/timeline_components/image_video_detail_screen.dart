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
class ImageVideoDetailScreen extends StatefulWidget {
  int index;
  TweetMain tweet;
  bool image=false;
  bool video=false;
  VideoPlayerController? videoPlayerController;
  ImageVideoDetailScreen({required this.index,required this.tweet,required this.image,required this.video,this.videoPlayerController});
  @override
  State<ImageVideoDetailScreen> createState() => _ImageVideoDetailScreenState();
}

class _ImageVideoDetailScreenState extends State<ImageVideoDetailScreen> {
  PaletteColor? color;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color;
    _updatePalette();
  }
  _updatePalette ()async
  {
    // var image = await ExportVideoFrame.exportImageBySeconds(widget.videoPlayerController, duration, 0);

    PaletteGenerator ?paletteGenerator;
    widget.image==true?  paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.tweet.images[0].url),
    ): null;

    color=paletteGenerator?.dominantColor;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:widget.image==true?color?.color:Colors.blueGrey,
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
              onDismissed: (_) => Navigator.of(context).pop(),
              child: widget.image==true?Image.network(
                widget.tweet.images[0].url,
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ):VideoPlayerWidget(videoPlayerController:widget.videoPlayerController!,isMuted: 0,)
            ),
              Column(
                children: [
                  TweetBottomBar(tweet:widget.tweet,index: widget.index,iconsBoundry: Colors.white,),
                  TextField(
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