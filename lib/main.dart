import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/dummy/timeline_list.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/screens/bio_screen/bio_screen.dart';
import 'package:twitter/screens/login_email_screen/login_email_screen.dart';
import 'package:twitter/screens/password_screen/password_screen.dart';
import 'package:twitter/screens/profile_pic_screen/profile_pic_screen.dart';
import 'package:twitter/screens/profile_pic_screen/widgets/image_holder.dart';
import 'package:twitter/screens/signup_screen/signup_screen.dart';
import 'package:twitter/screens/username_screen/username_screen.dart';

import 'screens/welcome_screen/welcome_screen.dart';
import 'screens/timeline_screen/timeline_screen.dart';
import 'screens/profile_screen/profile_screen.dart';

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
        ChangeNotifierProvider(create: (context) => TimelineList()),
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
        home: TimelineScreen(),
        routes: routes,
      ),
    );
  }
}
