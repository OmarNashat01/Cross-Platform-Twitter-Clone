import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

/// Switch variable to toggle between using mock backend service or the real backend
bool isMock = false;

/// Switch variable to toggle between hasing the password or not
bool isPasswordHashed = false;

/// Base URL of the real backend
const String kBaseUrl = '45.79.245.94:5000'; // without https:// or http://

/// Mock server base URL
const String kMockBaseUrl = '10.0.2.2:8000';
const String backendUrl = "http://45.79.245.94:5000";
const String androidMobileBaseUrl = "http://192.168.1.8:8000";

/// Contains all needed globals across the application navigation after logging in
class Auth {
  static String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MjY1NTFmNDRkNTc4NmY0MzdjYmIyNWIiLCJhZG1pbiI6ZmFsc2UsImV4cCI6MTY4NDc5MDMxNH0.axaRtOFjFV9lMF0WjfRhjmuVp5adpJo9dZZ4SGjlaws';
  // static String refreshToken = '';
  static String userId = '626551f44d5786f437cbb25b';
  static String email = '';
  static String password = '';
  static String profilePicUrl =
      "https://c8.alamy.com/comp/2C5BXFW/robot-cartoon-id-profile-3d-illustration-2C5BXFW.jpg";
  static String username = 'abdallah';
  static String name = 'abdallah__fawzy';
  static String bio = "hello everyone";
}

/// Singlton class that gives you access to Base URLs
class Http {
  static final Http _singleton = Http._internal();
  factory Http() => _singleton;
  Http._internal();
  String getBaseUrl() => isMock == true ? kMockBaseUrl : kBaseUrl;
  String getMobileBaseUrl() =>
      isMock == true ? "192.168.1.8:8000" : kMockBaseUrl;
  String getBackendBaseUrl() => "45.79.245.94:5000";
}

/// Used to hash the user's password via MD5
String hashToMd5(String pass) =>
    isPasswordHashed ? md5.convert(utf8.encode(pass)).toString() : pass;

// Profile pictures sizes
const double timelineProfilePicSize = 15;
const double addTweetProfilePicSize = 17;
const double navigationDrawerProfilePicSize = 20;

const String kDefaultPictureUrl =
    'https://pbs.twimg.com/media/EEI178KWsAEC79p.jpg';

// Asset paths
const String kLogoPath = 'assets/icons/twitter_logo.svg';
const String kGoogleLogoPath = 'assets/icons/google_logo.svg';
const String squareLogoPath = 'assets/images/square.png';

/// Colors
const Color kPrimaryColor = Colors.white;
const Color kOnPrimaryColor = Colors.black;

const Color kInvertedPrimaryColor = Colors.black;
const Color kOnInvertedPrimaryColor = Colors.white;

const Color kSecondaryColor = Color(0xFF1D9BF0);
const Color kOnSecondaryColor = Colors.white;

const Color kWarningColor = Color.fromARGB(255, 206, 55, 44);

// TextStyles
const TextStyle tweetsTexts = TextStyle(fontSize: 17, color: Colors.black);
const TextStyle innerTweetsTexts = TextStyle(
    fontSize: 23, color: Colors.black, fontFamily: "Cormorant Garamond");
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

const TextStyle bio_boldName =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
const TextStyle bio_titleName =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
const TextStyle header_titleName =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
const TextStyle bio_UserName = TextStyle(
  fontSize: 14,
  color: Color(0xff757575),
);
