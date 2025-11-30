import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_shortener/app/core/themes/extensions/theme_extension.dart';
import 'package:url_shortener/app/modules/home/interactor/controllers/shortener_controller.dart';
import 'package:url_shortener/app/modules/home/ui/widgets/empty_list_widget.dart';
import 'package:url_shortener/app/modules/home/ui/widgets/feedback_message_widget.dart';
import 'package:url_shortener/app/modules/home/ui/widgets/link_card_widget.dart';

import '../../../../core/themes/colors/app_colors.dart';

class HomePage extends StatefulWidget {
  final ShortenerController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Listenable _listenable;
  final TextEditingController _urlController = TextEditingController();
  final ValueNotifier<bool> _showSuccess = ValueNotifier(false);
  final ValueNotifier<bool> _showError = ValueNotifier(false);

  // List of shortened links (empty by default to show empty state)
  final List<Map<String, String>> _links = [
    // Uncomment to see links:
    {
      'originalUrl':
          'https://www.example.com/very/long/url/path/to/some/content',
      'shortenedUrl': 'https://short.url/abc123',
      'alias': 'abc123',
    },
    {
      'originalUrl': 'https://www.github.com/nubank/mobile-test',
      'shortenedUrl': 'https://short.url/xyz789',
      'alias': 'xyz789',
    },
  ];

  @override
  void initState() {
    super.initState();
    _listenable = Listenable.merge([widget.controller, _showSuccess, _showError]);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _shortenUrl() {
    if (_urlController.text.isNotEmpty) {
      // Simulate API call - you can change this logic
      // For demo: show error if URL doesn't start with http
      final isValidUrl = _urlController.text.startsWith('http');

      setState(() {
        _showSuccess.value = isValidUrl;
        _showError.value = !isValidUrl;
      });

      // Hide message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showSuccess.value = false;
            _showError.value = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.white,
      body: ListenableBuilder(
        listenable: _listenable,
        builder: (context, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: context.screenSize.height),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [colors.white, colors.purple50],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    // Header Section
                    Column(
                      children: [
                        // Icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: colors.purple600,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            LucideIcons.scissors,
                            color: colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          'URL Shortener',
                          style: context.size18.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.gray900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Subtitle
                        Text(
                          'Shorten your favorite links and keep track of them!',
                          textAlign: TextAlign.center,
                          style: context.size14.copyWith(
                            color: context.appColors.gray500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
          
                    // Input Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: context.appColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // URL Input Field
                          TextField(
                            controller: _urlController,
                            decoration: InputDecoration(
                              hintText: 'Enter URL to shorten',
                              hintStyle: context.size16.copyWith(
                                color: context.appColors.gray400,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                LucideIcons.link,
                                color: context.appColors.gray400,
                                size: 20,
                              ),
                              filled: true,
                              fillColor: context.appColors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.appColors.gray300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.appColors.gray300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.appColors.purple600,
                                  width: 2,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
          
                          // Shorten Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _shortenUrl,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.appColors.purple600,
                                foregroundColor: context.appColors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'Shorten URL',
                                style: context.size16.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
          
                          if (_showSuccess.value) ...[
                            const SizedBox(height: 16),
                            FeedbackMessageWidget(
                              type: FeedbackType.success,
                              message: 'Link shortened successfully!',
                              onClose: () {
                                setState(() {
                                  _showSuccess.value = false;
                                });
                              },
                            ),
                          ],
          
                          if (_showError.value) ...[
                            const SizedBox(height: 16),
                            FeedbackMessageWidget(
                              type: FeedbackType.error,
                              message: 'Failed to fetch',
                              onClose: () {
                                setState(() {
                                  _showError.value = false;
                                });
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
          
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.appColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: context.appColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Links (${_links.length})',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colors.gray700,
                            ),
                          ),
                          const SizedBox(height: 16),
          
                          if (_links.isEmpty)
                            EmptyListWidget()
                          else
                            ..._links.asMap().entries.map((entry) {
                              final index = entry.key;
                              final link = entry.value;
                              return Column(
                                children: [
                                  if (index > 0) const SizedBox(height: 16),
                                  LinkCardWidget(
                                    originalUrl: link['originalUrl']!,
                                    shortenedUrl: link['shortenedUrl']!,
                                    alias: link['alias']!,
                                  ),
                                ],
                              );
                            }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
