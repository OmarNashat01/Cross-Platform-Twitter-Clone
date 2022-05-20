
class Tweets
{
  Map<String,dynamic>  tweets;
  Tweets({required this.tweets});
  factory Tweets.fromJson(Map<String,dynamic> jsonData)
  {
    return Tweets(
      tweets: jsonData["tweets"],
      //so here my tweets list should have al the tweets as a form of json data
    );
  }
}