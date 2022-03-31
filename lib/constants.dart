import 'package:flutter/material.dart';

//profile pictures sizes
const double timelineProfilePicSize=15;
const double navigationDrawerProfilePicSize=27;
// asset paths
const String kLogoPath = 'assets/icons/logo.svg';
const String myProfilePicturePath='assets/profiles/profilepic.jpeg';
const String squareLogoPath='assets/profiles/square.png';
// Colors
const Color kPrimaryColor = Color(0xFF1D9BF0);

//textStyles
const TextStyle boldName=TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black
);
const TextStyle titleName=TextStyle(
    fontSize: 16,
    color: Colors.grey
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