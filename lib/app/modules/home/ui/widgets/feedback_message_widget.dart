import 'package:flutter/material.dart';
import 'package:url_shortener/app/core/themes/extensions/theme_extension.dart';

enum FeedbackType { success, error }

class FeedbackMessageWidget extends StatelessWidget {
  final FeedbackType type;
  final String message;
  final VoidCallback onClose;

  const FeedbackMessageWidget({
    super.key,
    required this.type,
    required this.message,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == FeedbackType.success;
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSuccess ? colors.green50 : colors.red50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSuccess ? colors.green200 : colors.red200),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess
                ? Icons.check_circle_outline_outlined
                : Icons.error_outline,
            color: isSuccess ? colors.green500 : colors.red500,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: context.size14.copyWith(
                color: isSuccess ? colors.green800 : colors.red800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 18,
              color: isSuccess ? colors.green800 : colors.red800,
            ),
            onPressed: onClose,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
