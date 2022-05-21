
import 'package:flutter/material.dart';

class ImageVideoDetailsProvider extends ChangeNotifier
{
  bool upperLowerDetails=true;

  void hideUpperLowerDetails()
  {
    upperLowerDetails=false;
    notifyListeners();
  }
  void showUpperLowerDetails()
  {
    upperLowerDetails=true;
    notifyListeners();
  }

}
