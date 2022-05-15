import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

/// Custom app bar widgets
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

/// Collection of buttons that are used across the app
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

/// Collection of text fields used
// =============== Field Styles ===============
class FieldDecorations {
  static InputDecoration normal(String hint) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      hintText: hint,
      counterStyle: const TextStyle(fontSize: 16),
    );
  }

  static InputDecoration abnormal() {
    return const InputDecoration(
      focusedBorder:  UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      enabled: false,
      counterStyle: TextStyle(fontSize: 16),
    );
  }

  static InputDecoration normalWithPrefix(String hint, String prefixText) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      hintText: hint,
      prefix: Text(prefixText),
      counterStyle: const TextStyle(fontSize: 16),
    );
  }

  static InputDecoration normalWithIcon(String hint, IconButton icon) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      hintText: hint,
      counterStyle: const TextStyle(fontSize: 16),
      suffixIcon: icon
    );
  }

  static InputDecoration normalWithIconAndLabel(String label, String hint, IconButton icon) {
    return InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: kSecondaryColor,
          width: 3,
        ),
      ),
      // label: Text(label),
      hintText: hint,
      labelText: label,
      labelStyle: const TextStyle(fontSize: 20, color: kOnPrimaryColor),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      counterStyle: const TextStyle(fontSize: 16),
      suffixIcon: icon
    );
  }
  
}

class AppColor {
  static const Color primary = Color(0xff1DA1F2);
  static const Color secondary = Color(0xff14171A);
  static const Color darkGrey = Color(0xff1657786);
  static const Color lightGrey = Color(0xffAAB8C2);
  static const Color extraLightGrey = Color(0xffE1E8ED);
  static const Color extraExtraLightGrey = Color(0xfF5F8FA);
  static const Color white = Color(0xFFffffff);
}

class TwitterColor {
  static Color bondiBlue = const Color.fromRGBO(0, 132, 180, 1.0);
  static Color cerulean = const Color.fromRGBO(0, 172, 237, 1.0);
  static Color spindle = const Color.fromRGBO(192, 222, 237, 1.0);
  static Color white = const Color.fromRGBO(255, 255, 255, 1.0);
  static Color black = const Color.fromRGBO(0, 0, 0, 1.0);
  static Color woodsmoke = const Color.fromRGBO(20, 23, 2, 1.0);
  static Color woodsmoke_50 = const Color.fromRGBO(20, 23, 2, 0.5);
  static Color mystic = const Color.fromRGBO(230, 236, 240, 1.0);
  static Color dodgetBlue = const Color.fromRGBO(29, 162, 240, 1.0);
  static Color dodgetBlue_50 = const Color.fromRGBO(29, 162, 240, 0.5);
  static Color paleSky = const Color.fromRGBO(101, 119, 133, 1.0);
  static Color ceriseRed = const Color.fromRGBO(224, 36, 94, 1.0);
  static Color paleSky50 = const Color.fromRGBO(101, 118, 133, 0.5);
}