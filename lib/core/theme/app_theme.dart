import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseLight = ThemeData(
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      brightness: Brightness.light,
      fontFamily: 'sahel',
      colorSchemeSeed: AppColors.primary,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: AppColors.lightText,
          fontWeight: FontWeight.w400,
        ),
      ),
      textTheme: const TextTheme(
        //Onboarding Screen
        displayLarge: TextStyle(
          fontSize: 24,
          color: AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: 17,
          color: AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: 16,
          color: AppColors.lightText,
          fontWeight: FontWeight.w400,
        ),

        //Hotel Detail
        headlineLarge: TextStyle(
          fontSize: 28,
          color: AppColors.lightText,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: AppColors.lightText,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          color: AppColors.lightText,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.lightBorder,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.lightFocusedBorder,
            width: 1.7,
          ),
        ),

        hintStyle: const TextStyle(color: AppColors.hintText, fontSize: 14),
        labelStyle: const TextStyle(
          color: AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return baseLight.copyWith(
      colorScheme: baseLight.colorScheme.copyWith(
        outline: Colors.grey[500],
        primaryFixed: AppColors.primary,
        surfaceContainerLow: Colors.grey[200],
      ),

      inputDecorationTheme: baseLight.inputDecorationTheme.copyWith(
        fillColor: baseLight.colorScheme.surface,
      ),
    );
  }

  // static ThemeData get darkTheme {
  //   final baseDark = ThemeData(
  //     useMaterial3: true,
  //     scaffoldBackgroundColor: Colors.black,
  //     brightness: Brightness.dark,
  //     fontFamily: 'sahel',
  //     colorSchemeSeed: AppColors.primary,
  //     appBarTheme: const AppBarTheme(
  //       backgroundColor: Colors.transparent,
  //       foregroundColor: Colors.white,
  //       elevation: 0,
  //       titleTextStyle: TextStyle(
  //         fontSize: 16,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.w400,
  //       ),
  //     ),
  //     textTheme: const TextTheme(
  //       //Onboarding Screen
  //       displayLarge: TextStyle(
  //         fontSize: 24,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       displayMedium: TextStyle(
  //         fontSize: 17,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       displaySmall: TextStyle(
  //         fontSize: 16,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.w400,
  //       ),
  //
  //       //Hotel Detail
  //       headlineLarge: TextStyle(
  //         fontSize: 24,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.w600,
  //       ),
  //       headlineMedium: TextStyle(
  //         fontSize: 20,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.w600,
  //       ),
  //       headlineSmall: TextStyle(
  //         fontSize: 16,
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.w400,
  //       ),
  //     ),
  //     elevatedButtonTheme: ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: AppColors.primary,
  //         foregroundColor: Colors.white,
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         // textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
  //       ),
  //     ),
  //
  //     inputDecorationTheme: InputDecorationTheme(
  //       filled: true,
  //       contentPadding: const EdgeInsets.symmetric(
  //         vertical: 16,
  //         horizontal: 12,
  //       ),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: AppColors.darkBorder,
  //           width: 1.5,
  //         ),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: AppColors.darkBorder,
  //           width: 1.5,
  //         ),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //         borderSide: const BorderSide(
  //           color: AppColors.darkFocusedBorder,
  //           width: 1.5,
  //         ),
  //       ),
  //       hintStyle: const TextStyle(color: AppColors.hintText, fontSize: 14),
  //       labelStyle: const TextStyle(
  //         color: AppColors.darkText,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  //   return baseDark.copyWith(
  //       colorScheme: baseDark.colorScheme.copyWith(
  //         outline: Colors.grey[500],
  //         primaryFixed: AppColors.primary,
  //       ),
  //       inputDecorationTheme: baseDark.inputDecorationTheme.copyWith(
  //           fillColor: baseDark.colorScheme.surface
  //       )
  //   );
  // }
}
