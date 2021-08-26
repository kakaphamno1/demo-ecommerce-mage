import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:magento2_app/res/themes/dark_theme.dart';
import 'package:magento2_app/res/themes/light_theme.dart';

class AppThemes {
  final String _sThemeModeKey = 'S_THEME_MODE_KEY';
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';
  static String Poppins = "Poppins";
  static String Roboto = "Roboto";
  static const roundedBorderDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        const Radius.circular(8.0),
      ));
  static const roundedButton = BoxDecoration(
      color: const Color(0xFF289767),
      borderRadius: BorderRadius.all(
        const Radius.circular(12.0),
      ));

  static BoxDecoration roundedBorderDecorationTab = BoxDecoration(
      border: Border.all(width: 0.5, color: ThemeColor.AppPrimary[500]!),
      color: ThemeColor.AppPrimary[500],
      borderRadius: BorderRadius.all(Radius.circular(8)));

  static ThemeData themeData = lightTheme();

  static String? fontFamily;

  static const EdgeInsets edgeLeft = EdgeInsets.fromLTRB(16, 0, 0, 0);
  static const EdgeInsets edgeLeft8 = EdgeInsets.fromLTRB(8, 0, 0, 0);
  static const EdgeInsets edgeRight = EdgeInsets.fromLTRB(0.0, 0, 16, 0);
  static const EdgeInsets edgeTop = EdgeInsets.fromLTRB(0.0, 16, 0, 0);
  static const EdgeInsets edgeTop8 = EdgeInsets.fromLTRB(0.0, 8, 0, 0);
  static const EdgeInsets edgeTop4 = EdgeInsets.fromLTRB(0.0, 4, 0, 0);
  static const EdgeInsets edgeBottom = EdgeInsets.fromLTRB(0, 0, 0, 16);
  static const EdgeInsets edgeAll = EdgeInsets.fromLTRB(16, 16, 16, 16);
  static const EdgeInsets edgeAll4 = EdgeInsets.fromLTRB(4, 4, 4, 4);
  static const EdgeInsets edgeAll6 = EdgeInsets.fromLTRB(6, 6, 6, 6);
  static const EdgeInsets edgeAll8 = EdgeInsets.fromLTRB(8, 8, 8, 8);
  static const EdgeInsets edgeAll12 = EdgeInsets.fromLTRB(12, 12, 12, 12);
  static const EdgeInsets edgeLR12 = EdgeInsets.fromLTRB(12, 0, 12, 0);
  static const EdgeInsets edgeLRB = EdgeInsets.fromLTRB(16, 0, 16, 16);
  static const EdgeInsets edgeLRT = EdgeInsets.fromLTRB(16, 16, 16, 0);
  static const EdgeInsets edgeLR8T = EdgeInsets.fromLTRB(16, 16, 8, 0);
  static const EdgeInsets edgeL8RT = EdgeInsets.fromLTRB(8, 16, 16, 0);
  static const EdgeInsets edgeLT = EdgeInsets.fromLTRB(16, 16, 0, 0);
  static const EdgeInsets edgeTR = EdgeInsets.fromLTRB(0, 16, 16, 0);
  static const EdgeInsets edgeLR16Top8 = EdgeInsets.fromLTRB(16, 8, 16, 0);
  static const EdgeInsets edgeLR16BT4 = EdgeInsets.fromLTRB(16, 4, 16, 4);
  static const EdgeInsets edgeLR16Top12 = EdgeInsets.fromLTRB(16, 12, 16, 0);
  static const EdgeInsets edgeLR16BottomTop12 = EdgeInsets.fromLTRB(16, 12, 16, 12);
  static const EdgeInsets edgeStart = EdgeInsets.fromLTRB(16, 12, 16, 16);
  static const EdgeInsets edgeLeftRight = EdgeInsets.fromLTRB(16, 0, 16, 0);
  static const EdgeInsets edgeLeftRight8 = EdgeInsets.fromLTRB(8, 0, 8, 0);
  static const EdgeInsets edgeTopBottom8 = EdgeInsets.fromLTRB(0, 8, 0, 8);
  static const EdgeInsets edgeTopBottom16 = EdgeInsets.fromLTRB(0, 16, 0, 16);
  static const EdgeInsets edgeLeftRight16BottomTop8 = EdgeInsets.fromLTRB(16, 8, 16, 8);
  static const EdgeInsets edgeLeft16BottomTop8 = EdgeInsets.fromLTRB(16, 8, 0, 8);

  /// LIGHT THEME
  static ThemeData lightTheme() {
    ThemeColor.statusIconColor = LightTheme.statusIconColor;
    ThemeColor.primary = LightTheme.primary;
    ThemeColor.secondary = LightTheme.secondary;
    ThemeColor.danger = LightTheme.danger;
    ThemeColor.action = LightTheme.action;
    ThemeColor.borderTextField = LightTheme.borderTextField;
    ThemeColor.backgroundTextField = LightTheme.backgroundTextField;
    ThemeColor.textColor = LightTheme.textColor;
    ThemeColor.borderCheckBox = LightTheme.borderCheckBox;
    ThemeColor.appBackground = LightTheme.appBackground;
    ThemeColor.greySeparator = LightTheme.greySeparator;
    ThemeColor.captionTextColor = LightTheme.captionTextColor;
    ThemeColor.comboSaleBackground = LightTheme.comboSaleBackground;
    ThemeColor.appBackground_2 = LightTheme.appBackground_2;
    ThemeColor.homeBackground = LightTheme.homeBackground;
    ThemeColor.itemBackground = LightTheme.itemBackground;
    ThemeColor.colorPending = LightTheme.colorPending;

    ThemeColor.AppDark = LightTheme.AppDark;

    return themeData;
  }

  /// DARK THEME
  static ThemeData darkTheme() {
    ThemeColor.statusIconColor = DarkTheme.statusIconColor;
    ThemeColor.primary = DarkTheme.primary;
    ThemeColor.secondary = DarkTheme.primary;
    ThemeColor.danger = DarkTheme.danger;
    ThemeColor.action = DarkTheme.action;
    ThemeColor.borderTextField = DarkTheme.borderTextField;
    ThemeColor.backgroundTextField = DarkTheme.backgroundTextField;
    ThemeColor.textColor = DarkTheme.textColor;
    ThemeColor.borderCheckBox = DarkTheme.borderCheckBox;
    ThemeColor.appBackground = DarkTheme.appBackground;
    ThemeColor.greySeparator = DarkTheme.greySeparator;
    ThemeColor.captionTextColor = DarkTheme.captionTextColor;
    ThemeColor.comboSaleBackground = DarkTheme.comboSaleBackground;
    ThemeColor.appBackground_2 = DarkTheme.appBackground_2;
    ThemeColor.homeBackground = DarkTheme.homeBackground;
    ThemeColor.itemBackground = DarkTheme.itemBackground;
    ThemeColor.colorPending = DarkTheme.colorPending;

    ThemeColor.AppDark = DarkTheme.AppDark;

    return themeData;
  }

  ///
  /// [AppThemes] initiation.
  /// Please Add [AppThemes().init() into GetMaterialApp.
  ///
  /// [Example] :
  ///
  /// GetMaterialApp(
  ///   themeMode: AppThemes().init(),
  /// )
  ///
  /// This [Function] works to initialize what theme is used.
  ThemeMode init() {
    // final box = GetStorage();
    // String tm = box.read(_sThemeModeKey);
    // if (tm == null) {
    //   box.write(_sThemeModeKey, _sThemeModeLight);
    //   return ThemeMode.light;
    // } else if (tm == _sThemeModeLight) {
    //   return ThemeMode.light;
    // } else {
    //   return ThemeMode.dark;
    // }
    //darkTheme();
    return ThemeMode.light;
  }
}

