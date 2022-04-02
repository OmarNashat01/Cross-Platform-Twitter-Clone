import 'package:flutter/material.dart';
import 'package:twitter/screens/timeline_screen/timeline.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import 'package:twitter/screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
class ProfileScreen extends StatelessWidget {
  static const routeName = 'profile-screen';
  final controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //here a nested scroll view widget needs ti be done

      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller:controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>[
    SliverAppBar(),
    ] ,

        body: Center(
          child: const Text(
              'Profile Screen',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
      bottomNavigationBar:TimelineBottomBar(controller:controller),
    );
  }
}
