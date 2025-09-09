import 'package:flutter/material.dart';
import 'package:velinno_assestment_task/core/theme/app_colors.dart';

class AppThemes {
  //! <<<<<<<<<<<<<<<<<<<<<<------------------------------ Light Theme ------------------------------>>>>>>>>>>>>>>>>>>>>>>>
  static final light = ThemeData.light().copyWith(
    // Scaffold & Background
    scaffoldBackgroundColor: AppColors.lightScaffoldColor,
    canvasColor: AppColors.lightBackgroundColor,
    cardColor: AppColors.lightCardColor,
    dialogBackgroundColor: AppColors.lightCardColor,

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightScaffoldColor,
      foregroundColor: AppColors.lightTextColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.lightTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.lightIconsColor),
    ),

    // Color Scheme
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.lightSecondaryColor,
      surface: AppColors.lightCardColor,
      background: AppColors.lightBackgroundColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onSurface: AppColors.lightTextColor,
      onBackground: AppColors.lightTextColor,
      onError: AppColors.white,
      brightness: Brightness.light,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.lightTextColor),
      displayMedium: TextStyle(color: AppColors.lightTextColor),
      displaySmall: TextStyle(color: AppColors.lightTextColor),
      headlineMedium: TextStyle(color: AppColors.lightTextColor),
      headlineSmall: TextStyle(color: AppColors.lightTextColor),
      titleLarge: TextStyle(color: AppColors.lightTextColor),
      titleMedium: TextStyle(color: AppColors.lightTextColor),
      titleSmall: TextStyle(color: AppColors.lightTextColor),
      bodyLarge: TextStyle(color: AppColors.lightTextColor),
      bodyMedium: TextStyle(color: AppColors.lightTextColor),
      bodySmall: TextStyle(color: AppColors.lightTextSecondary),
      labelLarge: TextStyle(color: AppColors.lightTextColor),
      labelSmall: TextStyle(color: AppColors.lightTextSecondary),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightCardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.lightBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightBorderColor),
      ),
      labelStyle: TextStyle(color: AppColors.lightTextSecondary),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimaryColor,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Icons
    iconTheme: IconThemeData(color: AppColors.lightIconsColor),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimaryColor,
      foregroundColor: AppColors.white,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: AppColors.lightBorderColor,
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightCardColor,
      selectedItemColor: AppColors.lightPrimaryColor,
      unselectedItemColor: AppColors.lightTextSecondary,
    ),
  );
  //! <<<<<<<<<<<<<<<<<<<<<<------------------------------ Dark Theme ------------------------------>>>>>>>>>>>>>>>>>>>>>>>
  // Dark Theme
  static final dark = ThemeData.dark().copyWith(
    // Scaffold & Background
    scaffoldBackgroundColor: AppColors.darkScaffoldColor,
    canvasColor: AppColors.darkBackgroundColor,
    cardColor: AppColors.darkCardColor,
    dialogBackgroundColor: AppColors.darkCardColor,

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkScaffoldColor,
      foregroundColor: AppColors.darkTextColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.darkIconsColor),
    ),

    // Color Scheme
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimaryColor,
      secondary: AppColors.darkSecondaryColor,
      surface: AppColors.darkCardColor,
      background: AppColors.darkBackgroundColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.darkTextColor,
      onBackground: AppColors.darkTextColor,
      onError: AppColors.white,
      brightness: Brightness.dark,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(color: AppColors.darkTextColor),
      displayMedium: TextStyle(color: AppColors.darkTextColor),
      displaySmall: TextStyle(color: AppColors.darkTextColor),
      headlineMedium: TextStyle(color: AppColors.darkTextColor),
      headlineSmall: TextStyle(color: AppColors.darkTextColor),
      titleLarge: TextStyle(color: AppColors.darkTextColor),
      titleMedium: TextStyle(color: AppColors.darkTextColor),
      titleSmall: TextStyle(color: AppColors.darkTextColor),
      bodyLarge: TextStyle(color: AppColors.darkTextColor),
      bodyMedium: TextStyle(color: AppColors.darkTextColor),
      bodySmall: TextStyle(color: AppColors.darkTextSecondary),
      labelLarge: TextStyle(color: AppColors.darkTextColor),
      labelSmall: TextStyle(color: AppColors.darkTextSecondary),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.darkBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkBorderColor),
      ),
      labelStyle: TextStyle(color: AppColors.darkTextSecondary),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimaryColor,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // Icons
    iconTheme: IconThemeData(color: AppColors.darkIconsColor),

    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkAccentColor,
      foregroundColor: AppColors.white,
    ),

    // Divider
    dividerTheme: DividerThemeData(
      color: AppColors.darkBorderColor,
      thickness: 1,
      space: 1,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkCardColor,
      selectedItemColor: AppColors.darkAccentColor,
      unselectedItemColor: AppColors.darkTextSecondary,
    ),

    // Text Selection
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.darkAccentColor,
      selectionColor: AppColors.darkAccentColor.withOpacity(0.4),
      selectionHandleColor: AppColors.darkAccentColor,
    ),
  );
}