class ThemeColor {
  static Brightness statusIconColor = Brightness.dark;
  static Color primary = Color(0xFF1CA275);
  static Color secondary = Color(0xFFFFA400);
  static Color danger = Color(0xFFFC5555);
  static Color colorSamePrice = Color(0xFFF85A4A);
  static Color backgroundSamePrice = Color(0xFFFFF0EF);
  static Color action = Color(0xFF3A8CFF);

  static Color borderTextField = Color(0xFFE9E9EA);
  static Color backgroundTextField = Color(0xFFFBFBFB);
  static Color textColor = Color(0xFF24282C);
  static Color captionTextColor = Color(0xFF5B5E61);
  static Color colorNoSelect = Color(0xFF919395);

  static Color borderCheckBox = Color(0xFFC8C9CA);
  static Color appBackground = Color(0xFFFFFFFF);
  static Color greySeparator = const Color(0xFFE9E9E9);
  static Color comboSaleBackground = Color(0xFFF5FCF9);
  static Color appBackground_2 = Color(0xFFFBFBFB);
  static Color homeBackground = Color(0xFFFBFBFB);
  static Color itemBackground = Color(0xFFFFFFFF);
  static Color colorNotification = Color(0x40CCF0E0);

  static Color greyTextColor = const Color(0xFF7A7A7A);
  static Color greyArrow = const Color(0xFFA7A7A7);
  static Color colorUnit = const Color(0x8024282C);

