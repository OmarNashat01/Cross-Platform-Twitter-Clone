import 'package:flutter/material.dart';
import 'package:twitter/constants.dart';
class ProfilePicture extends StatelessWidget {
  @override
  ProfilePicture({required this.profilePictureFunctionality,required this.profilePicturePath,required this.profilePictureSize});
  final void Function() profilePictureFunctionality;
  final String profilePicturePath;
  final double profilePictureSize;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: profilePictureFunctionality,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.grey, spreadRadius: 0.4)],
        ),
        child: CircleAvatar(
          radius: profilePictureSize,
          backgroundImage: const AssetImage('assets/icons/profilepic.jpeg'),
        ),
      ),
    );
  }
}

