import 'package:flutter/material.dart';

const Map<int, Color> color = {
  50: Color.fromRGBO(215, 52, 56, .1),
  100: Color.fromRGBO(215, 52, 56, .2),
  200: Color.fromRGBO(215, 52, 56, .3),
  300: Color.fromRGBO(215, 52, 56, .4),
  400: Color.fromRGBO(215, 52, 56, .5),
  500: Color.fromRGBO(215, 52, 56, .6),
  600: Color.fromRGBO(215, 52, 56, .7),
  700: Color.fromRGBO(215, 52, 56, .8),
  800: Color.fromRGBO(215, 52, 56, .9),
  900: Color.fromRGBO(215, 52, 56, 1),
};
MaterialColor colorCustom = MaterialColor(0xFFD73438, color);

class GlobalColors {
  static MaterialColor materialColor = colorCustom;

  static const themeColor = Color.fromRGBO(215, 52, 56, 1);
  static const themeColor2 = Color.fromARGB(255, 135, 132, 132);
  static const textColor = Color(0xFF2B2D39);

  static const white = Color.fromARGB(255, 255, 255, 255);
  static const black = Color.fromARGB(255, 0, 0, 0);
}