  static Color colorPending = const Color(0xFFF6AF36);

  static MaterialColor AppPrimary = MaterialColor(
    0xFF289767,
    <int, Color>{
      100: Color(0xFFD4EAE1),
      200: Color(0xFFA9D5C2),
      300: Color(0xFF7EC1A4),
      400: Color(0xFF53AC85),
      500: Color(0xFF289767),
      600: Color(0xFF1A8454),
      700: Color(0xFF007540),
    },
  );

  static MaterialColor AppSuccess = MaterialColor(
    0xFF13C273,
    <int, Color>{
      100: Color(0xFFD0F3E3),
      200: Color(0xFFA1E7C7),
      300: Color(0xFF71DAAB),
      400: Color(0xFF42CE8F),
      500: Color(0xFF13C273),
    },
  );

  static MaterialColor AppBlue = MaterialColor(
    0xFF3A8CFF,
    <int, Color>{
      100: Color(0xFFD8E8FF),
      200: Color(0xFFB0D1FF),
      300: Color(0xFF89BAFF),
      400: Color(0xFF61A3FF),
      500: Color(0xFF3A8CFF),
    },
  );

  static MaterialColor AppOrange = MaterialColor(
    0xFFFFA400,
    <int, Color>{
      100: Color(0xFFFFEDCC),
      200: Color(0xFFFFDB99),
      300: Color(0xFFFFC866),
      400: Color(0xFFFFB633),
      500: Color(0xFFFFA400),
    },
  );

  static MaterialColor AppRed = MaterialColor(
    0xFFFF0C20,
    <int, Color>{
      100: Color(0xFFFFCED2),
      200: Color(0xFFFF9EA6),
      300: Color(0xFFFF6D79),
      400: Color(0xFFFF3D4D),
      500: Color(0xFFFF0C20),
    },
  );

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

  static MaterialColor NeutralDark = MaterialColor(
    0xFFC8C9CA,
    <int, Color>{
      60: Color(0xFF7A7A7A),
      80: Color(0xFF4E4E4E),
      100: Color(0xFF222222),
    },
  );
}

