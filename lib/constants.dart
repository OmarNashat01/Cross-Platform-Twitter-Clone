import 'package:flutter/material.dart';

bool isMock = true;

// API constants
const String kBaseUrl = '';
const String kMockBaseUrl = '10.0.2.2:8000';

class Auth {
  static String token = '';
  static String refreshToken = '';
  static String userId = '';
  static String email = '';
  static String password = '';
}

class Http {
  static final Http _singleton = Http._internal();

  factory Http() => _singleton;

  Http._internal();

  String getBaseUrl() => isMock == true ? kMockBaseUrl : kBaseUrl;
}

// Profile pictures sizes
const double timelineProfilePicSize = 15;
const double addTweetProfilePicSize = 17;
const double navigationDrawerProfilePicSize = 20;

// Asset paths
const String kLogoPath = 'assets/icons/twitter_logo.svg';
const String kGoogleLogoPath = 'assets/icons/google_logo.svg';
const String squareLogoPath = 'assets/images/square.png';

// Colors
const Color kPrimaryColor = Colors.white;
const Color kOnPrimaryColor = Colors.black;

const Color kInvertedPrimaryColor = Colors.black;
const Color kOnInvertedPrimaryColor = Colors.white;

const Color kSecondaryColor = Color(0xFF1D9BF0);
const Color kOnSecondaryColor = Colors.white;

// TextStyles
const TextStyle tweetsTexts = TextStyle(fontSize: 17, color: Colors.black);
const TextStyle boldName =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
const TextStyle titleName = TextStyle(
  fontSize: 16,
  color: Color(0xff757575),
);
const TextStyle notRetweeted = TextStyle(
  fontSize: 16,
  color: Color(0xff757575),
);
const TextStyle retweeted = TextStyle(
  fontSize: 16,
  color: Colors.green,
);
const TextStyle loved = TextStyle(
  fontSize: 16,
  color: Colors.red,
);

// ReservedTexts
const Text followingString = Text(
  ' Following  ',
  style: titleName,
);
const Text followersString = Text(
  ' Followers  ',
  style: titleName,
);
