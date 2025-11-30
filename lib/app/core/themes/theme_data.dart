import 'package:flutter/material.dart';

import 'colors/app_colors.dart';

final themeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF9333EA), // purple-600
    primary: const Color(0xFF9333EA), // purple-600
    secondary: const Color(0xFF7E22CE), // purple-700
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF9FAFB), // gray-50
  extensions: const [
    AppColors(
      // Purple Colors (Brand)
      purple600: Color(0xFF9333EA), // Primary brand color
      purple700: Color(0xFF7E22CE), // Hover state
      purple800: Color(0xFF6B21A8), // Active state
      purple50: Color(0xFFF3E8FF), // Light background
      purple300: Color(0xFFD8B4FE), // Border for new items
      purple100: Color(0xFFE9D5FF), // Shadow for new items
      // Neutral Colors (Grays)
      white: Color(0xFFFFFFFF), // Card backgrounds
      gray50: Color(0xFFF9FAFB), // General background
      gray100: Color(0xFFF3F4F6), // Empty state background
      gray200: Color(0xFFE5E7EB), // Card borders
      gray300: Color(0xFFD1D5DB), // Input borders, disabled button
      gray400: Color(0xFF9CA3AF), // Secondary icons
      gray500: Color(0xFF6B7280), // Secondary text
      gray600: Color(0xFF4B5563), // Text
      gray700: Color(0xFF374151), // Titles
      gray900: Color(0xFF1F2937), // Main text
      // Success Colors (Green)
      green500: Color(0xFF10B981), // Success icon
      green50: Color(0xFFECFDF5), // Success message background
      green200: Color(0xFFBBF7D0), // Success message border
      green800: Color(0xFF065F46), // Success message text
      // Error Colors (Red)
      red500: Color(0xFFEF4444), // Error icon
      red50: Color(0xFFFEF2F2), // Error message background
      red200: Color(0xFFFECACA), // Error message border
      red800: Color(0xFF991B1B), // Error message text

      black: Color(0xFF000000),
    ),
  ],
);
