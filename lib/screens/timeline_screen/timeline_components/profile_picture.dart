import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitter/constants.dart';


class ProfilePicture extends StatelessWidget {
  @override
  const ProfilePicture({
    required this.profilePictureFunctionality,
    required this.profilePictureImage,
    required this.profilePictureSize,
  });
  final void Function() profilePictureFunctionality;
  final String profilePictureImage;
  final double profilePictureSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: profilePictureFunctionality,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 0.5, color: Colors.grey, spreadRadius: 0.4)
          ],
        ),
        child: CircleAvatar(
          radius: profilePictureSize,
          backgroundImage: NetworkImage(profilePictureImage),
        ),
      ),
    );
  }
}
