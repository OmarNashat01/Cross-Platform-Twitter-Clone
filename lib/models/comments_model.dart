import 'package:twitter/models/comment_model.dart';
class Comments
{
  final List<dynamic>comments;
  Comments({required this.comments});
  factory Comments.fromJson(Map<String,dynamic> jsonData)
  {
    return Comments(
      comments: jsonData["comments"],
      //so here my tweets list should have al the tweets as a form of json data
    );
  }
}