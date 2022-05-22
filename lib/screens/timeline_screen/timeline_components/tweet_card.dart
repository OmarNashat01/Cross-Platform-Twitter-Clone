import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/comments_provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/providers/ui_colors_provider.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_page.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/users_profiles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/user_model.dart';
import '../../../providers/list_view_tweet_provider.dart';
import 'custom_page_route.dart';
import 'image_video_detail_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/video_player_widget.dart';

//TweetCard class is the widget responsible for rendering the tweet card at the timeline and any needed place
//the tweet need information to be rendered
//this information will come from class which is TweetCardData
class TweetCard extends StatefulWidget {
  TweetCard(
      {required this.index,
      required this.tweet,
      this.videoPlayerController,
      required this.tweetPage});
  int index;
  bool tweetPage;
  TweetMain tweet;
  dynamic videoPlayerController;
  @override
  State<TweetCard> createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {
  GlobalKey threeDotsKey = GlobalKey();
  void _showPopupMenu(double x, double y) {
    y = y + 50;
    showMenu<String>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      position: RelativeRect.fromLTRB(
          x, y, 0.0, 0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem(
          height: kMinInteractiveDimension - 10,
          value: "1",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Delete Tweet",
                style: TextStyle(
                  color: Color(0xffF4212E),
                ),
              ),
              Icon(
                FontAwesomeIcons.trashCan,
                color: Color(0xffF4212E),
                size: 20,
              )
            ],
          ),
        ),
        const PopupMenuDivider(
          height: 0,
        ),
        PopupMenuItem(
          height: kMinInteractiveDimension - 10,
          value: "2",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Pin to your profile",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Icon(
                CupertinoIcons.pin,
                color: Colors.black,
                size: 20,
              )
            ],
          ),
        ),
        const PopupMenuDivider(
          height: 0,
        ),
        PopupMenuItem(
          height: kMinInteractiveDimension - 10,
          value: "3",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Change who can reply",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
                size: 20,
              )
            ],
          ),
        ),
        const PopupMenuDivider(
          height: 0,
        ),
        PopupMenuItem(
          height: kMinInteractiveDimension - 10,
          value: "4",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Add/remove from lists",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Icon(
                CupertinoIcons.square_list,
                color: Colors.black,
                size: 20,
              )
            ],
          ),
        ),
      ],
      elevation: 10,
    ).then<void>((String? itemSelected) {
      if (itemSelected == null) {
        Provider.of<UIColorProvider>(context, listen: false)
            .changeTweetThreeDotsColor(widget.tweet, const Color(0xffAFD9F4));
      } else if (itemSelected == "1") {
        Provider.of<UIColorProvider>(context, listen: false)
            .changeTweetThreeDotsColor(widget.tweet, const Color(0xffAFD9F4));
        showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.only(top: 15),
                buttonPadding: EdgeInsets.zero,
                actionsPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                title: Column(
                  children: const [
                    Center(
                        child: Text(
                      "Delete Tweet",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: (Text(
                        "Are you sure you want to delete",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      )),
                    ),
                    Center(
                      child: (Text(
                        "this Tweet?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      )),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              VerticalDivider(
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<TweetsViewModel>(context,
                                          listen: false)
                                      .deleteTweet(
                                          context,
                                          widget.tweet.tweet.tweetId,
                                          widget.index);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            });
        //delete the selected tweet

      } else if (itemSelected == "2") {
        Provider.of<UIColorProvider>(context, listen: false)
            .changeTweetThreeDotsColor(widget.tweet, const Color(0xffAFD9F4));

        //code here
      } else if (itemSelected == "3") {
        Provider.of<UIColorProvider>(context, listen: false)
            .changeTweetThreeDotsColor(widget.tweet, const Color(0xffAFD9F4));

        //code here
      } else {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.tweet.videos.isNotEmpty) {
      widget.videoPlayerController =
          VideoPlayerController.network(widget.tweet.videos[0].url)
            ..addListener(() {
              if (mounted == true) {
                setState(() {});
              }
            })
            ..setVolume(0)
            ..setLooping(true)
            ..initialize().then((_) => widget.videoPlayerController.play());
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (widget.videoPlayerController != null) {
      widget.videoPlayerController.dispose();
    }
    super.dispose();
  }

  dynamic isMuted;
  @override
  Widget build(BuildContext context) {
    if (widget.tweet.videos.isNotEmpty &&
        widget.videoPlayerController != null) {
      isMuted = widget.videoPlayerController.value.volume;
    }
    return InkWell(
      onTap: () {
        Provider.of<CommentsProvider>(context, listen: false).commentsList = [];
        widget.tweetPage == false
            ? Navigator.of(context).push(
                CustomPageRoute(
                    child: TweetPage(
                      tweetCard: TweetCard(
                          index: widget.index,
                          tweet: widget.tweet,
                          tweetPage: true),
                      tweet: widget.tweet,
                    ),
                    beginX: 0,
                    beginY: 1),
              )
            : print("");
      },
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //--here is the profile picture of the one who tweeted

                        ProfilePicture(
                            profilePictureFunctionality: () {
                              // Navigator.of(context).push(
                              //   CustomPageRoute(
                              //       child: (UsersProfile(
                              //           userId: widget.tweet.tweet.userId)),
                              //       beginX: 1,
                              //       beginY: 0),
                              // );
                            },
                            profilePictureImage:
                                widget.tweet.getTweetprofilePicUrl(),
                            profilePictureSize: navigationDrawerProfilePicSize),

                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //here is the name and title of the one who tweeted
                              Text(widget.tweet.getname(), style: boldName),
                              Text(widget.tweet.getusername()),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      key: threeDotsKey,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        Provider.of<UIColorProvider>(context, listen: false)
                            .changeTweetThreeDotsColor(
                                widget.tweet, Colors.blue);
                        RenderBox box = threeDotsKey.currentContext
                            ?.findRenderObject() as RenderBox;
                        Offset position = box.localToGlobal(
                            Offset.zero); //this is global position
                        double y = position.dy;
                        double x = position.dx;
                        _showPopupMenu(x, y);
                      },
                      icon: Icon(
                        FontAwesomeIcons.ellipsis,
                        color: Provider.of<UIColorProvider>(context)
                            .getTweetThreeDotsColor(widget.tweet),
                        size: 16,
                      ),
                    )
                  ],
                ),

                //--for decoration sized box
                 SizedBox(
                  height: widget.tweetPage==false?5:20,
                ),
                //--here is the text of the tweet
                widget.tweet.getTweettext() != ""
                    ? Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.tweet.getTweettext(),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              //max lines of writing a tweet is 8 like in the main twitter
                              maxLines: 8,
                              style: widget.tweetPage==false?tweetsTexts:innerTweetsTexts,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          //--for decoration sized box
          const SizedBox(
            height: 5,
          ),

          //--here is the video of the tweet

          widget.tweet.videos.isNotEmpty && widget.videoPlayerController != null
              ? GestureDetector(
                  onTap: () {
                    if (widget.videoPlayerController != null) {
                      widget.videoPlayerController.setVolume(1.0);
                    }
                    Navigator.of(context).push(
                      CustomPageRoute(
                          child: (ImageVideoDetailScreen(
                            videoPlayerController: widget.videoPlayerController,
                            isMuted: isMuted,
                            image: false,
                            video: true,
                            tweet: widget.tweet,
                            index: widget.index,
                          )),
                          beginX: 0,
                          beginY: 1),
                    );
                  },
                  child: widget.videoPlayerController != null
                      ? VideoPlayerWidget(
                          videoPlayerController: widget.videoPlayerController,
                          isMuted: isMuted,
                          inDetailVideo: false,
                        )
                      : SizedBox.shrink())
              : SizedBox.shrink(),
          //--here is the image of the tweet
          widget.tweet.images.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => ImageVideoDetailScreen(
                        videoPlayerController: widget.videoPlayerController,
                        isMuted: isMuted,
                        image: true,
                        video: false,
                        tweet: widget.tweet,
                        index: widget.index,
                      ),
                    ));
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.tweet.images[0].url,
                    placeholder: (context, url) {
                      return CircularProgressIndicator(
                        color: Colors.black38,
                      );
                    },
                    errorWidget: (context, url, error) => Text("a7aaa"),
                  ),
                )
              : SizedBox.shrink(),

          //here if the tweetCard is being just shown in the timeline this data wont be shown
          widget.tweetPage == false
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(left: 26, right: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [Text(widget.tweet.tweet.createdAt)],
                      ),
                      const Divider(
                        height: 25,
                        thickness: 1.5,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.tweet.tweet.retweetCount.toString() + " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Retweets ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            0.toString() + " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Quotes Tweets ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            widget.tweet.tweet.likeCount.toString() + " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Likes ",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 25,
                        thickness: 1.5,
                      ),
                    ],
                  ),
                ),
          //here is the TweetBottom bar
          //the row of icons for your reactions on the tweet
          TweetBottomBar(
            tweet: widget.tweet,
            index: widget.index,
            iconsBoundry: Colors.grey.shade600,
          ),
          //decoration of tweet at the bottom (divider)
          const SizedBox(
            height: 5,
          ),
          //decoration of tweet at the bottom (divider)
          const Divider(
            height: 0,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
