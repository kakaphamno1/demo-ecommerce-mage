import 'dart:ui';

import 'package:flutter/material.dart';

class DarkTheme {
  static String sfUiTEXT = "sfUIText";

  DarkTheme._();

  static const Brightness statusIconColor = Brightness.light;
  static const String fontFamily = "sfUIText";

  static const Color primary = Color(0xFF00683c);
  static const Color secondary = Color(0xFFc67500);
  static const Color danger = Color(0xFFFC5555);
  static const Color action = Color(0xFF3A8CFF);
  static const Color colorPending = const Color(0xFFF6AF36);

  static const Color borderTextField = Color(0xFFE9E9EA);
  static const Color backgroundTextField = Color(0xFFFBFBFB);
  static const Color textColor = Color(0xFFFBFBFB);
  static const Color captionTextColor = Color(0xFFFBFBFB);
  static const Color borderCheckBox = Color(0xFFC8C9CA);
  static const Color appBackground = Color(0xFF24282C);
  static const Color greySeparator = Color(0xFF3E3E3E);
  static const Color comboSaleBackground = Color(0xFF30a271);
  static const Color appBackground_2 = Color(0xFF3A3D44);
  static const Color homeBackground = Color(0xFF24282C);
  static const Color  itemBackground = Color(0xFF3A3D44);

  static MaterialColor AppDark = MaterialColor(
    0xFFC8C9CA,
    <int, Color>{
      900: Color(0xFFFFFFFF),
      800: Color(0xFFFBFBFB),
      700: Color(0xFFF4F4F4),
      600: Color(0xFFE9E9EA),
      500: Color(0xFFC8C9CA),
      400: Color(0xFF919395),
      300: Color(0xFF5B5E61),
      200: Color(0xFF3A3E41),
      100: Color(0xFF24282C),
    },
  );

}
