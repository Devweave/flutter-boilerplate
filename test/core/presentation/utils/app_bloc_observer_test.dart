import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/presentation/utils/app_bloc_observer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Simple test bloc for testing the observer
class TestBloc extends Bloc<String, int> {
  TestBloc() : super(0) {
    on<String>((event, emit) => emit(state + 1));
  }
}

class MockLogger extends Mock {
  void d(String message) {}
  void i(String message) {}
  void w(String message) {}
  void e(String message) {}
}

void main() {
  group('AppBlocObserver', () {
    late AppBlocObserver observer;
    late TestBloc testBloc;

    setUp(() {
      observer = AppBlocObserver();
      testBloc = TestBloc();
    });

    tearDown(() {
      testBloc.close();
    });

    test('should be a BlocObserver', () {
      expect(observer, isA<BlocObserver>());
    });

    test('onCreate should be called when bloc is created', () {
      // This test verifies that onCreate method exists and can be called
      // We can't easily test the Logger output without mocking, but we can
      // verify the method doesn't throw
      expect(() => observer.onCreate(testBloc), returnsNormally);
    });

    test('onEvent should be called when event is added', () {
      // This test verifies that onEvent method exists and can be called
      expect(() => observer.onEvent(testBloc, 'test_event'), returnsNormally);
    });

    test('onChange should be called when state changes', () {
      // Create a change object
      const change = Change<int>(currentState: 0, nextState: 1);

      // This test verifies that onChange method exists and can be called
      expect(() => observer.onChange(testBloc, change), returnsNormally);
    });

    test('onTransition should be called when transition occurs', () {
      // Create a transition object
      const transition = Transition<String, int>(
        currentState: 0,
        event: 'test_event',
        nextState: 1,
      );

      // This test verifies that onTransition method exists and can be called
      expect(
        () => observer.onTransition(testBloc, transition),
        returnsNormally,
      );
    });

    test('onError should be called when error occurs', () {
      final error = Exception('Test error');
      const stackTrace = StackTrace.empty;

      // This test verifies that onError method exists and can be called
      expect(
        () => observer.onError(testBloc, error, stackTrace),
        returnsNormally,
      );
    });

    test('onClose should be called when bloc is closed', () {
      // This test verifies that onClose method exists and can be called
      expect(() => observer.onClose(testBloc), returnsNormally);
    });
  });
}
