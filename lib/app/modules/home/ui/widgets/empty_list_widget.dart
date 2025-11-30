import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_shortener/app/core/themes/extensions/theme_extension.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with circular background
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: context.appColors.gray100,
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.link2, color: context.appColors.gray400, size: 32),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              'No shortened links',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.appColors.gray600,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              'Paste a URL above to get started.',
              style: TextStyle(fontSize: 14, color: context.appColors.gray500),
            ),
          ],
        ),
      ),
    );
  }
}