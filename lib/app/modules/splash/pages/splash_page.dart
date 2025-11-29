import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_shortener/app/core/routes/routes.dart';
import 'package:url_shortener/app/core/themes/extensions/theme_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.purple600,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.scissors,
              size: 100,
              color: context.appColors.white,
            ),
            Text(
              'Url Shortener',
              style: context.size18.copyWith(color: context.appColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
