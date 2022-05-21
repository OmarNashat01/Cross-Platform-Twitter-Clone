
class Likers
{
  Likers({required this.date,required this.likerId});
  String date;
  String likerId;
  factory Likers.fromJson(Map<String,dynamic> jsonData)
  {
    return Likers(date:jsonData["date"] ,likerId:jsonData["liker"]);
  }
}