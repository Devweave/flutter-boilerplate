# Installation

Detailed installation instructions for Flutter Boilerplate.

## Prerequisites

Ensure you have the following installed:

### Required
- **Flutter SDK**: 3.32.4
- **FVM** (Flutter Version Management): [Installation Guide](https://fvm.app/docs/getting_started/installation)
- **Git**: For version control
- **Code Editor**: VS Code or Android Studio recommended

### Platform-Specific Requirements

#### Android Development
- Android Studio or Android SDK
- Java Development Kit (JDK) 17 or higher
- Android SDK Platform Tools
- Android Emulator or physical device

#### iOS Development (macOS only)
- Xcode 15.0 or higher
- CocoaPods: `sudo gem install cocoapods`
- iOS Simulator or physical device
- Apple Developer account (for device testing)

#### Web Development
- Chrome browser for debugging
- No additional setup required

#### Desktop Development
- **Windows**: Visual Studio 2022 with C++ development tools
- **macOS**: Xcode command line tools
- **Linux**: Required packages vary by distribution

## Installation Steps

### 1. Install FVM

```bash
# Using Dart pub
dart pub global activate fvm

# Using Homebrew (macOS/Linux)
brew tap leoafarias/fvm
brew install fvm
```

### 2. Clone the Repository

```bash
git clone https://github.com/Devweave/flutter-boilerplate.git
cd flutter-boilerplate
```

### 3. Setup Flutter Version

```bash
fvm install 3.32.4
fvm use 3.32.4
```

### 4. Bootstrap the Project

⚠️ **CRITICAL**: This step is required for all new clones!

```bash
make bootstrap
```

This command will:
- Install all dependencies
- Generate required code
- Setup git pre-commit hooks
- Configure the development environment

### 5. Configure API Keys

```bash
cp api-keys.example.json api-keys.json
# Edit api-keys.json with your actual API keys
```

### 6. Verify Installation

```bash
# Check Flutter installation
fvm flutter doctor

# Run tests
make test

# Try running the app
make run
```

## Platform Setup

### Android

1. Install Android Studio
2. Open Android Studio → SDK Manager
3. Install required SDK platforms and tools
4. Create an emulator or connect a physical device
5. Run: `make run`

### iOS (macOS only)

1. Install Xcode from App Store
2. Install command line tools: `xcode-select --install`
3. Install CocoaPods: `sudo gem install cocoapods`
4. Navigate to iOS folder: `cd ios`
5. Install pods: `pod install`
6. Open Xcode and configure signing
7. Run: `make run`

### Web

No additional setup required. Just run:
```bash
fvm flutter run -d chrome
```

## Troubleshooting

### FVM Command Not Found

Add FVM to your PATH:
```bash
# Add to ~/.zshrc or ~/.bashrc
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### Git Hooks Not Working

Manually setup hooks:
```bash
make setup-git-hooks
```

### Build Runner Errors

Clean and regenerate:
```bash
make clean
make gen
```

### CocoaPods Issues (iOS)

```bash
cd ios
pod deintegrate
pod install
```

## Next Steps

- [Configuration](configuration.md) - Configure API keys and environment
- [Quick Start](quick-start.md) - Run your first build
- [Development Tools](../development/tools.md) - Learn about available tools
