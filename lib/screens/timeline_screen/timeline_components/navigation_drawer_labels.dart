import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/constants.dart';
import 'opacity_data.dart';
import 'package:twitter/users/users_data.dart';
//this class is for the navigation drawer details like name ,title ,followers which all has actions on getting pressed
class NavigationDrawerLabels extends StatelessWidget {
  NavigationDrawerLabels({this.widget});
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()//when you press on your name i want to shadow it and (do something)
      {
        Provider.of<OpacityValue>(context,listen: false).setOpacity(0.6);

      },
      onPanStart: (dragDetails)//when you press and drag i want to shadow it only
      {
        Provider.of<OpacityValue>(context,listen: false).setOpacity(0.6);
      },
      onPanEnd : (dragDetails)//when you left your thumb i want to disshadow it
      {
        Provider.of<OpacityValue>(context,listen: false).setOpacity(1);
      },
      child: Opacity(
        opacity: Provider.of<OpacityValue>(context,listen: true).getOpacity(),
        child: widget
      ),
    );
  }
}
