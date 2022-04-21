import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import'package:twitter/dummy/tweets_list.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
class ImageDetailScreen extends StatefulWidget {
  int index;
  ImageDetailScreen({required this.index});
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
      AssetImage(Provider.of<TweetsList>(context,listen: false).getTweetsList()[widget.index].imageURL!),
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
                Provider.of<TweetsList>(context).getTweetsList()[widget.index].imageURL!,
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
              TweetBottomBar(index: widget.index,iconsBoundry: Colors.white,),
            ]
          ),
        ),
      ),
    );
  }
}