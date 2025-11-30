import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_shortener/app/core/themes/extensions/theme_extension.dart';
import 'package:url_shortener/app/modules/home/interactor/controllers/shortener_controller.dart';
import 'package:url_shortener/app/modules/home/interactor/states/shortener_state.dart';
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
  final ValueNotifier<String?> _urlValidationError = ValueNotifier(null);

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(shortenerListener);
    _urlController.addListener(_validateUrl);

    _listenable = Listenable.merge([
      widget.controller,
      _showSuccess,
      _showError,
      _urlValidationError,
    ]);
  }

  void shortenerListener() {
    final shortenerState = widget.controller.value;
    if (shortenerState is ShortenerStateError) {
      _showError.value = true;
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showError.value = false;
          });
        }
      });
    }
    if (shortenerState is ShortenerStateSuccess) {
      _showSuccess.value = true;
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showSuccess.value = false;
          });
        }
      });
    }
  }

  void _validateUrl() {
    final url = _urlController.text.trim();

    if (url.isEmpty || url.length < 4) {
      _urlValidationError.value = null;
      return;
    }

    if (!widget.controller.isValidUrl(url)) {
      _urlValidationError.value =
          'Please enter a valid URL(https://example.com)';
    } else {
      _urlValidationError.value = null;
    }
  }

  @override
  void dispose() {
    _urlController.removeListener(_validateUrl);
    _urlController.dispose();
    widget.controller.removeListener(shortenerListener);
    _showSuccess.dispose();
    _showError.dispose();
    _urlValidationError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.white,
      body: ListenableBuilder(
        listenable: _listenable,
        builder: (context, child) {
          final state = widget.controller.value;
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: context.screenSize.height,
                ),
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
                            color: context.appColors.black.withValues(
                              alpha: 0.05,
                            ),
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
                                color: _urlValidationError.value != null
                                    ? context.appColors.red500
                                    : context.appColors.gray400,
                                size: 20,
                              ),
                              errorText: _urlValidationError.value,
                              errorStyle: context.size12.copyWith(
                                color: context.appColors.red500,
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
                                  color: _urlValidationError.value != null
                                      ? context.appColors.red500
                                      : context.appColors.gray300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _urlValidationError.value != null
                                      ? context.appColors.red500
                                      : context.appColors.purple600,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.appColors.red500,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: context.appColors.red500,
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
                              onPressed:
                                  (_urlController.text.trim().isEmpty ||
                                      _urlController.text.length < 4 ||
                                      _urlValidationError.value != null)
                                  ? null
                                  : () {
                                      final url = _urlController.text.trim();
                                      widget.controller.shortUrlTest(url);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.appColors.purple600,
                                foregroundColor: context.appColors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: state is ShortenerStateLoading
                                  ? SizedBox(
                                      width: 23,
                                      height: 23,
                                      child: CircularProgressIndicator(
                                        color: context.appColors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
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
                              message:
                                  state.exception?.message ?? 'Failed to fetch',
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
                            color: context.appColors.black.withValues(
                              alpha: 0.05,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Links (${state.history.length})',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colors.gray700,
                            ),
                          ),
                          const SizedBox(height: 16),

                          if (state.history.isEmpty)
                            EmptyListWidget()
                          else
                            ...state.history.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              return Column(
                                children: [
                                  if (index > 0) const SizedBox(height: 16),
                                  LinkCardWidget(
                                    originalUrl: item.links?.self ?? '',
                                    shortenedUrl: item.links?.short ?? '',
                                    alias: item.alias ?? '',
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
        },
      ),
    );
  }
}
