class Videos
{
  final List<dynamic>videos;
  Videos({required this.videos});
  factory Videos.fromJson(Map<String,dynamic> jsonData)
  {
    return Videos(
      videos: jsonData["videos"],
      //so here my tweets list should have al the tweets as a form of json data
    );
  }
}