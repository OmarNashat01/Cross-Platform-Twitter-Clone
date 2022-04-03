import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

class CustomeAppBars {
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
