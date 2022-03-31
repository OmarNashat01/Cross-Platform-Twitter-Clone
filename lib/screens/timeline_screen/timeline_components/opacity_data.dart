import 'package:flutter/material.dart';
class OpacityValue extends ChangeNotifier
{
  OpacityValue({ this.opacity=1});
   double opacity;
  void setOpacity(double opacityy)
  {
    opacity=opacityy;
    notifyListeners();
  }
  double getOpacity()
  {
    print(opacity);
    return opacity;
  }

}