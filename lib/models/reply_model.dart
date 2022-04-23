
class Reply
{
  Reply({required this.userId,required this.username,required this.text});
  String userId;
  String username;
  String text;
  factory Reply.fromJson(Map<String,dynamic> jsonData)
  {
    return Reply(userId:jsonData["user_id"] ,username:jsonData["username"] ,text:jsonData["Text"] );
  }
}