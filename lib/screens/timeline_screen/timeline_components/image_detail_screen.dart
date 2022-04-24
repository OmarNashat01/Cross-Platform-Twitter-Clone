import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import'package:twitter/dummy/timeline_list.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';

import '../../../models/tweet_complete_model.dart';
class ImageDetailScreen extends StatefulWidget {
  int index;
  TweetMain tweet;
  ImageDetailScreen({required this.index,required this.tweet});
  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
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
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(widget.tweet.images[0].url),
    );
    color=paletteGenerator.dominantColor;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:color?.color,
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
              child: Image.asset(
                widget.tweet.images[0].url,
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ),
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