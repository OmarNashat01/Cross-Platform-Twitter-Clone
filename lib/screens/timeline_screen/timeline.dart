import 'package:flutter/material.dart';
import 'package:twitter/constants.dart';
import 'timeline_components/profile_image.dart';

// ignore_for_file: prefer_const_constructors
class Timeline extends StatefulWidget {
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<String> test = [
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'hello',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
    'a7a',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //here i make twitter own app bar which appears and disappears depending on user scrolling
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              //floating is true to make twitter app bar to appear when scroll up
              floating: true,
              snap: false,
              centerTitle: true,
              title: Row(
                children: [
                  CircleAvatar(
                    child: ClipRect(
                      child: Image.network(
                          'https://miro.medium.com/max/500/1*zzo23Ils3C0ZDbvZakwXlg.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ],
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 18),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(test[index]),
              );
            },
            itemCount: test.length,
          ),
        ),
      ),
    );
  }
}
