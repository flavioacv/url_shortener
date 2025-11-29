import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// This file contains extensions for [BuildContext] and a function to convert a hex string to a [Color].
///
/// The [ThemeExtension] extension provides convenient access to the [AppColors], [Size], and [EdgeInsets] of the current [BuildContext].
extension ThemeExtension on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
  Size get screenSize => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  TextStyle get size10 => const TextStyle(fontSize: 10, fontWeight: FontWeight.w400);
  TextStyle get size12 => const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  TextStyle get size14 => const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle get size16 => const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  TextStyle get size18 => const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
}
