// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// A class that defines the color scheme for the Eleven Dash App.
///
/// This class extends the `ThemeExtension` class and provides a set of colors
/// that can be used to style the app's UI elements. The colors are defined as
/// instance variables and can be accessed directly. The class also provides
/// methods to create copies of the theme with modified colors and to interpolate
/// between two themes.
class AppColors extends ThemeExtension<AppColors> {
  final Color green;

  final Color yellow;

  final Color white;

  final Color gray;

  final Color lightGray;

  final Color black;

  final Color blue;

  final Color red;

  final Color lightRed;

  final Color silver;

  final Color bronze;

  const AppColors({
    required this.green,
    required this.yellow,
    required this.white,
    required this.gray,
    required this.lightGray,
    required this.black,
    required this.blue,
    required this.red,
    required this.lightRed,
    required this.silver,
    required this.bronze,
  });

  @override
  AppColors copyWith({
    Color? green,
    Color? blue,
    Color? yellow,
    Color? white,
    Color? gray,
    Color? lightGray,
    Color? black,
    Color? red,
    Color? lightRed,
    Color? silver,
    Color? bronze,
  }) {
    return AppColors(
      green: green ?? this.green,
      yellow: yellow ?? this.yellow,
      white: white ?? this.white,
      gray: gray ?? this.gray,
      lightGray: lightGray ?? this.lightGray,
      black: black ?? this.black,
      blue: blue ?? this.blue,
      red: red ?? this.red,
      lightRed: lightRed ?? this.lightRed,
      silver: silver ?? this.silver,
      bronze: bronze ?? this.bronze,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    return AppColors(
      green: Color.lerp(green, other?.green, t) ?? green,
      yellow: Color.lerp(yellow, other?.yellow, t) ?? yellow,
      white: Color.lerp(white, other?.white, t) ?? white,
      gray: Color.lerp(gray, other?.gray, t) ?? gray,
      lightGray: Color.lerp(lightGray, other?.lightGray, t) ?? lightGray,
      black: Color.lerp(black, other?.black, t) ?? black,
      blue: Color.lerp(blue, other?.blue, t) ?? blue,
      red: Color.lerp(red, other?.red, t) ?? red,
      lightRed: Color.lerp(lightRed, other?.lightRed, t) ?? lightRed,
      silver: Color.lerp(silver, other?.silver, t) ?? silver,
      bronze: Color.lerp(bronze, other?.bronze, t) ?? bronze,
    );
  }
}
