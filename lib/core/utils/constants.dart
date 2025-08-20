import 'package:flutter/material.dart';

class Constants {
  static const String kAppName = 'Flutter Boilerplate';
  static const String kBaseUrl = String.fromEnvironment('BASE_URL');
  static const bool kEnableChucker = bool.fromEnvironment(
    'ENABLE_CHUCKER',
    defaultValue: false,
  );
}

class LocalStorageKeys {}

class AppDimens {
  // Widths
  static const double width4 = 4.0;
  static const double width8 = 8.0;
  static const double width12 = 12.0;
  static const double width16 = 16.0;
  static const double width20 = 20.0;
  static const double width24 = 24.0;
  static const double width32 = 32.0;
  static const double width48 = 48.0;

  // Heights
  static const double height4 = 4.0;
  static const double height8 = 8.0;
  static const double height12 = 12.0;
  static const double height16 = 16.0;
  static const double height20 = 20.0;
  static const double height24 = 24.0;
  static const double height32 = 32.0;
  static const double height44 = 44.0;
  static const double height48 = 48.0;
  static const double height56 = 56.0;

  // Border Radius
  static const double radius4 = 4.0;
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius24 = 24.0;

  // Icon Sizes
  static const double icon16 = 16.0;
  static const double icon20 = 20.0;
  static const double icon24 = 24.0;
  static const double icon32 = 32.0;
  static const double icon48 = 48.0;
}

class AppSpaces {
  // Vertical spaces
  static const Widget vertical4 = SizedBox(height: 4.0);
  static const Widget vertical8 = SizedBox(height: 8.0);
  static const Widget vertical12 = SizedBox(height: 12.0);
  static const Widget vertical16 = SizedBox(height: 16.0);
  static const Widget vertical20 = SizedBox(height: 20.0);
  static const Widget vertical24 = SizedBox(height: 24.0);
  static const Widget vertical32 = SizedBox(height: 32.0);
  static const Widget vertical48 = SizedBox(height: 48.0);

  // Horizontal spaces
  static const Widget horizontal4 = SizedBox(width: 4.0);
  static const Widget horizontal8 = SizedBox(width: 8.0);
  static const Widget horizontal12 = SizedBox(width: 12.0);
  static const Widget horizontal16 = SizedBox(width: 16.0);
  static const Widget horizontal20 = SizedBox(width: 20.0);
  static const Widget horizontal24 = SizedBox(width: 24.0);
  static const Widget horizontal32 = SizedBox(width: 32.0);
  static const Widget horizontal48 = SizedBox(width: 48.0);
}
