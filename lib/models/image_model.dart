
class Imagei
{
  Imagei({required this.url,required this.altText,required this.height,required this.width});
  String url;
  String altText;
  int height;
  int width;
  factory Imagei.fromJson(Map<String,dynamic> jsonData)
  {
    return Imagei(url:jsonData["url"] ,altText:jsonData["alt_text"] ,height:jsonData["height"] ,width:jsonData["width"] );
  }
}