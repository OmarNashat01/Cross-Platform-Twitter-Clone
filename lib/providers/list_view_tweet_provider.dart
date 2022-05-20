
import 'package:flutter/material.dart';

class ListViewTweetProvider extends ChangeNotifier
{
  int index=0;
  void changeTweetIndex()
  {
    index=1;
    notifyListeners();
  }


}
