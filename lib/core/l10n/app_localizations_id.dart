// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Flutter Boilerplate';

  @override
  String get welcome => 'Selamat Datang';

  @override
  String get login => 'Masuk';

  @override
  String get logout => 'Keluar';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get emailHint => 'Masukkan email Anda';

  @override
  String get passwordHint => 'Masukkan kata sandi Anda';

  @override
  String get loginButton => 'Masuk';

  @override
  String get loginSuccess => 'Berhasil masuk';

  @override
  String get loginError => 'Gagal masuk';

  @override
  String get invalidEmailPassword => 'Email atau kata sandi tidak valid';

  @override
  String get emptyEmailPassword => 'Email dan kata sandi tidak boleh kosong';

  @override
  String get home => 'Beranda';

  @override
  String get profile => 'Profil';

  @override
  String hello(String name) {
    return 'Halo, $name!';
  }

  @override
  String get loading => 'Memuat...';

  @override
  String get error => 'Terjadi kesalahan';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get save => 'Simpan';
}
