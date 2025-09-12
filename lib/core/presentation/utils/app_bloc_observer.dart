import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final Logger _logger = Logger();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.d('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.d('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.d('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.d(
      'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.e('onError -- bloc: ${bloc.runtimeType}, error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.d('onClose -- bloc: ${bloc.runtimeType}');
  }
}
