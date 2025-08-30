import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/app.dart';
import 'package:flutter_boilerplate/features/app/presentation/utils/app_bloc_observer.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:flutter_boilerplate/core/locator/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencyInjection();

  Bloc.observer = AppBlocObserver();

  runApp(const RequestsInspector(
    child: MyApp(),
  ));
}
