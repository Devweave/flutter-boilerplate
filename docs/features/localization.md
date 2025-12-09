# Localization

Internationalization and localization support.

## Supported Languages

- English (en)
- Indonesian (id)

## Adding Translations

1. Edit ARB files in `lib/core/l10n/arb/`
2. Run code generation: `make gen`
3. Use in code:

```dart
Text(context.l10n.appTitle)
```

## Adding New Language

1. Create `app_es.arb` for Spanish
2. Add translations
3. Run `make gen`
4. Add locale to `supportedLocales` in `app.dart`

See [Configuration](../getting-started/configuration.md#localization) for details.
