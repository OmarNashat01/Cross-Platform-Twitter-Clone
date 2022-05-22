import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/comments_provider.dart';
import 'package:twitter/providers/image_videos_details_provider.dart';
import 'package:twitter/providers/list_view_tweet_provider.dart';
import 'package:twitter/providers/notifications_provider.dart';
import 'package:twitter/providers/timeline_provider.dart';
import 'package:twitter/providers/tweets_view_model.dart';
import 'package:twitter/providers/ui_colors_provider.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/providers/video_provider.dart';
import 'package:twitter/screens/notifications_screen/NotificationsScreen.dart';
import 'package:twitter/screens/timeline_screen/timeline_screen.dart';

import 'providers/user_provider.dart';
// Other imports
import 'routes.dart';

void main() => runApp(TwitterApp());

class TwitterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      // Add providers as needed
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TweetsViewModel()),
        ChangeNotifierProvider(create: (context) => TimelineProvider()),
        ChangeNotifierProvider(create: (context) => UIColorProvider()),
        ChangeNotifierProvider(create: (context) => ListViewTweetProvider()),
        ChangeNotifierProvider(create: (context) => VideoPlayerProvider()),
        ChangeNotifierProvider(
            create: (context) => ImageVideoDetailsProvider()),
        ChangeNotifierProvider(create: (context) => CommentsProvider()),
        //ChangeNotifierProvider(create: (context) => StreamControllerProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider())
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter',
        theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          highlightColor: const Color(0xff757575),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Color(0xFF1D9BF0),
            onSecondary: Colors.white,
            error: Colors.white,
            onError: Colors.redAccent,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        home: TimelineScreen(firstTime: true,),
        routes: routes,
      ),
    );
  }
}
