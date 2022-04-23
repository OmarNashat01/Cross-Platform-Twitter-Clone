
class Image
{
  Image({required this.url,required this.altText,required this.height,required this.width});
  String url;
  String altText;
  int height;
  int width;
  factory Image.fromJson(Map<String,dynamic> jsonData)
  {
    return Image(url:jsonData["url"] ,altText:jsonData["alt_text"] ,height:jsonData["height"] ,width:jsonData["width"] );
  }
}