class Replies
{
  final List<dynamic>replies;
  Replies({required this.replies});
  factory Replies.fromJson(Map<String,dynamic> jsonData)
  {
    return Replies(
      replies: jsonData["replies"],
      //so here my tweets list should have al the tweets as a form of json data
    );
  }
}