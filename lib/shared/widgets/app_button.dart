import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    super.key,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final AppButtonVariant variant;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: _getHeight(),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(theme),
          foregroundColor: _getForegroundColor(theme),
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _getForegroundColor(theme),
                ),
              )
            : Text(
                text,
                style: _getTextStyle(theme),
              ),
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 56;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24);
    }
  }

  Color _getBackgroundColor(ThemeData theme) {
    switch (variant) {
      case AppButtonVariant.primary:
        return theme.primaryColor;
      case AppButtonVariant.secondary:
        return theme.colorScheme.secondary;
      case AppButtonVariant.outline:
        return Colors.transparent;
      case AppButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor(ThemeData theme) {
    switch (variant) {
      case AppButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case AppButtonVariant.secondary:
        return theme.colorScheme.onSecondary;
      case AppButtonVariant.outline:
        return theme.primaryColor;
      case AppButtonVariant.ghost:
        return theme.primaryColor;
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    final baseStyle = theme.textTheme.labelLarge ?? const TextStyle();

    switch (size) {
      case AppButtonSize.small:
        return baseStyle.copyWith(fontSize: 12);
      case AppButtonSize.medium:
        return baseStyle.copyWith(fontSize: 14);
      case AppButtonSize.large:
        return baseStyle.copyWith(fontSize: 16);
    }
  }
}

enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

enum AppButtonSize {
  small,
  medium,
  large,
}
