
class Comment
{
  Comment({required this.userId,required this.username,required this.text,required this.profilePicUrl,required this.createdAt,required this.repliesList});
  String userId;
  String username;
  String profilePicUrl;
  String text;
  String createdAt;
  List<dynamic>repliesList;
  factory Comment.fromJson(Map<String,dynamic> jsonData)
  {
    return Comment(userId:jsonData["user_id"] ,username:jsonData["username"] ,profilePicUrl:jsonData["prof_pic_url"] ,text:jsonData["text"],createdAt: jsonData["created_at"],repliesList: jsonData["replies"] );
  }
}