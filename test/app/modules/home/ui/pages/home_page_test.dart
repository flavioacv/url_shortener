import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener/app/core/service/either/either.dart';
import 'package:url_shortener/app/core/service/http_service/http_exception.dart';
import 'package:url_shortener/app/core/themes/colors/app_colors.dart';
import 'package:url_shortener/app/modules/home/interactor/controllers/shortener_controller.dart';
import 'package:url_shortener/app/modules/home/interactor/models/shortened_url_model.dart';
import 'package:url_shortener/app/modules/home/interactor/models/url_links_model.dart';
import 'package:url_shortener/app/modules/home/interactor/services/shortener_service.dart';
import 'package:url_shortener/app/modules/home/ui/pages/home_page.dart';
import 'package:url_shortener/app/modules/home/ui/widgets/empty_list_widget.dart';
import 'package:url_shortener/app/modules/home/ui/widgets/feedback_message_widget.dart';

class ShortenerServiceMock extends Mock implements ShortenerService {}

void main() {
  late ShortenerService shortenerService;
  late ShortenerController controller;

  setUp(() {
    shortenerService = ShortenerServiceMock();
    controller = ShortenerController(shortenerService: shortenerService);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: ThemeData(
        extensions: const [
          AppColors(
            // Purple Colors (Brand)
            purple600: Color(0xFF9333EA),
            purple700: Color(0xFF7E22CE),
            purple800: Color(0xFF6B21A8),
            purple50: Color(0xFFF3E8FF),
            purple300: Color(0xFFD8B4FE),
            purple100: Color(0xFFE9D5FF),
            // Neutral Colors (Grays)
            white: Color(0xFFFFFFFF),
            gray50: Color(0xFFF9FAFB),
            gray100: Color(0xFFF3F4F6),
            gray200: Color(0xFFE5E7EB),
            gray300: Color(0xFFD1D5DB),
            gray400: Color(0xFF9CA3AF),
            gray500: Color(0xFF6B7280),
            gray600: Color(0xFF4B5563),
            gray700: Color(0xFF374151),
            gray900: Color(0xFF1F2937),
            // Success Colors (Green)
            green500: Color(0xFF10B981),
            green50: Color(0xFFECFDF5),
            green200: Color(0xFFBBF7D0),
            green800: Color(0xFF065F46),
            // Error Colors (Red)
            red500: Color(0xFFEF4444),
            red50: Color(0xFFFEF2F2),
            red200: Color(0xFFFECACA),
            red800: Color(0xFF991B1B),
            black: Color(0xFF000000),
          ),
        ],
      ),
      home: HomePage(controller: controller),
    );
  }

  group('HomePage Widget Tests', () {
    // PRIORITY 1: WIDGET STATE
    group('Widget State', () {
      testWidgets('should render initial state correctly', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

     
        expect(find.byType(CircularProgressIndicator), findsNothing);

        expect(find.byType(FeedbackMessageWidget), findsNothing);

        expect(find.byType(EmptyListWidget), findsOneWidget);
        expect(controller.value.history, isEmpty);
      });

      testWidgets('should show loading state when shortening URL', (
        tester,
      ) async {
        when(() => shortenerService.shortUrl(any())).thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 1));
          return Right(
            ShortenedUrlModel(alias: 'test', links: UrlLinksModel.empty()),
          );
        });

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();

        await tester.tap(find.byKey(const Key('shorten_button')));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Shorten URL'), findsNothing);

        await tester.pump(const Duration(seconds: 1)); // Start
        await tester.pump(); // Wait for Future

        await tester.pump(const Duration(seconds: 3)); // Update state
      });

      testWidgets('should show success state after shortening URL', (
        tester,
      ) async {
        final fakeModel = ShortenedUrlModel(
          alias: 'test-alias',
          links: UrlLinksModel(
            self: 'https://www.google.com',
            short: 'https://short.url/test',
          ),
        );

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Right(fakeModel));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
        await tester.pump();

        expect(find.byType(FeedbackMessageWidget), findsOneWidget);
        expect(find.text('Link shortened successfully!'), findsOneWidget);

        final textField = tester.widget<TextFormField>(
          find.byType(TextFormField),
        );
        expect(textField.controller?.text, isEmpty);

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should show error state on failure', (tester) async {
        final exception = HttpException('Network error');

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Left(exception));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
        await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(find.byType(FeedbackMessageWidget), findsOneWidget);
        expect(find.text('Network error'), findsOneWidget);

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should show error when trying to shorten with empty field', (
        tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.byKey(const Key('shorten_button')));
        await tester.pump();

        expect(find.text('Please enter a URL'), findsOneWidget);
      });

      testWidgets(
        'should show validation error for invalid URL when clicking button',
        (tester) async {
          await tester.pumpWidget(createWidgetUnderTest());

          // Entrar URL inválida usando key
          await tester.enterText(
            find.byKey(const Key('url_input_field')),
            'invalid-url',
          );
          await tester.pump();

          // Clicar no botão para validar usando key
          await tester.tap(find.byKey(const Key('shorten_button')));
          await tester.pump();

          expect(
            find.text('Please enter a valid URL(https://example.com)'),
            findsOneWidget,
          );
        },
      );

      testWidgets('should validate URL correctly', (tester) async {
        when(() => shortenerService.shortUrl(any())).thenAnswer(
          (_) async => Right(
            ShortenedUrlModel(alias: 'test', links: UrlLinksModel.empty()),
          ),
        );

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byKey(const Key('url_input_field')),
          'https://www.google.com',
        );
        await tester.pump();

        await tester.tap(find.byKey(const Key('shorten_button')));
        await tester.pump();

        expect(find.text('Please enter a URL'), findsNothing);
        expect(
          find.text('Please enter a valid URL(https://example.com)'),
          findsNothing,
        );

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should dismiss success message when clicking close button', (
        tester,
      ) async {
        final fakeModel = ShortenedUrlModel(
          alias: 'test-alias',
          links: UrlLinksModel.empty(),
        );

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Right(fakeModel));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
        await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(find.text('Link shortened successfully!'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();

        expect(find.text('Link shortened successfully!'), findsNothing);

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should update controller history when URL is shortened', (
        tester,
      ) async {
        final fakeModel = ShortenedUrlModel(
          alias: 'test-alias',
          links: UrlLinksModel(
            self: 'https://www.google.com',
            short: 'https://short.url/test',
          ),
        );

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Right(fakeModel));

        await tester.pumpWidget(createWidgetUnderTest());

        expect(controller.value.history, isEmpty);

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();

        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
       await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(controller.value.history.length, 1);
        expect(controller.value.history.first.alias, 'test-alias');

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should show empty state when history is empty', (
        tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Recent Links (0)'), findsOneWidget);
        expect(find.byType(EmptyListWidget), findsOneWidget);
      });
    });

    // PRIORITY 2: WIDGET TEXT

    group('Widget Text', () {
      testWidgets('should display header texts correctly', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byKey(const Key('header_title')), findsOneWidget);
        expect(find.byKey(const Key('header_subtitle')), findsOneWidget);
      });

      testWidgets('should display input field placeholder', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byKey(const Key('url_input_field')), findsOneWidget);
      });

      testWidgets('should display button text', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Shorten URL'), findsOneWidget);
      });

      testWidgets('should display URL validation message', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(find.byType(TextFormField), 'invalid-url');
        await tester.pump();

        // Clicar no botão para validar
        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
        await tester.pump();

        expect(
          find.text('Please enter a valid URL(https://example.com)'),
          findsOneWidget,
        );
      });

      testWidgets('should display success message', (tester) async {
        final fakeModel = ShortenedUrlModel(
          alias: 'test-alias',
          links: UrlLinksModel.empty(),
        );

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Right(fakeModel));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
        await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(find.text('Link shortened successfully!'), findsOneWidget);

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should display error message', (tester) async {
        final exception = HttpException('Network error');

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Left(exception));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
       await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(find.text('Network error'), findsOneWidget);

        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should display link counter in history', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byKey(const Key('history_title')), findsOneWidget);
      });

      testWidgets('should display empty state texts', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('No shortened links'), findsOneWidget);
        expect(find.text('Paste a URL above to get started.'), findsOneWidget);
      });
    });

    // PRIORITY 3: WIDGET ICONS

    group('Widget Icons', () {
      testWidgets('should display header icon (scissors)', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byKey(const Key('header_icon')), findsOneWidget);
      });

      testWidgets('should display input field icon (link)', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byKey(const Key('url_input_field')), findsOneWidget);
      });

      testWidgets('should display success icon in feedback message', (
        tester,
      ) async {
        final fakeModel = ShortenedUrlModel(
          alias: 'test-alias',
          links: UrlLinksModel.empty(),
        );

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Right(fakeModel));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));
        await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(
          find.byIcon(Icons.check_circle_outline_outlined),
          findsOneWidget,
        );

        // Aguardar o timer de auto-dismiss completar
        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should display error icon in feedback message', (
        tester,
      ) async {
        final exception = HttpException('Network error');

        when(
          () => shortenerService.shortUrl(any()),
        ).thenAnswer((_) async => Left(exception));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(
          find.byType(TextFormField),
          'https://www.google.com',
        );
        await tester.pump();
        await tester.tap(find.widgetWithText(ElevatedButton, 'Shorten URL'));

        await tester.pump(); // Start
        await tester.pump(); // Wait for Future
        await tester.pump(); // Update state

        expect(find.byIcon(Icons.error_outline), findsOneWidget);

        // Aguardar o timer de auto-dismiss completar
        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('should display empty list icon (link2)', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byIcon(LucideIcons.link2), findsOneWidget);
      });
    });

    // ============================================================
    // PRIORITY 4: RESPONSIVENESS
    // ============================================================
    group('Responsiveness', () {
      testWidgets('should render correctly on small screen (mobile)', (
        tester,
      ) async {
        // Simular tela de celular (iPhone SE)
        await tester.binding.setSurfaceSize(const Size(375, 667));

        await tester.pumpWidget(createWidgetUnderTest());

        // Verificar que todos os elementos principais estão presentes
        expect(find.text('URL Shortener'), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Shorten URL'), findsOneWidget);
        expect(find.byType(EmptyListWidget), findsOneWidget);

        // Reset para tamanho padrão
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should render correctly on medium screen (tablet)', (
        tester,
      ) async {
        // Simular tela de tablet (iPad)
        await tester.binding.setSurfaceSize(const Size(768, 1024));

        await tester.pumpWidget(createWidgetUnderTest());

        // Verificar que todos os elementos principais estão presentes
        expect(find.text('URL Shortener'), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Shorten URL'), findsOneWidget);
        expect(find.byType(EmptyListWidget), findsOneWidget);

        // Reset para tamanho padrão
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should allow scrolling when content exceeds screen height', (
        tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Verificar que SingleChildScrollView está presente
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('should apply correct padding to main container', (
        tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest());

        // Encontrar o container principal com padding
        final container = tester.widget<Container>(
          find
              .descendant(
                of: find.byType(SingleChildScrollView),
                matching: find.byType(Container),
              )
              .first,
        );

        expect(
          container.padding,
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        );
      });
    });
  });
}
