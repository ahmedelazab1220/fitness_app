import 'package:flutter/material.dart';

import '../assets/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData appTheme = ThemeData(
    fontFamily: 'BalooThambi',
    scaffoldBackgroundColor: AppColors.darkgrey,
    primaryColor: AppColors.darkgrey,
    secondaryHeaderColor: AppColors.black,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.white),
      titleMedium: TextStyle(color: AppColors.white),
      titleSmall: TextStyle(color: AppColors.white),
      labelLarge: TextStyle(color: AppColors.white),
      labelMedium: TextStyle(color: AppColors.white),
      labelSmall: TextStyle(color: AppColors.white),
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
      bodySmall: TextStyle(color: AppColors.white),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.darkgrey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.orange),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontFamily: 'BalooThambi',
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(color: AppColors.red, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      iconColor: AppColors.white[AppColors.colorCode30],
      hintStyle: TextStyle(
        color: AppColors.white[AppColors.colorCode30],
        fontSize: 12,
      ),
      prefixIconColor: AppColors.white[AppColors.colorCode30],
      suffixIconColor: AppColors.white[AppColors.colorCode30],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.white[AppColors.colorCode20]!,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.white[AppColors.colorCode20]!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.white[AppColors.colorCode20]!,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: const BorderSide(width: 1, color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: const BorderSide(width: 1, color: AppColors.red),
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return const TextStyle(color: AppColors.red);
        } else if (states.contains(WidgetState.focused)) {
          return const TextStyle(color: Colors.white);
        } else {
          return const TextStyle(color: AppColors.white);
        }
      }),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkgrey,
      foregroundColor: AppColors.black,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontFamily: 'BalooThambi',
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.all(AppColors.orange),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.orange,
          ),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(AppColors.white),
      side: BorderSide(color: AppColors.white[AppColors.colorCode20]!),
      overlayColor: const WidgetStatePropertyAll(AppColors.darkgrey),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        foregroundColor: AppColors.white,
        side: const BorderSide(color: AppColors.orange),
        textStyle: TextStyle(
          fontFamily: 'BalooThambi',
          fontWeight: FontWeight.w800,
          fontSize: 14,
          color: AppColors.white[AppColors.colorCode20],
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkgrey,
      selectedItemColor: AppColors.orange,
      unselectedItemColor: AppColors.white,
      showUnselectedLabels: true,
      showSelectedLabels: true,
    ),
  );
}
