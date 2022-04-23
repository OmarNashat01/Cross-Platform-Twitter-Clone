import 'package:twitter/models/image_model.dart';
class Images
{
  final List<dynamic>images;
  Images({required this.images});
  factory Images.fromJson(Map<String,dynamic> jsonData)
  {
    return Images(
      images: jsonData["images"],
      //so here my tweets list should have al the tweets as a form of json data
    );
  }
}