import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user.dart';

void main() {
  group('User Entity', () {
    group('Constructor', () {
      test('should create user with all required fields', () {
        // arrange & act
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // assert
        expect(user.id, '1');
        expect(user.name, 'John Doe');
        expect(user.email, 'john@example.com');
        expect(user.avatar, isNull);
        expect(user.isActive, false);
      });

      test('should create user with all fields including optional ones', () {
        // arrange & act
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'https://example.com/avatar.jpg',
          isActive: true,
        );

        // assert
        expect(user.id, '1');
        expect(user.name, 'John Doe');
        expect(user.email, 'john@example.com');
        expect(user.avatar, 'https://example.com/avatar.jpg');
        expect(user.isActive, true);
      });
    });

    group('Default values', () {
      test('should have default isActive as false', () {
        // arrange & act
        const user = User(
          id: '1',
          name: 'John',
          email: 'john@test.com',
        );

        // assert
        expect(user.isActive, false);
        expect(user.avatar, isNull);
      });
    });

    group('Equality', () {
      test('should be equal when all properties are same', () {
        // arrange
        const user1 = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );
        const user2 = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // assert
        expect(user1, equals(user2));
        expect(user1.hashCode, equals(user2.hashCode));
      });

      test('should not be equal when id is different', () {
        // arrange
        const user1 = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );
        const user2 = User(
          id: '2',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // assert
        expect(user1, isNot(equals(user2)));
        expect(user1.hashCode, isNot(equals(user2.hashCode)));
      });

      test('should not be equal when name is different', () {
        // arrange
        const user1 = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );
        const user2 = User(
          id: '1',
          name: 'Jane Doe',
          email: 'john@example.com',
        );

        // assert
        expect(user1, isNot(equals(user2)));
      });

      test('should not be equal when isActive is different', () {
        // arrange
        const user1 = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          isActive: true,
        );
        const user2 = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          isActive: false,
        );

        // assert
        expect(user1, isNot(equals(user2)));
      });
    });

    group('CopyWith', () {
      test('should create copy with updated id', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // act
        final updatedUser = user.copyWith(id: '2');

        // assert
        expect(updatedUser.id, '2');
        expect(updatedUser.name, 'John Doe');
        expect(updatedUser.email, 'john@example.com');
        expect(user.id, '1'); // original should be unchanged
      });

      test('should create copy with updated name', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // act
        final updatedUser = user.copyWith(name: 'Jane Doe');

        // assert
        expect(updatedUser.id, '1');
        expect(updatedUser.name, 'Jane Doe');
        expect(updatedUser.email, 'john@example.com');
      });

      test('should create copy with updated avatar', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // act
        final updatedUser = user.copyWith(avatar: 'new-avatar.jpg');

        // assert
        expect(updatedUser.id, '1');
        expect(updatedUser.name, 'John Doe');
        expect(updatedUser.email, 'john@example.com');
        expect(updatedUser.avatar, 'new-avatar.jpg');
      });

      test('should create copy with updated isActive status', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          isActive: false,
        );

        // act
        final updatedUser = user.copyWith(isActive: true);

        // assert
        expect(updatedUser.id, '1');
        expect(updatedUser.name, 'John Doe');
        expect(updatedUser.email, 'john@example.com');
        expect(updatedUser.isActive, true);
      });

      test('should create copy with multiple updated fields', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // act
        final updatedUser = user.copyWith(
          id: '2',
          name: 'Jane Smith',
          email: 'jane.smith@example.com',
          avatar: 'jane-avatar.jpg',
          isActive: true,
        );

        // assert
        expect(updatedUser.id, '2');
        expect(updatedUser.name, 'Jane Smith');
        expect(updatedUser.email, 'jane.smith@example.com');
        expect(updatedUser.avatar, 'jane-avatar.jpg');
        expect(updatedUser.isActive, true);
      });
    });

    group('JSON serialization', () {
      test('should create user from JSON', () {
        // arrange
        final json = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john@example.com',
          'avatar': 'avatar.jpg',
          'isActive': true,
        };

        // act
        final user = User.fromJson(json);

        // assert
        expect(user.id, '1');
        expect(user.name, 'John Doe');
        expect(user.email, 'john@example.com');
        expect(user.avatar, 'avatar.jpg');
        expect(user.isActive, true);
      });

      test('should convert user to JSON', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final json = user.toJson();

        // assert
        expect(json['id'], '1');
        expect(json['name'], 'John Doe');
        expect(json['email'], 'john@example.com');
        expect(json['avatar'], 'avatar.jpg');
        expect(json['isActive'], true);
      });

      test('should handle JSON with missing optional fields', () {
        // arrange
        final json = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john@example.com',
        };

        // act
        final user = User.fromJson(json);

        // assert
        expect(user.id, '1');
        expect(user.name, 'John Doe');
        expect(user.email, 'john@example.com');
        expect(user.avatar, isNull);
        expect(user.isActive, false);
      });
    });

    group('ToString', () {
      test('should return string representation of user', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // act
        final result = user.toString();

        // assert
        expect(result, contains('User'));
        expect(result, contains('1'));
        expect(result, contains('John Doe'));
        expect(result, contains('john@example.com'));
      });
    });
  });
}
