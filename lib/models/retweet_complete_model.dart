import 'dart:ui';

import 'package:twitter/models/retweet_model.dart';
import 'package:twitter/models/tweet_model.dart';
class RetweetMain
{
  RetweetMain({required this.retweet, required this.comments,required this.images,required this.videos, required this.likers});
  Retweet retweet;
  List<dynamic>comments;
  List<dynamic>likers;
  List<dynamic>images;
  List<dynamic>videos;
  Color threeDotsColor=const Color(0xffAFD9F4);

}