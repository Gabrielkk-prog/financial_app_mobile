import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

final defautTheme = ThemeData(
  textTheme: TextTheme(
    bodyMedium: AppTextStyles.smallText,
    titleMedium: AppTextStyles.mediumText18,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF00A86B),
      ),
    ),
  ),
);