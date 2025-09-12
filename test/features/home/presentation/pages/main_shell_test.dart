import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/home/presentation/pages/main_shell.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('MainShell Widget Tests', () {
    Widget createTestWidget({Widget? child}) {
      return MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/home',
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => MainShell(
                child: child ?? const Center(child: Text('Home Content')),
              ),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => MainShell(
                child: child ?? const Center(child: Text('Profile Content')),
              ),
            ),
          ],
        ),
      );
    }

    testWidgets('should render correctly with child widget', (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(MainShell), findsOneWidget);
      expect(find.text('Test Child'), findsOneWidget);
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('should show bottom navigation bar with correct items',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);

      // Check for icons (should find at least one of each type)
      expect(find.byType(Icon), findsWidgets);
    });

    testWidgets('should have navigation tabs that are tappable',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Verify tabs exist and are tappable
      final berandaTab = find.text('Beranda');
      final profilTab = find.text('Profil');

      expect(berandaTab, findsOneWidget);
      expect(profilTab, findsOneWidget);

      // Test tapping (basic functionality test)
      await tester.tap(berandaTab);
      await tester.pump();

      await tester.tap(profilTab);
      await tester.pump();

      // Should still be there after taps
      expect(berandaTab, findsOneWidget);
      expect(profilTab, findsOneWidget);
    });

    testWidgets('should have proper styling for custom navigation bar',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Check custom navigation container with SafeArea
      final safeAreaFinder = find.byType(SafeArea);
      expect(safeAreaFinder, findsWidgets);

      // Verify the navigation bar has Row structure with GestureDetector items
      final gestureDetectorFinder = find.byType(GestureDetector);
      expect(gestureDetectorFinder, findsNWidgets(2)); // Two navigation items

      // Verify the navigation bar has the expected text labels
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('should have animated icon switching', (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check for AnimatedSwitcher
      expect(
        find.byType(AnimatedSwitcher),
        findsNWidgets(2),
      ); // One for each nav item

      final animatedSwitchers = tester.widgetList<AnimatedSwitcher>(
        find.byType(AnimatedSwitcher),
      );

      for (final switcher in animatedSwitchers) {
        expect(switcher.duration, equals(const Duration(milliseconds: 200)));
      }
    });

    testWidgets('should handle tap gesture properly', (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check for GestureDetector
      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsNWidgets(2)); // One for each nav item

      final gestureDetector =
          tester.widget<GestureDetector>(gestureDetectors.first);
      expect(gestureDetector.onTap, isNotNull);
      expect(gestureDetector.behavior, equals(HitTestBehavior.opaque));
    });

    testWidgets('should have correct text styling for labels', (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);

      // Check that text widgets exist and are styled
      final berandaText = tester.widget<Text>(find.text('Beranda'));
      final profilText = tester.widget<Text>(find.text('Profil'));

      expect(berandaText.style, isNotNull);
      expect(profilText.style, isNotNull);
    });

    testWidgets('should have proper spacing between icon and text',
        (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check for SizedBox with height 4 (spacing)
      final spacingSizedBoxes = tester
          .widgetList<SizedBox>(find.byType(SizedBox))
          .where((sizedBox) => sizedBox.height == 4)
          .toList();

      expect(spacingSizedBoxes.length, equals(2)); // One for each nav item
    });

    testWidgets('should adapt to different themes correctly', (tester) async {
      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeData.dark(),
          routerConfig: GoRouter(
            initialLocation: '/home',
            routes: [
              ShellRoute(
                builder: (context, state, child) => MainShell(child: child),
                routes: [
                  GoRoute(
                    path: '/home',
                    builder: (context, state) => const Scaffold(
                      body: Center(child: Text('Home Page')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - should render without errors in dark theme
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('should have proper container padding for nav items',
        (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Find containers inside GestureDetectors
      final navItemContainers = find.descendant(
        of: find.byType(GestureDetector),
        matching: find.byType(Container),
      );

      expect(navItemContainers, findsNWidgets(2));

      // Check padding
      for (int i = 0; i < 2; i++) {
        final container =
            tester.widgetList<Container>(navItemContainers).elementAt(i);
        expect(
          container.padding,
          equals(const EdgeInsets.symmetric(horizontal: 20)),
        );
      }
    });

    testWidgets('should center nav items with proper alignment',
        (tester) async {
      // Act
      await tester.pumpWidget(
        createTestWidget(
          child: const Center(child: Text('Test Child')),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - Check Row alignment
      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, equals(MainAxisAlignment.spaceAround));

      // Check Column alignment in nav items
      final columns = find.descendant(
        of: find.byType(GestureDetector),
        matching: find.byType(Column),
      );
      expect(columns, findsNWidgets(2));

      final column = tester.widget<Column>(columns.first);
      expect(column.mainAxisAlignment, equals(MainAxisAlignment.center));
    });
  });
}
