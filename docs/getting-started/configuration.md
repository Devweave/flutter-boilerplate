# Configuration

Learn how to configure Flutter Boilerplate for your project.

## API Keys Configuration

### Setup API Keys File

1. Copy the example file:
   ```bash
   cp api-keys.example.json api-keys.json
   ```

2. Edit `api-keys.json` with your actual keys:
   ```json
   {
     "API_BASE_URL": "https://api.example.com",
     "API_KEY": "your-api-key-here",
     "GOOGLE_MAPS_API_KEY": "your-google-maps-key"
   }
   ```

3. **Never commit `api-keys.json`** - it's in `.gitignore`

### Using API Keys in Code

API keys are loaded via `--dart-define-from-file`:

```dart
// Access in code
const apiKey = String.fromEnvironment('API_KEY');
const baseUrl = String.fromEnvironment('API_BASE_URL');
```

## Environment Configuration

### Development vs Production

Create separate configuration files:

- `api-keys.dev.json` - Development keys
- `api-keys.prod.json` - Production keys

Run with specific environment:
```bash
# Development
fvm flutter run --dart-define-from-file=api-keys.dev.json

# Production
fvm flutter run --dart-define-from-file=api-keys.prod.json
```

## Platform-Specific Configuration

### Android

**File**: `android/app/build.gradle`

```gradle
android {
    defaultConfig {
        applicationId "com.yourcompany.yourapp"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
}
```

**Signing Configuration** (for release builds):

1. Create keystore:
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias upload
   ```

2. Create `android/key.properties`:
   ```properties
   storePassword=your-store-password
   keyPassword=your-key-password
   keyAlias=upload
   storeFile=/path/to/upload-keystore.jks
   ```

3. Add to `.gitignore`: `android/key.properties`

### iOS

**File**: `ios/Runner/Info.plist`

Configure app permissions:
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>We need location to show nearby places</string>
```

**Signing**:
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner target
3. Go to Signing & Capabilities
4. Select your team and configure signing

### Web

**File**: `web/index.html`

Add meta tags and configure:
```html
<head>
  <meta name="description" content="Your app description">
  <meta name="keywords" content="flutter, app">
  <!-- Add your meta tags -->
</head>
```

## App Configuration

### Change App Name

Use the rename package:
```bash
make rename APP_NAME="My App" BUNDLE_ID="com.example.myapp"
```

Or manually:
```bash
fvm flutter pub run rename --appname "My App"
fvm flutter pub run rename --bundleId com.example.myapp
```

### Configure App Icon

1. Place your icon in `assets/icon/app_icon.png` (1024x1024)
2. Update `pubspec.yaml`:
   ```yaml
   flutter_launcher_icons:
     android: true
     ios: true
     image_path: "assets/icon/app_icon.png"
   ```
3. Generate icons:
   ```bash
   fvm flutter pub run flutter_launcher_icons
   ```

### Configure Splash Screen

Update `pubspec.yaml`:
```yaml
flutter_native_splash:
  color: "#ffffff"
  image: assets/splash/splash.png
  android: true
  ios: true
```

Generate splash:
```bash
fvm flutter pub run flutter_native_splash:create
```

## Network Configuration

### API Base URL

Configure in `lib/core/network/network_module.dart`:

```dart
@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.example.com',
      ),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    return dio;
  }
}
```

### Interceptors

Add custom interceptors in `lib/core/network/api_client.dart`.

## Localization

### Add New Language

1. Create ARB file: `lib/core/l10n/arb/app_es.arb`
2. Add translations
3. Run code generation: `make gen`
4. Add locale to `lib/app.dart`:
   ```dart
   supportedLocales: const [
     Locale('en'),
     Locale('id'),
     Locale('es'), // New language
   ],
   ```

## Next Steps

- [Quick Start](quick-start.md) - Run the application
- [Development Tools](../development/tools.md) - Learn about tools
- [API Integration](../guides/api-integration.md) - Integrate with APIs
