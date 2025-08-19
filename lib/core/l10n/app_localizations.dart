import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// Judul aplikasi
  ///
  /// In id, this message translates to:
  /// **'Flutter Boilerplate'**
  String get appTitle;

  /// Pesan selamat datang
  ///
  /// In id, this message translates to:
  /// **'Selamat Datang'**
  String get welcome;

  /// Label tombol masuk
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get login;

  /// Label tombol keluar
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logout;

  /// Label field email
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get email;

  /// Label field kata sandi
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get password;

  /// Hint untuk field email
  ///
  /// In id, this message translates to:
  /// **'Masukkan email Anda'**
  String get emailHint;

  /// Hint untuk field kata sandi
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi Anda'**
  String get passwordHint;

  /// Text tombol masuk
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginButton;

  /// Pesan sukses login
  ///
  /// In id, this message translates to:
  /// **'Berhasil masuk'**
  String get loginSuccess;

  /// Pesan error login
  ///
  /// In id, this message translates to:
  /// **'Gagal masuk'**
  String get loginError;

  /// Pesan error email atau password salah
  ///
  /// In id, this message translates to:
  /// **'Email atau kata sandi tidak valid'**
  String get invalidEmailPassword;

  /// Pesan error field kosong
  ///
  /// In id, this message translates to:
  /// **'Email dan kata sandi tidak boleh kosong'**
  String get emptyEmailPassword;

  /// Label halaman beranda
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get home;

  /// Label halaman profil
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// Sapaan dengan nama
  ///
  /// In id, this message translates to:
  /// **'Halo, {name}!'**
  String hello(String name);

  /// Pesan loading
  ///
  /// In id, this message translates to:
  /// **'Memuat...'**
  String get loading;

  /// Pesan error umum
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan'**
  String get error;

  /// Tombol coba lagi
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get retry;

  /// Tombol batal
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// Tombol konfirmasi
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get confirm;

  /// Tombol simpan
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
