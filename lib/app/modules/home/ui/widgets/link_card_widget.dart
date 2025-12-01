import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_shortener/app/core/themes/extensions/theme_extension.dart';

class LinkCardWidget extends StatelessWidget {
  final String originalUrl;
  final String shortenedUrl;
  final String alias;

  const LinkCardWidget({
    super.key,

    required this.originalUrl,
    required this.shortenedUrl,
    required this.alias,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.gray50.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Original URL
          Row(
            children: [
              Text(
                'Original URL',
                style: TextStyle(
                  fontSize: 12,
                  color: context.appColors.gray500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  originalUrl,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.appColors.gray600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                LucideIcons.externalLink,
                size: 16,
                color: context.appColors.gray400,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Shortened URL
          Text(
            'Shortened URL',
            style: TextStyle(
              fontSize: 12,
              color: context.appColors.gray500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: context.appColors.purple50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    shortenedUrl,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.appColors.purple600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: shortenedUrl));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Copied to clipboard!'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: context.appColors.gray900,
                      ),
                    );
                  },
                  child: Icon(
                    LucideIcons.copy,
                    size: 16,
                    color: context.appColors.purple600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Alias
          Row(
            children: [
              Text(
                'Alias: ',
                style: TextStyle(
                  fontSize: 12,
                  color: context.appColors.gray500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                alias,
                style: TextStyle(
                  fontSize: 12,
                  color: context.appColors.gray600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
