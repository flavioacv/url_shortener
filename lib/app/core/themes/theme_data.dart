import 'package:flutter/material.dart';

import 'colors/app_colors.dart';

final themeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 25, 78, 69),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF2F2F2),
  extensions: const [
    AppColors(
      green: Color(0xFF00823C),
      yellow: Color(0xFFFABF18),
      white: Color(0xFFFFFFFF),
      gray: Color(0xFF888888),
      lightGray: Color(0xFFF5F5F5),
      black: Color(0xFF1C1C1C),
      blue: Color(0xFF2864AE),
      red: Color(0xFFDA1E28),
      lightRed: Color(0xFFFA3117),
      silver: Color(0xFFC0C0C0),
      bronze: Color(0xFFCD7F32),
    ),
  ],
);
