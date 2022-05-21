
import 'package:flutter/material.dart';
class CustomPageRoute extends PageRouteBuilder
{
  //--------------------------------------------
  //x=1,y=0-> from right to left
  //x=-1,y=0-> from left to right
  //x=0,y=1-> from down to up
  //x=0,y=-1->from up to down
  final double beginX;
  final double beginY;
  //--------------------------------------------
 final Widget child;
 CustomPageRoute({required this.child,required this.beginX,required this.beginY}):
 super(
       transitionDuration:  const Duration(milliseconds:150),
       reverseTransitionDuration:  const Duration(milliseconds: 150),
       pageBuilder:(context,animation,secondaryAnimation)=>child,
     );
 @override
 Widget buildTransitions(BuildContext, Animation<double>animation, Animation<double>secondaryAnimation, Widget child)=>
     SlideTransition(
         position: Tween<Offset>(
           begin: Offset(beginX,beginY),
         end: const Offset(0,0),
         ).animate(animation),
         child: child

     ,);

}