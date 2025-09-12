import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/utils/resources.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_boilerplate/features/home/presentation/pages/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../helpers/test_mocks.mocks.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    late MockAuthBloc mockAuthBloc;

    const testUser = User(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
    );

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    Widget createTestWidget(AuthState state) {
      return MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (context) => mockAuthBloc,
          child: const HomeScreen(),
        ),
      );
    }

    testWidgets('should show loading indicator when auth resource is loading',
        (tester) async {
      // Arrange
      final loadingState = AuthState.initial().copyWith(
        authResource: Resource.loading(),
      );
      when(mockAuthBloc.state).thenReturn(loadingState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(loadingState));

      // Act
      await tester.pumpWidget(createTestWidget(loadingState));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Beranda'), findsNothing);
    });

    testWidgets('should show error message when auth has error',
        (tester) async {
      // Arrange
      final errorState = AuthState.initial().copyWith(
        authResource: Resource.error('Authentication error'),
      );
      when(mockAuthBloc.state).thenReturn(errorState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(errorState));

      // Act
      await tester.pumpWidget(createTestWidget(errorState));

      // Assert
      expect(find.text('Tidak dapat memuat data'), findsOneWidget);
      expect(find.text('Beranda'), findsNothing);
    });

    testWidgets('should show home content when auth is successful with user',
        (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Halo, ${testUser.name}'), findsOneWidget);
      expect(find.text(testUser.email), findsOneWidget);
      expect(find.text('Login berhasil'), findsOneWidget);
    });

    testWidgets('should show welcome section with user info', (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Halo, ${testUser.name}'), findsOneWidget);
      expect(find.text(testUser.email), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });

    testWidgets('should show quick stats section', (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Ringkasan'), findsOneWidget);
      expect(find.text('12'), findsOneWidget); // Tasks count
      expect(find.text('Tugas'), findsOneWidget);
      expect(find.text('5'), findsOneWidget); // Notifications count
      expect(find.text('Notifikasi'), findsOneWidget);
      expect(find.byIcon(Icons.task_alt_outlined), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none_outlined), findsOneWidget);
    });

    testWidgets('should show recent activities section', (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Aktivitas Terbaru'), findsOneWidget);
      expect(find.text('Lihat Semua'), findsOneWidget);
      expect(find.text('Aktivitas 1'), findsOneWidget);
      expect(find.text('Aktivitas 2'), findsOneWidget);
      expect(find.text('Aktivitas 3'), findsOneWidget);
      expect(find.text('1 jam yang lalu'), findsOneWidget);
      expect(find.text('2 jam yang lalu'), findsOneWidget);
      expect(find.text('3 jam yang lalu'), findsOneWidget);
      expect(find.byIcon(Icons.history), findsNWidgets(3));
    });

    testWidgets('should have logout button that triggers logout event',
        (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Find and tap logout button
      final logoutButton = find.byIcon(Icons.logout_outlined);
      expect(logoutButton, findsOneWidget);

      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      // Assert
      verify(mockAuthBloc.add(const AuthEvent.logout())).called(1);
    });

    testWidgets('should have "Lihat Semua" button in recent activities section',
        (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert - just verify the button exists (navigation requires router setup)
      final seeAllButton = find.text('Lihat Semua');
      expect(seeAllButton, findsOneWidget);

      final textButton = tester.widget<TextButton>(
        find.ancestor(
          of: seeAllButton,
          matching: find.byType(TextButton),
        ),
      );
      expect(textButton.onPressed, isNotNull);
    });

    testWidgets('should have proper scroll behavior with CustomScrollView',
        (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(SliverPadding), findsOneWidget);
      expect(find.byType(SliverList), findsOneWidget);
    });

    testWidgets('should have floating and snap app bar', (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert
      final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
      expect(appBar.floating, isTrue);
      expect(appBar.snap, isTrue);
      expect(appBar.elevation, equals(0));
    });

    testWidgets('should show error state when auth resource has error',
        (tester) async {
      // Arrange
      final errorState = AuthState.initial().copyWith(
        authResource: Resource.error('Authentication failed'),
      );
      when(mockAuthBloc.state).thenReturn(errorState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(errorState));

      // Act
      await tester.pumpWidget(createTestWidget(errorState));

      // Assert
      expect(find.text('Tidak dapat memuat data'), findsOneWidget);
      expect(find.text('Beranda'), findsNothing);
    });

    testWidgets('should adapt to different themes correctly', (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - should render without errors in dark theme
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Halo, ${testUser.name}'), findsOneWidget);
    });

    testWidgets('should have proper spacing and layout structure',
        (tester) async {
      // Arrange
      final successState = AuthState.initial().copyWith(
        authResource: Resource.success(testUser),
      );
      when(mockAuthBloc.state).thenReturn(successState);
      when(mockAuthBloc.stream).thenAnswer((_) => Stream.value(successState));

      // Act
      await tester.pumpWidget(createTestWidget(successState));
      await tester.pumpAndSettle();

      // Assert spacing elements
      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsWidgets);

      // Check containers for styling
      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });
  });
}
