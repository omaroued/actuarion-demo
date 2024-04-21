import 'package:flutter/material.dart';

class ThemeModel {
  final Color backgroundColor = const Color(0xFFF1F3F6);

  final Color secondBackgroundColor = Colors.white;
  final Color textColor = Colors.black;
  final Color secondTextColor = const Color(0xFF6A6A6A);

  final Color shadowColor = Colors.grey.shade300;

  final Color accentColor = const Color(0xFF1095c4);

  final MaterialColor swatch = const MaterialColor(0xFF1095c4, {
    50: Color(0xFFf4fcfe),
    100: Color(0xFFdff5fc),
    200: Color(0xFFe7f7fd),
    300: Color(0xFFb8e8f9),
    400: Color(0xFF5acaf2),
    500: Color(0xFF2bbbee),
    600: Color(0xFF11a1d4),
    700: Color(0xFF1095c4),
    800: Color(0xFF0d7da5),
    900: Color(0xFF0a5a76),
  });

  late TextStyle buttonTextStyle;

  late final ThemeData theme;

  ThemeModel() {
    const String fontFamily = "Poppins";

    buttonTextStyle = const TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.white,
    );
    theme = ThemeData(
      brightness: Brightness.light,
      dialogBackgroundColor: backgroundColor,
      primarySwatch: swatch,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: swatch, backgroundColor: backgroundColor, brightness: Brightness.light)
              .copyWith(secondary: accentColor),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: accentColor,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: backgroundColor,
        unselectedLabelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: accentColor,
          titleTextStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all<double>(2.5),
              textStyle: MaterialStateProperty.all<TextStyle>(buttonTextStyle),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
              backgroundColor: MaterialStateProperty.all(accentColor))),
      iconTheme: IconThemeData(
        color: secondTextColor,
      ),
      textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600, fontSize: 22, color: textColor),
          displayMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontSize: 20, color: textColor),
          displaySmall: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontSize: 16, color: textColor),
          headlineMedium:
              TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontSize: 14, color: textColor),
          headlineSmall: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600, fontSize: 14, color: textColor),
          titleLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 14, color: textColor),
          bodyLarge: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 13, color: textColor),
          bodyMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 13, color: textColor),
          titleMedium: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 14, color: textColor),
          titleSmall: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 12, color: textColor),
          bodySmall:
              TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 12, color: secondTextColor)),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1.5, color: accentColor),
        ),
        contentPadding: const EdgeInsets.all(15),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          color: secondTextColor,
        ),
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          color: secondTextColor,
        ),
      ),
    );
  }
}
