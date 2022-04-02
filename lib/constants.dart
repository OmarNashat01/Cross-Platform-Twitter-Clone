import 'package:flutter/material.dart';

//profile pictures sizes
const double timelineProfilePicSize=15;
const double navigationDrawerProfilePicSize=27;
// asset paths
const String kLogoPath = 'assets/icons/twitter_logo.svg';
const String kGoogleLogoPath = 'assets/icons/google_logo.svg';

// Colors
const Color kPrimaryColor = Colors.white;
const Color kSecondaryColor = Color(0xFF1D9BF0);
const String myProfilePicturePath='assets/images/profilepic.jpeg';
const String squareLogoPath='assets/images/square.png';
// const Color kPrimaryColor = Color(0xFF1D9BF0);

//textStyles
const TextStyle boldName=TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black
);
const TextStyle titleName=TextStyle(
    fontSize: 16,
    color: Color(0xff757575),
);

//reservedTexts
const Text followingString=Text(
  ' Following  ',
  style:titleName,
);
const Text followersString=Text(
  ' Followers  ',
  style:titleName,
);