class ThemeText {
  static const String fontFamily = "sfUIText";
  static TextStyle default_text = TextStyle(
    fontFamily: fontFamily,
  );
  static TextStyle default_H1_36 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w600,
    fontSize: 36,
  );
  static TextStyle default_H2_32 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w600,
    fontSize: 32,
  );
  static TextStyle default_H3_30 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w600,
    fontSize: 30,
  );
  static TextStyle default_H4_26 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w600,
    fontSize: 26,
  );
  static TextStyle default_H5_22 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  static TextStyle default_H6_18 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static TextStyle default_S1_16 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF24282C),
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static TextStyle default_S2_14 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF24282C),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle default_P1_16 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static TextStyle default_P2_14 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF919395),
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle text_14_normal = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF24282C),
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
  static TextStyle text_28_normal = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF24282C),
    fontWeight: FontWeight.normal,
    fontSize: 28,
  );
  static TextStyle default_C1_12 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static TextStyle default_C2_12 = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF1F1F1F),
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle default_C2_12_bold = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFFFFFFFF),
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static TextStyle default_C2_12_Color_Primary = TextStyle(
    fontFamily: fontFamily,
    color: const Color(0xFF289767),
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static TextStyle default_Small_10 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF1F1F1F), fontWeight: FontWeight.w400, fontSize: 10);
  static TextStyle default_LABEL_12 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF1F1F1F), fontWeight: FontWeight.w600, fontSize: 12);
  static TextStyle default_Tiny_8 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF1F1F1F), fontWeight: FontWeight.w400, fontSize: 8);
  static TextStyle buttons_Giant_18 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF101426), fontWeight: FontWeight.w700, fontSize: 18);

  static TextStyle buttons_large_16 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF101426), fontWeight: FontWeight.w700, fontSize: 16);
  static TextStyle buttons_Medium_14 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF101426), fontWeight: FontWeight.w700, fontSize: 14);
  static TextStyle buttons_Small_18 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF101426), fontWeight: FontWeight.w700, fontSize: 12);
  static TextStyle font_12_default =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF3A3E41), fontWeight: FontWeight.w400, fontSize: 12);
  static TextStyle fontRegular13 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF4E4E4E), fontWeight: FontWeight.w400, fontSize: 13);
  static TextStyle fontRegular12 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF4E4E4E), fontWeight: FontWeight.w400, fontSize: 12);
  static TextStyle fontRegular14 = TextStyle(fontFamily: fontFamily, color: const Color(0xFF7A7A7A), fontSize: 14);
  static TextStyle fontRegular16 = TextStyle(fontFamily: fontFamily, color: const Color(0xFF222222), fontSize: 16);
  static TextStyle fontRegular15 = fontRegular16.copyWith(fontSize: 15);
  static TextStyle fontBold24 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF222222), fontWeight: FontWeight.w600, fontSize: 22);
  static TextStyle fontBold16Black =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle fontBold16 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 16);
  static TextStyle fontBold18 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.bold, fontSize: 18);
  static TextStyle fontBold14 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.bold, fontSize: 14);
  static TextStyle fontBold13 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.bold, fontSize: 13);
  static TextStyle font16 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.normal, fontSize: 16);
  static TextStyle titleToolbar =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF3A3E41), fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle bold16Black =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.w600, fontSize: 15);

  static TextStyle fontMedium16 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF3A3E41), fontWeight: FontWeight.w500, fontSize: 16);
  static TextStyle font16_500 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF289767), fontWeight: FontWeight.w500, fontSize: 16);
  static TextStyle fontMedium9 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFFFF0C20), fontWeight: FontWeight.w500, fontSize: 9);
  static TextStyle fontMedium14 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.w500, fontSize: 14);
  static TextStyle fontMedium18 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF5B5E61), fontWeight: FontWeight.w500, fontSize: 18);
  static TextStyle fontNormal18 =
      TextStyle(fontFamily: fontFamily, color: ThemeColor.AppPrimary[500], fontWeight: FontWeight.normal, fontSize: 18);
  static TextStyle fontNormal12 =
      TextStyle(fontFamily: fontFamily, color: ThemeColor.AppDark[700], fontWeight: FontWeight.normal, fontSize: 12);

  static TextStyle normal_700_20 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.w600, fontSize: 20);
  static TextStyle normal_400_14 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF24282C), fontWeight: FontWeight.w400, fontSize: 14);
  static TextStyle normal_400_14_title =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF7A7A7A), fontWeight: FontWeight.w400, fontSize: 14);
  static TextStyle normal_400_15 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFF919395), fontWeight: FontWeight.w400, fontSize: 15);

  static TextStyle normal_400_10 =
      TextStyle(fontFamily: fontFamily, color: ThemeColor.AppDark[700], fontWeight: FontWeight.w400, fontSize: 10);
  static TextStyle normal_10 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.normal, fontSize: 10);
  static TextStyle bold9 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w700, fontSize: 9);

  static TextStyle white_400_15 =
      TextStyle(fontFamily: fontFamily, color: const Color(0xFFFBFBFB), fontWeight: FontWeight.w400, fontSize: 15);
}
