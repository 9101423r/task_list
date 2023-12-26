import 'package:flutter/material.dart';
import 'package:task_list/constants/app_text_styles.dart';

class AppTheme {
  static final ThemeData mainTheme = ThemeData(
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        color: const Color.fromARGB(255, 165, 222, 248),
        elevation: 0.0,
      ),
      listTileTheme: const ListTileThemeData(
        titleTextStyle: AppTextStyles.titleStyle,
        subtitleTextStyle: AppTextStyles.subtitleStyle,
      ),
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyles.loginButtonText,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: const Color.fromARGB(255, 46, 130, 234),
          foregroundColor: const Color.fromARGB(255, 165, 222, 248),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        ),
      ));
}
