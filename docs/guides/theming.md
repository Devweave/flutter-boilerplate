# Theming

Customizing app theme and styling.

## Theme Configuration

Theme is defined in `lib/core/theme/app_theme.dart`:

```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
```

## Using Theme

```dart
// In widgets
final theme = Theme.of(context);
final colorScheme = theme.colorScheme;

Container(
  color: colorScheme.primary,
  child: Text(
    'Hello',
    style: theme.textTheme.headlineMedium,
  ),
)
```

## Custom Colors

Extend ColorScheme:

```dart
extension CustomColors on ColorScheme {
  Color get success => const Color(0xFF4CAF50);
  Color get warning => const Color(0xFFFFC107);
  Color get danger => const Color(0xFFF44336);
}

// Usage
colorScheme.success
```

## Dark Mode

Toggle dark mode:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // or .light, .dark
)
```

## Text Styles

Use theme text styles:

```dart
Text('Title', style: theme.textTheme.titleLarge)
Text('Body', style: theme.textTheme.bodyMedium)
Text('Caption', style: theme.textTheme.bodySmall)
```

See [Material 3 Design](https://m3.material.io/) for guidelines.
