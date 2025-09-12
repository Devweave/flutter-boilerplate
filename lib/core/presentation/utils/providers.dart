import 'package:flutter_bloc/flutter_bloc.dart';
import '../../locator/injectable.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';

final appProviders = [
  BlocProvider(create: (_) => getIt<AuthBloc>()),
];
