import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user.dart';

void main() {
  group('UserModel', () {
    group('Constructor', () {
      test('should create user model with all required fields', () {
        // arrange & act
        const userModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // assert
        expect(userModel.id, '1');
        expect(userModel.name, 'John Doe');
        expect(userModel.email, 'john@example.com');
        expect(userModel.avatar, isNull);
        expect(userModel.isActive, false);
      });

      test('should create user model with all fields including optional ones',
          () {
        // arrange & act
        const userModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'https://example.com/avatar.jpg',
          isActive: true,
        );

        // assert
        expect(userModel.id, '1');
        expect(userModel.name, 'John Doe');
        expect(userModel.email, 'john@example.com');
        expect(userModel.avatar, 'https://example.com/avatar.jpg');
        expect(userModel.isActive, true);
      });
    });

    group('fromEntity factory', () {
      test('should create UserModel from User entity', () {
        // arrange
        const user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final userModel = UserModel.fromEntity(user);

        // assert
        expect(userModel.id, user.id);
        expect(userModel.name, user.name);
        expect(userModel.email, user.email);
        expect(userModel.avatar, user.avatar);
        expect(userModel.isActive, user.isActive);
      });

      test('should create UserModel from User entity with null avatar', () {
        // arrange
        const user = User(
          id: '2',
          name: 'Jane Doe',
          email: 'jane@example.com',
          isActive: false,
        );

        // act
        final userModel = UserModel.fromEntity(user);

        // assert
        expect(userModel.id, '2');
        expect(userModel.name, 'Jane Doe');
        expect(userModel.email, 'jane@example.com');
        expect(userModel.avatar, isNull);
        expect(userModel.isActive, false);
      });
    });

    group('toEntity extension', () {
      test('should convert UserModel to User entity', () {
        // arrange
        const userModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final user = userModel.toEntity();

        // assert
        expect(user, isA<User>());
        expect(user.id, userModel.id);
        expect(user.name, userModel.name);
        expect(user.email, userModel.email);
        expect(user.avatar, userModel.avatar);
        expect(user.isActive, userModel.isActive);
      });

      test('should convert UserModel with null avatar to User entity', () {
        // arrange
        const userModel = UserModel(
          id: '2',
          name: 'Jane Doe',
          email: 'jane@example.com',
          isActive: false,
        );

        // act
        final user = userModel.toEntity();

        // assert
        expect(user.id, '2');
        expect(user.name, 'Jane Doe');
        expect(user.email, 'jane@example.com');
        expect(user.avatar, isNull);
        expect(user.isActive, false);
      });
    });

    group('Round trip conversion', () {
      test(
          'should maintain data integrity in entity -> model -> entity conversion',
          () {
        // arrange
        const originalUser = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final userModel = UserModel.fromEntity(originalUser);
        final convertedUser = userModel.toEntity();

        // assert
        expect(convertedUser, equals(originalUser));
        expect(convertedUser.id, originalUser.id);
        expect(convertedUser.name, originalUser.name);
        expect(convertedUser.email, originalUser.email);
        expect(convertedUser.avatar, originalUser.avatar);
        expect(convertedUser.isActive, originalUser.isActive);
      });

      test(
          'should maintain data integrity in model -> entity -> model conversion',
          () {
        // arrange
        const originalModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final user = originalModel.toEntity();
        final convertedModel = UserModel.fromEntity(user);

        // assert
        expect(convertedModel, equals(originalModel));
        expect(convertedModel.id, originalModel.id);
        expect(convertedModel.name, originalModel.name);
        expect(convertedModel.email, originalModel.email);
        expect(convertedModel.avatar, originalModel.avatar);
        expect(convertedModel.isActive, originalModel.isActive);
      });
    });

    group('JSON serialization', () {
      test('should create UserModel from JSON', () {
        // arrange
        final json = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john@example.com',
          'avatar': 'avatar.jpg',
          'isActive': true,
        };

        // act
        final userModel = UserModel.fromJson(json);

        // assert
        expect(userModel.id, '1');
        expect(userModel.name, 'John Doe');
        expect(userModel.email, 'john@example.com');
        expect(userModel.avatar, 'avatar.jpg');
        expect(userModel.isActive, true);
      });

      test('should convert UserModel to JSON', () {
        // arrange
        const userModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final json = userModel.toJson();

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
        final userModel = UserModel.fromJson(json);

        // assert
        expect(userModel.id, '1');
        expect(userModel.name, 'John Doe');
        expect(userModel.email, 'john@example.com');
        expect(userModel.avatar, isNull);
        expect(userModel.isActive, false);
      });

      test('should handle round trip JSON conversion', () {
        // arrange
        const originalModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // act
        final json = originalModel.toJson();
        final reconstructedModel = UserModel.fromJson(json);

        // assert
        expect(reconstructedModel, equals(originalModel));
      });
    });

    group('Equality and hash code', () {
      test('should be equal when all properties are same', () {
        // arrange
        const model1 = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );
        const model2 = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          avatar: 'avatar.jpg',
          isActive: true,
        );

        // assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // arrange
        const model1 = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
        );
        const model2 = UserModel(
          id: '2',
          name: 'John Doe',
          email: 'john@example.com',
        );

        // assert
        expect(model1, isNot(equals(model2)));
        expect(model1.hashCode, isNot(equals(model2.hashCode)));
      });
    });

    group('CopyWith functionality', () {
      test('should create copy with updated fields', () {
        // arrange
        const userModel = UserModel(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          isActive: false,
        );

        // act
        final updatedModel = userModel.copyWith(
          name: 'Jane Doe',
          isActive: true,
          avatar: 'new-avatar.jpg',
        );

        // assert
        expect(updatedModel.id, '1'); // unchanged
        expect(updatedModel.name, 'Jane Doe'); // updated
        expect(updatedModel.email, 'john@example.com'); // unchanged
        expect(updatedModel.avatar, 'new-avatar.jpg'); // updated
        expect(updatedModel.isActive, true); // updated
      });
    });
  });
}
