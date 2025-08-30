import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/utils/constants.dart';
import 'package:flutter_boilerplate/features/app/presentation/utils/providers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_boilerplate/features/app/presentation/router/app_router.dart';
import 'package:flutter_boilerplate/features/app/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appProviders,
      child: MaterialApp.router(
        title: Constants.kAppName,
        debugShowCheckedModeBanner: false,

        // Theme
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // Localization
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', ''), // Indonesian
          Locale('en', ''), // English
        ],
        locale: const Locale('id', ''), // Default to Indonesian

        // Router
        routerConfig: AppRouter.router,
      ),
    );
  }
}
