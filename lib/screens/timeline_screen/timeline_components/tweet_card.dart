import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/models/tweet_model.dart';
import 'package:twitter/providers/comments_provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/providers/ui_colors_provider.dart';
import 'package:twitter/screens/others_profile_screen/others_profile_screen.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/tweet_page.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/users_profiles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/user_model.dart';
import '../../../providers/list_view_tweet_provider.dart';
import '../../../providers/user_provider.dart';
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
      required this.tweetPage,
        this.shiftTweets,
        required this.userId,
        this.isTweetInner, required this.realUserId
      });
  String realUserId="";
  bool? isTweetInner=false;
  String userId="";
  int index;
  bool tweetPage;
  TweetMain tweet;
  bool ?shiftTweets=false;
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
                                          widget.tweet.outerTweet.tweetId,
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
  void toggleTweetsInfo(bool isLiked,int likesCount)
  {
    setState(() {
      widget.tweet.outerTweet.likeCount=likesCount;
      widget.tweet.outerTweet.isLiked=isLiked;
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
String username="";
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
    if(widget.tweet.outerTweet.quoted==false)
      {
        print(widget.tweet.outerTweet.text);
      }
    if (widget.tweet.videos.isNotEmpty &&
        widget.videoPlayerController != null) {
      isMuted = widget.videoPlayerController.value.volume;
    }
    return InkWell(

      onTap: ()async {
        widget.userId=widget.tweet.outerTweet.userId;
        if(widget.tweetPage==false)
       {
         username=widget.userId;
       }
        dynamic tweeta=widget.tweet.innerTweet==null?await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetId(widget.tweet.outerTweet.tweetId):widget.tweet.outerTweet.quoted==true?await Provider.of<TweetsViewModel>(context,listen: false).fetchQuotedRetweetByRetweetId(widget.tweet.outerTweet.tweetId,context):await Provider.of<TweetsViewModel>(context,listen: false).fetchNotQuotedRetweetByRetweetId(widget.tweet.outerTweet.tweetId,context);
        setState(() {
          widget.tweet=tweeta[0];
          widget.tweet.outerTweet.likeCount=tweeta[0].outerTweet.likeCount;
        });
        widget.tweetPage == false
            ? Navigator.of(context).push(
                CustomPageRoute(
                    child: TweetPage(
                      shiftTweets:true,
                      tweetCard: TweetCard(
                        isTweetInner: false,
                        userId: "",
                        realUserId:"",
                        shiftTweets: false,
                          index: widget.index,
                          tweet: tweeta[0],
                          tweetPage: true),
                      tweet: tweeta[0],
                      userId:widget.tweet.outerTweet.username,
                      realUserId:widget.tweet.outerTweet.userId,
                    ),
                    beginX: 0,
                    beginY: 1),
              )
            : print("");
      },
      //outer tweet look
      child: widget.isTweetInner==false?Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          widget.tweet.outerTweet.quoted==false?
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.retweet,color: Colors.grey,),

                    Text(" You Retweeted",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                  ],
                ),
              ):SizedBox.shrink(),
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
                              Navigator.of(context).push(
                                CustomPageRoute(
                                    child: (OthersProfileScreen(
                                        userId: widget.tweet.outerTweet.userId)),
                                    beginX: 1,
                                    beginY: 0),
                              );
                            },
                            profilePictureImage:
                                widget.tweet.outerTweet.profilePicUrl,
                            profilePictureSize: navigationDrawerProfilePicSize),

                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //here is the name and title of the one who tweeted
                              (widget.isTweetInner==false&&widget.tweet.outerTweet.name!=null)?
                              Text(widget.tweet.outerTweet.name!, style: boldName):SizedBox.shrink(),
                              Text(widget.tweet.getusername()),
                            ],
                          ),
                        ),
                      ],
                    ),
                    widget.isTweetInner==false?
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
                    ):SizedBox.shrink()
                  ],
                ),

                //--for decoration sized box
                 SizedBox(
                  height: widget.tweetPage==false?10:20,
                ),
                //--here is the text of the tweet
                widget.tweet.outerTweet.text! != ""
                    ? (widget.shiftTweets==false)?Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.tweet.outerTweet.text!,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              //max lines of writing a tweet is 8 like in the main twitter
                              maxLines: 8,
                              style: widget.tweetPage==false?tweetsTexts:innerTweetsTexts,
                            ),
                          ),
                        ],
                      )
                    : Column(
                      children: [
                        widget.userId!=""?
                        Padding(padding: EdgeInsets.only(left: 50),
                            child:InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  CustomPageRoute(
                                      child: (OthersProfileScreen(
                                          userId: widget.realUserId)),
                                      beginX: 1,
                                      beginY: 0),
                                );
                              },
                              child: Row(
                                children: [
                                  Text("Replying to  ",style: TextStyle(color: Colors.blueGrey),),
                                  Text(widget.userId,style: TextStyle(color: Colors.blue),),
                                ],
                              ),
                            )
                        )
                        :
                        SizedBox.shrink(),
                        widget.userId!=""?SizedBox(height: 10,):SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                          Expanded(
                            child: Text(
                              widget.tweet.outerTweet.text!,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              //max lines of writing a tweet is 8 like in the main twitter
                              maxLines: 8,
                              style: widget.tweetPage==false?tweetsTexts:innerTweetsTexts,
                            ),
                          ),
                  ],
                ),
                        ),
                      ],
                    )
                :const SizedBox.shrink(),
              ],
            ),
          ),
          //--for decoration sized box
          const SizedBox(
            height: 15,
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
              child: SizedBox.shrink())
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
                  // child: CachedNetworkImage(
                  //   imageUrl: widget.tweet.images[0].url,
                  //   placeholder: (context, url) {
                  //     return CircularProgressIndicator(
                  //       color: Colors.black38,
                  //     );
                  //   },
                  //   errorWidget: (context, url, error) => Text("a7aaa"),
                  // ),
            child: SizedBox.shrink(),
                )
              : SizedBox.shrink(),

          //here if the tweetCard is being just shown in the timeline this data wont be shown
          widget.tweetPage == false
              ? SizedBox.shrink()
              : Column(
                children: [
                  widget.tweet.innerTweet!=null?
                  TweetCard(index: widget.index, tweet: TweetMain(outerTweet: widget.tweet.innerTweet!, comments: [], images: [], videos: [], likers: []), tweetPage: false, userId: "",realUserId: "",
                    shiftTweets: false,isTweetInner: true,):
                  SizedBox.shrink(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26, right: 15),
                    child: Row(
                      children: [Text(widget.tweet.outerTweet.createdAt)],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26, right: 15),
                    child: const Divider(
                      height: 25,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26, right: 15),
                    child: Row(
                      children: [
                        Text(
                          widget.tweet.outerTweet.retweetCount.toString() + " ",
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
                          widget.tweet.outerTweet.likeCount.toString() + " ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: ()async
                          {
                            // dynamic twet=await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetId(widget.tweet.tweet.tweetId);
                            // setState(() {
                            //   widget.tweet.tweet.likeCount=twet[0].tweet.likeCount;
                            // });
                          },
                          child: Text(
                            "Likes ",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 25,
                    thickness: 1.5,
                  ),
                ],
              ),
          (widget.tweet.innerTweet!=null&&widget.tweetPage==false)?
          TweetCard(index: widget.index, tweet: TweetMain(outerTweet: widget.tweet.innerTweet!, comments: widget.tweet.innerTweet!.comments, images:widget.tweet.innerTweet!.images, videos: widget.tweet.innerTweet!.videos, likers: widget.tweet.innerTweet!.likerIds), tweetPage: false, userId: "",realUserId: "",
              shiftTweets: false,isTweetInner: true,):
          SizedBox.shrink(),
          //here is the TweetBottom bar
          //the row of icons for your reactions on the tweet
          widget.isTweetInner==false?
          widget.shiftTweets==false?
          TweetBottomBar(
            tweet: widget.tweet,
            index: widget.index,
            iconsBoundry: Colors.grey.shade600,
            likeInfoCallBack:toggleTweetsInfo,
          ):
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: TweetBottomBar(
              tweet: widget.tweet,
              index: widget.index,
              iconsBoundry: Colors.grey.shade600,
              likeInfoCallBack:toggleTweetsInfo,
            ),
          ):SizedBox.shrink(),

          //decoration of tweet at the bottom (divider)
          const SizedBox(
            height: 5,
          ),
          //decoration of tweet at the bottom (divider)
          widget.isTweetInner==false?
          const Divider(
            height: 0,
            thickness: 1.5,
          ):SizedBox.shrink(),
        ],
      ):
          //inner tweet look
      ClipRRect(
        child: Padding(
          padding: const EdgeInsets.only(left: 25,right: 25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white60, //New
                      blurRadius: 10,
                      offset: Offset(0, 1))
                ],
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
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
                                  widget.tweet.outerTweet.profilePicUrl,
                                  profilePictureSize: 10),

                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //here is the name and title of the one who tweeted
                                    (widget.isTweetInner==false&&widget.tweet.outerTweet.name!=null)?
                                    Text(widget.tweet.outerTweet.name!, style: boldName):SizedBox.shrink(),
                                    Text(widget.tweet.getusername()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          widget.isTweetInner==false?
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
                          ):SizedBox.shrink()
                        ],
                      ),

                      //--for decoration sized box
                      SizedBox(
                        height: widget.tweetPage==false?10:20,
                      ),
                      //--here is the text of the tweet
                      widget.tweet.outerTweet.text! != ""
                          ? (widget.shiftTweets==false)?Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.tweet.outerTweet.text!,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              //max lines of writing a tweet is 8 like in the main twitter
                              maxLines: 8,
                              style: widget.tweetPage==false?tweetsTexts:innerTweetsTexts,
                            ),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          widget.userId!=""?
                          Padding(padding: EdgeInsets.only(left: 50),
                              child:InkWell(
                                onTap: (){
                                  print(widget.realUserId);
                                  Navigator.of(context).push(
                                    CustomPageRoute(
                                        child: (OthersProfileScreen(
                                            userId: widget.realUserId)),
                                        beginX: 1,
                                        beginY: 0),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text("Replying to  ",style: TextStyle(color: Colors.blueGrey),),
                                    Text(widget.userId,style: TextStyle(color: Colors.blue),),
                                  ],
                                ),
                              )
                          )
                              :
                          SizedBox.shrink(),
                          widget.userId!=""?SizedBox(height: 10,):SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.tweet.outerTweet.text!,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    //max lines of writing a tweet is 8 like in the main twitter
                                    maxLines: 8,
                                    style: widget.tweetPage==false?tweetsTexts:innerTweetsTexts,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                          :const SizedBox.shrink(),
                    ],
                  ),
                ),
                //--for decoration sized box
                const SizedBox(
                  height: 15,
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
                    child: SizedBox.shrink())
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
                  // child: CachedNetworkImage(
                  //   imageUrl: widget.tweet.images[0].url,
                  //   placeholder: (context, url) {
                  //     return CircularProgressIndicator(
                  //       color: Colors.black38,
                  //     );
                  //   },
                  //   errorWidget: (context, url, error) => Text("a7aaa"),
                  // ),
                  child: SizedBox.shrink(),
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
                        children: [Text(widget.tweet.outerTweet.createdAt)],
                      ),
                      const Divider(
                        height: 25,
                        thickness: 1.5,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.tweet.outerTweet.retweetCount.toString() + " ",
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
                            widget.tweet.outerTweet.likeCount.toString() + " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: ()async
                            {
                              // dynamic twet=await Provider.of<TweetsViewModel>(context,listen: false).fetchTweetByTweetId(widget.tweet.tweet.tweetId);
                              // setState(() {
                              //   widget.tweet.tweet.likeCount=twet[0].tweet.likeCount;
                              // });
                            },
                            child: Text(
                              "Likes ",
                              style: TextStyle(color: Colors.grey),
                            ),
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
                (widget.tweet.innerTweet!=null&&widget.tweetPage==false)?
                TweetCard(index: widget.index, tweet: TweetMain(outerTweet: widget.tweet.innerTweet!, comments: [], images: [], videos: [], likers: []), tweetPage: false, userId: "",realUserId: "",
                  shiftTweets: false,isTweetInner: true,):
                SizedBox.shrink(),
                //here is the TweetBottom bar
                //the row of icons for your reactions on the tweet
                widget.isTweetInner==false?
                widget.shiftTweets==false?
                TweetBottomBar(
                  tweet: widget.tweet,
                  index: widget.index,
                  iconsBoundry: Colors.grey.shade600,
                  likeInfoCallBack:toggleTweetsInfo,
                ):
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: TweetBottomBar(
                    tweet: widget.tweet,
                    index: widget.index,
                    iconsBoundry: Colors.grey.shade600,
                    likeInfoCallBack:toggleTweetsInfo,
                  ),
                ):SizedBox.shrink(),

                //decoration of tweet at the bottom (divider)
                const SizedBox(
                  height: 5,
                ),
                //decoration of tweet at the bottom (divider)
                widget.isTweetInner==false?
                const Divider(
                  height: 0,
                  thickness: 1.5,
                ):SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
