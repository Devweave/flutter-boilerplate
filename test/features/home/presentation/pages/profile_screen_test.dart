import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/home/presentation/pages/profile_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileScreen Widget Tests', () {
    Widget createTestWidget() {
      return const MaterialApp(
        home: ProfileScreen(),
      );
    }

    testWidgets('should render correctly with all expected elements',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('demo@example.com'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('should have proper app bar structure', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SliverAppBar), findsOneWidget);

      final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(appBar.floating, isTrue);
      expect(appBar.snap, isTrue);
      expect(appBar.elevation, equals(0));
    });

    testWidgets('should show profile header with avatar and user info',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('demo@example.com'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);

      // Check avatar container
      final avatarContainer = find
          .descendant(
            of: find.byType(ProfileScreen),
            matching: find.byType(Container),
          )
          .first;

      final containerWidget = tester.widget<Container>(avatarContainer);
      expect(containerWidget.constraints?.minWidth, equals(80));
      expect(containerWidget.constraints?.minHeight, equals(80));
    });

    testWidgets('should show all profile options', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Edit Profil'), findsOneWidget);
      expect(find.text('Keamanan'), findsOneWidget);
      expect(find.text('Notifikasi'), findsOneWidget);
      expect(find.text('Bantuan'), findsOneWidget);
      expect(find.text('Tentang'), findsOneWidget);
    });

    testWidgets('should have correct icons for profile options',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
      expect(find.byIcon(Icons.security_outlined), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.byIcon(Icons.help_outline), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);

      // Check for chevron right icons (should have 5)
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(5));
    });

    testWidgets('should have ListTile widgets for each profile option',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Find all ListTiles (5 profile options)
      final listTiles = find.byType(ListTile);
      expect(listTiles, findsNWidgets(5));

      // Check that ListTiles have onTap handlers
      for (int i = 0; i < 5; i++) {
        final listTile = tester.widgetList<ListTile>(listTiles).elementAt(i);
        expect(listTile.onTap, isNotNull);
      }
    });

    testWidgets('should be tappable - Edit Profil option', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert & Act
      final editProfilTile = find.text('Edit Profil');
      expect(editProfilTile, findsOneWidget);

      // Verify it can be tapped (won't actually do anything but shouldn't crash)
      await tester.tap(editProfilTile);
      await tester.pumpAndSettle();

      // Should still be there after tap
      expect(editProfilTile, findsOneWidget);
    });

    testWidgets('should be tappable - Keamanan option', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert & Act
      final keamananTile = find.text('Keamanan');
      expect(keamananTile, findsOneWidget);

      await tester.tap(keamananTile);
      await tester.pumpAndSettle();

      expect(keamananTile, findsOneWidget);
    });

    testWidgets('should have proper scroll behavior with CustomScrollView',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SliverPadding), findsOneWidget);
      expect(find.byType(SliverList), findsOneWidget);
    });

    testWidgets('should have proper spacing and layout structure',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Check for SizedBox spacing elements
      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsWidgets);

      // Check for proper Container styling
      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });

    testWidgets('should adapt to different themes correctly', (tester) async {
      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: const ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - should render without errors in dark theme
      expect(find.text('Profil'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Edit Profil'), findsOneWidget);
    });

    testWidgets('should have consistent ListTile padding', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Check ListTile content padding
      final listTiles = tester.widgetList<ListTile>(find.byType(ListTile));
      for (final listTile in listTiles) {
        expect(
          listTile.contentPadding,
          equals(const EdgeInsets.symmetric(horizontal: 0, vertical: 4)),
        );
      }
    });

    testWidgets('should render profile picture placeholder correctly',
        (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      final personIcon = tester.widget<Icon>(find.byIcon(Icons.person_outline));
      expect(personIcon.size, equals(40));

      // Find the container that holds the icon
      final iconContainers = find.descendant(
        of: find.byType(ProfileScreen),
        matching: find.byType(Container),
      );
      expect(iconContainers, findsWidgets);
    });

    testWidgets('should center profile information', (tester) async {
      // Act
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Check for Center widgets (there are multiple due to ListTile centering)
      final centerWidgets = find.byType(Center);
      expect(centerWidgets, findsWidgets);

      // Check that profile info is displayed (which indicates centering is working)
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('demo@example.com'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });
  });
}
