import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:image_picker/image_picker.dart';
import 'package:twitter/constants.dart';

import '../../../providers/user_provider.dart';
import '../../../constants.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({Key? key}) : super(key: key);

  void _selectImage(context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    Provider.of<UserProvider>(context, listen: false).profilePic =
        pickedImage!.path;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectImage(context),
      child: Column(
        children: [
          const SizedBox(height: 25),
          DottedBorder(
            dashPattern: const [10, 10],
            strokeWidth: 3,
            color: kSecondaryColor,
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: SizedBox(
                  height: 160,
                  width: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.camera_enhance,
                        color: kSecondaryColor,
                        size: 55,
                      ),
                      Text(
                        'Upload',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
