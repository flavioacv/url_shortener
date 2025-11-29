import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// This file contains extensions for [BuildContext] and a function to convert a hex string to a [Color].
///
/// The [ThemeExtension] extension provides convenient access to the [AppColors], [Size], and [EdgeInsets] of the current [BuildContext].
extension ThemeExtension on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
  Size get screenSize => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}
