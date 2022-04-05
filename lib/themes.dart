import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

// =============== App bars ===============
class CustomAppBars {
  static AppBar welcomeAppBar = AppBar(
    centerTitle: true,
    title: SvgPicture.asset(
      kLogoPath,
      color: kSecondaryColor,
      width: 20,
      height: 20,
    ),
  );
}

// =============== Button Styles ===============
class CustomButtons {
  static ButtonStyle blueButton({bool isFit = true}) {
    return ElevatedButton.styleFrom(
      primary: kSecondaryColor,
      onPrimary: kOnSecondaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      shadowColor: Colors.white,
      minimumSize: Size(isFit ? 0 : double.infinity, 40),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static ButtonStyle whiteButton({bool isFit = true}) {
    return OutlinedButton.styleFrom(
      primary: kInvertedPrimaryColor,
      onSurface: kOnInvertedPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      minimumSize: Size(isFit ? 0 : double.infinity, 40),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static ButtonStyle blackButton({bool isFit = true}) {
    return ElevatedButton.styleFrom(
      primary: kInvertedPrimaryColor,
      onPrimary: kOnInvertedPrimaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      shadowColor: Colors.white,
      minimumSize: Size(isFit ? 0 : double.infinity, 40),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
