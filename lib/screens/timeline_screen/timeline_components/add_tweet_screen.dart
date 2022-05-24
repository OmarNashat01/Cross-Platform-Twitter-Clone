import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'package:twitter/models/tweet_complete_model.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/profile_picture.dart';

class AddTweetScreen extends StatefulWidget {
  AddTweetScreen(
      {required this.hintText,
      required this.tweetOrReply,
      this.replying,
      this.name,this.tweet});
  String? name;
  String hintText;
  String tweetOrReply;
  bool? replying = false;
  TweetMain? tweet;

  @override
  State<AddTweetScreen> createState() => _AddTweetScreenState();
}

class _AddTweetScreenState extends State<AddTweetScreen> {
  String? title;
  List<XFile> imageFileList = [];
  String text = "No Value Entered";
  double height=200;
  List<String>imagesPaths=[];
  void selectImages() async {
    final dynamic selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null) {
      for(int i=0;i<selectedImages.length;i++)
        {
          imagesPaths.add(selectedImages[i].path);
        }
      imageFileList.addAll(selectedImages);
    }
    setState(() {
      // file=File(myFile.path);
    });
  }

  Future cameraPicker() async {
    dynamic myFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFileList.add(myFile);
      imagesPaths.add(myFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //here a nested scroll view widget needs ti be done
        appBar: AppBar(
          elevation: widget.replying == true ? 1 : 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              SizedBox(
                width: 75,
                child: TextButton(
                  onPressed: () async {
                    text = title!;
                    List parts = [];
                    var image1 = [];
                    var video1 = [];
                    int c = 0;
                    int idx = text.indexOf(":");
                    int idx2 = text.indexOf("-");
                    for (int i = 0; i < text.length; i++) {
                      if (text[i] == ':') {
                        c = 1;
                        parts = [
                          text.substring(0, idx).trim(),
                          text.substring(idx + 1).trim()
                        ];
                        image1 = [
                          {
                            "url": parts[1],
                            "alt_text": "7:45 pm",
                            "height": 0,
                            "width": 0
                          }
                        ];
                        break;
                      }
                      if (text[i] == '-') {
                        c = 1;
                        parts = [
                          text.substring(0, idx2).trim(),
                          text.substring(idx2 + 1).trim()
                        ];
                        video1 = [
                          {
                            "url": parts[1],
                            "alt_text": "7:45 pm",
                            "height": 0,
                            "width": 0
                          }
                        ];
                        break;
                      }
                    }
                    if (c == 0) {
                      parts.add(text);
                      video1 = [];
                    }
                    var now = DateTime.now();
                    var formatter = DateFormat('yyyy-MM-dd');
                    String formattedDate = formatter.format(now);
                    //if i am adding a tweet from scratch do this without showing the inner tweet
                    if(widget.tweetOrReply=="tweet") {
                      await Provider.of<TweetsViewModel>(context, listen: false)
                          .addTweet(
                          text: parts[0], images: imagesPaths, videos: video1);
                      await Provider.of<TweetsViewModel>(context, listen: false)
                          .getAddedTweet(context);
                    }
                    else
                      {
                        await Provider.of<TweetsViewModel>(context, listen: false)
                            .addComment(
                            text: parts[0], images: imagesPaths, videos: video1,tweetId:widget.tweet!.tweet.tweetId,context: context);
                        setState(() {
                          widget.tweet!.tweet.commentCount++;
                        });                      }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(milliseconds: 1000),
                      backgroundColor: const Color(0xffE8F5FD),
                      content: Padding(
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 3, right: 3),
                        child: Row(
                          children: const [
                            Icon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: 20,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "your Tweet was sent",
                              style: TextStyle(
                                color: Color(0xff636E74),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 220,
                          right: 20,
                          left: 20),
                    ));
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade600),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: Text(
                    widget.tweetOrReply,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(physics: const BouncingScrollPhysics(), children: [
          Column(
            children: [
              widget.replying == true
                  ? Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 32, bottom: 3),
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 32),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Replying to ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      widget.name!,
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ProfilePicture(
                        profilePictureFunctionality: () {},
                        profilePictureImage: Auth.profilePicUrl,
                        profilePictureSize: navigationDrawerProfilePicSize),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                            ),
                            autofocus: true,
                            showCursor: true,
                            cursorHeight: 20,
                            cursorColor: Colors.blue[600],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (value) => title = value,
                          ),
                          // file==null?SizedBox.shrink():Image.file(file)
                          SizedBox(
                            height: imageFileList.length>1?230:400,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: imageFileList.length,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.file(File(
                                                imageFileList[index].path))),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 20,
                                        child: CircleAvatar(
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                                size: 17,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  imageFileList.removeAt(index);
                                                });
                                              }),
                                          backgroundColor: Colors.black54,
                                          radius: 17,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          )

                          //here will be the difference as if i qoute a tweet i will have the other user tweet here to quote it
                          // TweetCard(index:index!)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
        bottomSheet: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 32,
              color: Color(0xffE3E6E8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      cameraPicker();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.image,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      selectImages();
                    },
                  ),
                ],
              ),
            )));
  }
}
