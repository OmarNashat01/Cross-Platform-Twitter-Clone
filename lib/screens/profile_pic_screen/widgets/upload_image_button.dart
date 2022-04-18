
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:twitter/constants.dart';

import '../../../constants.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
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
            ),
          ),
        ),
      );
  }
}
