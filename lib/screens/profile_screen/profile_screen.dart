import 'package:flutter/material.dart';
import '../timeline_screen/timeline_screen.dart';
import '../../screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';
import '../../screens/timeline_screen/timeline_components/timeline_bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //here a nested scroll view widget needs ti be done

      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(),
        ],
        body: const Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
      bottomNavigationBar: TimelineBottomBar(controller: controller),
    );
  }
}
