import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/extentions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContextExtensions', () {
    testWidgets('dw should return screen width', (WidgetTester tester) async {
      late double screenWidth;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                screenWidth = context.dw;
                return Container();
              },
            ),
          ),
        ),
      );

      expect(
        screenWidth,
        tester.view.physicalSize.width / tester.view.devicePixelRatio,
      );
    });

    testWidgets('dh should return screen height', (WidgetTester tester) async {
      late double screenHeight;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                screenHeight = context.dh;
                return Container();
              },
            ),
          ),
        ),
      );

      expect(
        screenHeight,
        tester.view.physicalSize.height / tester.view.devicePixelRatio,
      );
    });

    testWidgets('textScaler should return MediaQuery textScaler',
        (WidgetTester tester) async {
      late TextScaler textScaler;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                textScaler = context.textScaler;
                return Container();
              },
            ),
          ),
        ),
      );

      expect(textScaler, isA<TextScaler>());
    });

    testWidgets('should work with custom MediaQuery data',
        (WidgetTester tester) async {
      const customSize = Size(400, 600);
      const customTextScaler = TextScaler.linear(1.5);
      late double width, height;
      late TextScaler scaler;

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: customSize,
              textScaler: customTextScaler,
            ),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  width = context.dw;
                  height = context.dh;
                  scaler = context.textScaler;
                  return Container();
                },
              ),
            ),
          ),
        ),
      );

      expect(width, customSize.width);
      expect(height, customSize.height);
      expect(scaler, customTextScaler);
    });
  });
}
