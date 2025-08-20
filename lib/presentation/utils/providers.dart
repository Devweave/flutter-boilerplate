import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/locator/injectable.dart';
import 'package:flutter_boilerplate/presentation/bloc/auth/auth_bloc.dart';

final appProviders = [
  BlocProvider(create: (_) => getIt<AuthBloc>()),
];
