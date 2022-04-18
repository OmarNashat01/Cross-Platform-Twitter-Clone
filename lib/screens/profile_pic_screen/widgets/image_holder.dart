import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:twitter/constants.dart';

import 'upload_image_button.dart';

import '../../../providers/user_provider.dart';
import '../../../constants.dart';

class ImageHolder extends StatelessWidget {
  const ImageHolder({Key? key}) : super(key: key);

  void _selectImageFromGalary(context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    Provider.of<UserProvider>(context, listen: false)
        .setProfilePic(pickedImage!.path);
    Navigator.pop(context);
  }

  void _selectImageFromCamera(context) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    Provider.of<UserProvider>(context, listen: false)
        .setProfilePic(pickedImage!.path);
    Navigator.pop(context);
  }

  void _chooseImageOption(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Builder(builder: (context) {
          return SizedBox(
            height: 100,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => _selectImageFromCamera(context),
                  child: const Text('Take photo'),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    primary: kInvertedPrimaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectImageFromGalary(context),
                  child: const Text('Choose existing photo'),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    primary: kInvertedPrimaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _chooseImageOption(context),
      child: Consumer<UserProvider>(
        builder: (context, user, child) => Column(
          children: [
            const SizedBox(height: 25),
            user.profilePic.isEmpty
                ? const UploadImageButton()
                : CircleAvatar(
                    radius: 80,
                    child: ClipOval(
                      child: Image.file(
                        File(user.profilePic),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
