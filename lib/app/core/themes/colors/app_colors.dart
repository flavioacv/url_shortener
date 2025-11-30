import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  // Purple Colors (Brand)
  final Color purple600;
  final Color purple700;
  final Color purple800;
  final Color purple50;
  final Color purple300;
  final Color purple100;

  // Neutral Colors (Grays)
  final Color white;
  final Color gray50;
  final Color gray100;
  final Color gray200;
  final Color gray300;
  final Color gray400;
  final Color gray500;
  final Color gray600;
  final Color gray700;
  final Color gray900;

  // Success Colors (Green)
  final Color green500;
  final Color green50;
  final Color green200;
  final Color green800;

  // Error Colors (Red)
  final Color red500;
  final Color red50;
  final Color red200;
  final Color red800;

  final Color black;

  const AppColors({
    // Purple
    required this.purple600,
    required this.purple700,
    required this.purple800,
    required this.purple50,
    required this.purple300,
    required this.purple100,
    // Neutral
    required this.white,
    required this.gray50,
    required this.gray100,
    required this.gray200,
    required this.gray300,
    required this.gray400,
    required this.gray500,
    required this.gray600,
    required this.gray700,
    required this.gray900,
    // Success
    required this.green500,
    required this.green50,
    required this.green200,
    required this.green800,
    // Error
    required this.red500,
    required this.red50,
    required this.red200,
    required this.red800,
    required this.black,
    });

  @override
  AppColors copyWith({
    // Purple
    Color? purple600,
    Color? purple700,
    Color? purple800,
    Color? purple50,
    Color? purple300,
    Color? purple100,
    // Neutral
    Color? white,
    Color? gray50,
    Color? gray100,
    Color? gray200,
    Color? gray300,
    Color? gray400,
    Color? gray500,
    Color? gray600,
    Color? gray700,
    Color? gray900,
    // Success
    Color? green500,
    Color? green50,
    Color? green200,
    Color? green800,
    // Error
    Color? red500,
    Color? red50,
    Color? red200,
    Color? red800,
    Color? black,
  }) {
    return AppColors(
      // Purple
      purple600: purple600 ?? this.purple600,
      purple700: purple700 ?? this.purple700,
      purple800: purple800 ?? this.purple800,
      purple50: purple50 ?? this.purple50,
      purple300: purple300 ?? this.purple300,
      purple100: purple100 ?? this.purple100,
      // Neutral
      white: white ?? this.white,
      gray50: gray50 ?? this.gray50,
      gray100: gray100 ?? this.gray100,
      gray200: gray200 ?? this.gray200,
      gray300: gray300 ?? this.gray300,
      gray400: gray400 ?? this.gray400,
      gray500: gray500 ?? this.gray500,
      gray600: gray600 ?? this.gray600,
      gray700: gray700 ?? this.gray700,
      gray900: gray900 ?? this.gray900,
      // Success
      green500: green500 ?? this.green500,
      green50: green50 ?? this.green50,
      green200: green200 ?? this.green200,
      green800: green800 ?? this.green800,
      // Error
      red500: red500 ?? this.red500,
      red50: red50 ?? this.red50,
      red200: red200 ?? this.red200,
      red800: red800 ?? this.red800,
      black: black ?? this.black,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    return AppColors(
      // Purple
      purple600: Color.lerp(purple600, other?.purple600, t) ?? purple600,
      purple700: Color.lerp(purple700, other?.purple700, t) ?? purple700,
      purple800: Color.lerp(purple800, other?.purple800, t) ?? purple800,
      purple50: Color.lerp(purple50, other?.purple50, t) ?? purple50,
      purple300: Color.lerp(purple300, other?.purple300, t) ?? purple300,
      purple100: Color.lerp(purple100, other?.purple100, t) ?? purple100,
      // Neutral
      white: Color.lerp(white, other?.white, t) ?? white,
      gray50: Color.lerp(gray50, other?.gray50, t) ?? gray50,
      gray100: Color.lerp(gray100, other?.gray100, t) ?? gray100,
      gray200: Color.lerp(gray200, other?.gray200, t) ?? gray200,
      gray300: Color.lerp(gray300, other?.gray300, t) ?? gray300,
      gray400: Color.lerp(gray400, other?.gray400, t) ?? gray400,
      gray500: Color.lerp(gray500, other?.gray500, t) ?? gray500,
      gray600: Color.lerp(gray600, other?.gray600, t) ?? gray600,
      gray700: Color.lerp(gray700, other?.gray700, t) ?? gray700,
      gray900: Color.lerp(gray900, other?.gray900, t) ?? gray900,
      // Success
      green500: Color.lerp(green500, other?.green500, t) ?? green500,
      green50: Color.lerp(green50, other?.green50, t) ?? green50,
      green200: Color.lerp(green200, other?.green200, t) ?? green200,
      green800: Color.lerp(green800, other?.green800, t) ?? green800,
      // Error
      red500: Color.lerp(red500, other?.red500, t) ?? red500,
      red50: Color.lerp(red50, other?.red50, t) ?? red50,
      red200: Color.lerp(red200, other?.red200, t) ?? red200,
      red800: Color.lerp(red800, other?.red800, t) ?? red800,
      black: Color.lerp(black, other?.black, t) ?? black,
    );
  }
}
