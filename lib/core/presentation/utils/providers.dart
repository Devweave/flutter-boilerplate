import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/locator/injectable.dart';
import 'package:flutter_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';

final appProviders = [
  BlocProvider(create: (_) => getIt<AuthBloc>()),
];
