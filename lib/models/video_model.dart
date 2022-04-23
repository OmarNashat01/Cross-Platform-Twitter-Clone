
class Video
{
  Video({required this.url,required this.altText,required this.height,required this.width});
  String url;
  String altText;
  int height;
  int width;
  factory Video.fromJson(Map<String,dynamic> jsonData)
  {
    return Video(url:jsonData["url"] ,altText:jsonData["alt_text"] ,height:jsonData["height"] ,width:jsonData["width"] );
  }
}