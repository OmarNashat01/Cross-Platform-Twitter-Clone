import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/retweet_screen.dart';

import '../../../constants.dart';
import '../../../dummy/timeline_list.dart';

class TweetBottomBar extends StatelessWidget {
  const TweetBottomBar({
    Key? key,
    required this.index,
    required this.iconsBoundry,
  }) : super(key: key);

  final int index;
  final Color iconsBoundry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //comment button on tweet
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                 Icon(
                  FontAwesomeIcons.comment,
                  color: iconsBoundry,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Provider.of<TimelineList>(context)
                            .getTweetsList()[index]
                            .commentCount >
                        0
                    ? Text(
                        Provider.of<TimelineList>(context)
                            .getTweetsList()[index]
                            .commentCount
                            .toString(),
                        style: titleName,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          //retweet button on tweet
          GestureDetector(
            onTap: () {
              Provider.of<TimelineList>(context,listen: false).getTweetsList()[index].isRetweeted==false?showModalBottomSheet(context: context, builder: (context)=>RetweetScreen(index: index,doOrUndo: 'do',),)
              :showModalBottomSheet(context: context, builder: (context)=>RetweetScreen(index: index,doOrUndo: 'undo',),);
              },
            child: Row(
              children: [
                 Icon(
                  FontAwesomeIcons.retweet,
                  color: Provider.of<TimelineList>(context).getTweetsList()[index].isRetweeted==false?iconsBoundry:Colors.green,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Provider.of<TimelineList>(context)
                            .getTweetsList()[index]
                            .retweetCount >
                        0
                    ? Text(
                        Provider.of<TimelineList>(context)
                            .getTweetsList()[index]
                            .retweetCount
                            .toString(),
                        style:Provider.of<TimelineList>(context).getTweetsList()[index].isRetweeted==false?notRetweeted:retweeted,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),

          //--this is functionality of the love button on the tweets
          Row(
            children: [
              LikeButton(
                isLiked: Provider.of<TimelineList>(context)
                    .getTweetsList()[index]
                    .isLiked,
                likeCount: Provider.of<TimelineList>(context)
                    .getTweetsList()[index]
                    .likeCount,
                likeBuilder: (isLiked) {
                  final color = isLiked ? Colors.red : Colors.transparent;
                  return Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: color,
                          size: 20,
                        ),
                        Icon(
                          FontAwesomeIcons.heart,
                          color: isLiked ? Colors.red : iconsBoundry,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
                countBuilder: (count, isLiked, text) {
                  return Provider.of<TimelineList>(context).getTweetsList()[index].likeCount > 0 ? Text(text, style: isLiked?loved:titleName,) : const SizedBox.shrink();
                },
                onTap: (isLiked) async {
                  Provider.of<TimelineList>(context, listen: false)
                      .reactLove(!isLiked, index);
                  //Provider.of<TweetsList>(context,listen: false).getTweetsList()[index].nLove+= Provider.of<TweetsList>(context,listen: false).getTweetsList()[index].isLiked?1:-1;
                  return !isLiked;
                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          //--share tweet
          GestureDetector(
            onTap: () {},
            child:  Icon(
              FontAwesomeIcons.arrowUpFromBracket,
              color: iconsBoundry,
              size: 18,
            ),
          ),

          //-----------------------------------------------------------------
        ],
      ),
    );
  }
}
