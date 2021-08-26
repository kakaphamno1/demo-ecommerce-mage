import 'dart:ui';

import 'package:flutter/material.dart';

class LightTheme {

  LightTheme._();
  static const Brightness statusIconColor = Brightness.dark;
  static const String fontFamily  = "sfUIText";

  static const Color primary = Color(0xFF1CA275);
  static const Color secondary = Color(0xFFFFA400);
  static const Color danger = Color(0xFFFC5555);
  static const Color action = Color(0xFF3A8CFF);

  static const Color borderTextField = Color(0xFFE9E9EA);
  static const Color backgroundTextField = Color(0xFFFBFBFB);
  static const Color textColor = Color(0xFF24282C);
  static const Color captionTextColor = Color(0xFF5B5E61);

  static const Color borderCheckBox = Color(0xFFC8C9CA);
  static const Color appBackground = Color(0xFFFFFFFF);
  static const Color greySeparator = Color(0xFFE9E9E9);
  static const Color comboSaleBackground = Color(0xFFF5FCF9);
  static const Color appBackground_2 = Color(0xFFFBFBFB);
  static const Color homeBackground = Color(0xFFFBFBFB);
  static const Color itemBackground = Color(0xFFFFFFFF);
  static const Color colorPending = const Color(0xFFF6AF36);

  static MaterialColor AppDark = MaterialColor(
    0xFFC8C9CA,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFBFBFB),
      300: Color(0xFFF4F4F4),
      400: Color(0xFFE9E9EA),
      500: Color(0xFFC8C9CA),
      600: Color(0xFF919395),
      700: Color(0xFF5B5E61),
      800: Color(0xFF3A3E41),
      900: Color(0xFF24282C),
    },
  );



}
