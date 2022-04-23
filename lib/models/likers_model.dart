
class Likers
{
  final List<dynamic>likers;
  Likers({required this.likers});
  factory Likers.fromJson(Map<String,dynamic> jsonData)
  {
    return Likers(
      likers: jsonData["liker_ids"],
      //so here my tweets list should have al the tweets as a form of json data
    );
  }
}