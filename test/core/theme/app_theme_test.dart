import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/theme/app_colors.dart';
import 'package:flutter_boilerplate/core/theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors', () {
    test('should define primary colors', () {
      expect(AppColors.primary, const Color(0xFF1C1C1E));
      expect(AppColors.primaryDark, const Color(0xFF000000));
      expect(AppColors.primaryLight, const Color(0xFF3A3A3C));
    });

    test('should define secondary colors', () {
      expect(AppColors.secondary, const Color(0xFF6C6C70));
      expect(AppColors.secondaryDark, const Color(0xFF48484A));
      expect(AppColors.secondaryLight, const Color(0xFF8E8E93));
    });

    test('should define background colors', () {
      expect(AppColors.background, const Color(0xFFFFFFFF));
      expect(AppColors.surface, const Color(0xFFFFFFFF));
      expect(AppColors.surfaceVariant, const Color(0xFFFAFAFA));
    });

    test('should define text colors', () {
      expect(AppColors.onPrimary, const Color(0xFFFFFFFF));
      expect(AppColors.onSecondary, const Color(0xFFFFFFFF));
      expect(AppColors.onSurface, const Color(0xFF1C1C1E));
      expect(AppColors.onSurfaceVariant, const Color(0xFF6C6C70));
    });

    test('should define semantic colors', () {
      expect(AppColors.error, const Color(0xFFE53E3E));
      expect(AppColors.warning, const Color(0xFFED8936));
      expect(AppColors.success, const Color(0xFF38A169));
      expect(AppColors.info, const Color(0xFF3182CE));
    });

    test('should define neutral colors', () {
      expect(AppColors.neutral50, const Color(0xFFFFFFFF));
      expect(AppColors.neutral100, const Color(0xFFFAFAFA));
      expect(AppColors.neutral200, const Color(0xFFF5F5F5));
      expect(AppColors.neutral300, const Color(0xFFE5E5E7));
      expect(AppColors.neutral400, const Color(0xFFD1D1D6));
      expect(AppColors.neutral500, const Color(0xFFAEAEB2));
      expect(AppColors.neutral600, const Color(0xFF8E8E93));
      expect(AppColors.neutral700, const Color(0xFF6C6C70));
      expect(AppColors.neutral800, const Color(0xFF3A3A3C));
      expect(AppColors.neutral900, const Color(0xFF1C1C1E));
    });

    test('should define border colors', () {
      expect(AppColors.border, const Color(0xFFE5E5E7));
      expect(AppColors.borderFocus, const Color(0xFF1C1C1E));
      expect(AppColors.borderError, const Color(0xFFE53E3E));
    });
  });

  group('AppTheme', () {
    group('lightTheme', () {
      late ThemeData lightTheme;

      setUp(() {
        lightTheme = AppTheme.lightTheme;
      });

      test('should use Material 3', () {
        expect(lightTheme.useMaterial3, isTrue);
      });

      test('should have light brightness', () {
        expect(lightTheme.brightness, Brightness.light);
      });

      test('should use correct primary colors in color scheme', () {
        expect(lightTheme.colorScheme.primary, AppColors.primary);
        expect(lightTheme.colorScheme.onPrimary, AppColors.onPrimary);
        expect(lightTheme.colorScheme.secondary, AppColors.secondary);
        expect(lightTheme.colorScheme.onSecondary, AppColors.onSecondary);
      });

      test('should use correct surface colors in color scheme', () {
        expect(lightTheme.colorScheme.surface, AppColors.surface);
        expect(lightTheme.colorScheme.onSurface, AppColors.onSurface);
        expect(
          lightTheme.colorScheme.surfaceContainerHighest,
          AppColors.surfaceContainerHighest,
        );
      });

      test('should use correct error color in color scheme', () {
        expect(lightTheme.colorScheme.error, AppColors.error);
      });

      test('should have correct AppBar theme', () {
        final appBarTheme = lightTheme.appBarTheme;
        expect(appBarTheme.elevation, 0);
        expect(appBarTheme.backgroundColor, AppColors.background);
        expect(appBarTheme.foregroundColor, AppColors.surfaceContainerHighest);
        expect(appBarTheme.surfaceTintColor, Colors.transparent);
      });

      test('should have correct AppBar title text style', () {
        final titleStyle = lightTheme.appBarTheme.titleTextStyle;
        expect(titleStyle?.color, AppColors.surfaceContainerHighest);
        expect(titleStyle?.fontSize, 18);
        expect(titleStyle?.fontWeight, FontWeight.w500);
        expect(titleStyle?.letterSpacing, -0.2);
      });

      test('should have correct AppBar icon theme', () {
        final iconTheme = lightTheme.appBarTheme.iconTheme;
        expect(iconTheme?.color, AppColors.surfaceContainerHighest);
        expect(iconTheme?.size, 20);
      });

      test('should have correct elevated button theme', () {
        final elevatedButtonTheme = lightTheme.elevatedButtonTheme;
        expect(elevatedButtonTheme, isNotNull);
      });

      test('should have input decoration theme', () {
        expect(lightTheme.inputDecorationTheme, isNotNull);
      });

      test('should have text theme', () {
        expect(lightTheme.textTheme, isNotNull);
      });
    });

    group('darkTheme', () {
      late ThemeData darkTheme;

      setUp(() {
        darkTheme = AppTheme.darkTheme;
      });

      test('should use Material 3', () {
        expect(darkTheme.useMaterial3, isTrue);
      });

      test('should have dark brightness', () {
        expect(darkTheme.brightness, Brightness.dark);
      });

      test('should have correct AppBar theme for dark mode', () {
        final appBarTheme = darkTheme.appBarTheme;
        expect(appBarTheme.elevation, null);
      });

      test('should have input decoration theme for dark mode', () {
        expect(darkTheme.inputDecorationTheme, isNotNull);
      });

      test('should have text theme for dark mode', () {
        expect(darkTheme.textTheme, isNotNull);
      });
    });
  });
}
