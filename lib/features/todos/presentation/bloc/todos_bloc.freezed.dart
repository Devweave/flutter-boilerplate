// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todos_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodosEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TodosEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TodosEvent()';
  }
}

/// @nodoc
class $TodosEventCopyWith<$Res> {
  $TodosEventCopyWith(TodosEvent _, $Res Function(TodosEvent) __);
}

/// Adds pattern-matching-related methods to [TodosEvent].
extension TodosEventPatterns on TodosEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TodosLoadRequested value)? loadRequested,
    TResult Function(TodosRefreshRequested value)? refreshRequested,
    TResult Function(TodoToggleCompleted value)? toggleCompleted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TodosLoadRequested() when loadRequested != null:
        return loadRequested(_that);
      case TodosRefreshRequested() when refreshRequested != null:
        return refreshRequested(_that);
      case TodoToggleCompleted() when toggleCompleted != null:
        return toggleCompleted(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TodosLoadRequested value) loadRequested,
    required TResult Function(TodosRefreshRequested value) refreshRequested,
    required TResult Function(TodoToggleCompleted value) toggleCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case TodosLoadRequested():
        return loadRequested(_that);
      case TodosRefreshRequested():
        return refreshRequested(_that);
      case TodoToggleCompleted():
        return toggleCompleted(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TodosLoadRequested value)? loadRequested,
    TResult? Function(TodosRefreshRequested value)? refreshRequested,
    TResult? Function(TodoToggleCompleted value)? toggleCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case TodosLoadRequested() when loadRequested != null:
        return loadRequested(_that);
      case TodosRefreshRequested() when refreshRequested != null:
        return refreshRequested(_that);
      case TodoToggleCompleted() when toggleCompleted != null:
        return toggleCompleted(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(int todoId)? toggleCompleted,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case TodosLoadRequested() when loadRequested != null:
        return loadRequested();
      case TodosRefreshRequested() when refreshRequested != null:
        return refreshRequested();
      case TodoToggleCompleted() when toggleCompleted != null:
        return toggleCompleted(_that.todoId);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(int todoId) toggleCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case TodosLoadRequested():
        return loadRequested();
      case TodosRefreshRequested():
        return refreshRequested();
      case TodoToggleCompleted():
        return toggleCompleted(_that.todoId);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(int todoId)? toggleCompleted,
  }) {
    final _that = this;
    switch (_that) {
      case TodosLoadRequested() when loadRequested != null:
        return loadRequested();
      case TodosRefreshRequested() when refreshRequested != null:
        return refreshRequested();
      case TodoToggleCompleted() when toggleCompleted != null:
        return toggleCompleted(_that.todoId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class TodosLoadRequested implements TodosEvent {
  const TodosLoadRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TodosLoadRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TodosEvent.loadRequested()';
  }
}

/// @nodoc

class TodosRefreshRequested implements TodosEvent {
  const TodosRefreshRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TodosRefreshRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TodosEvent.refreshRequested()';
  }
}

/// @nodoc

class TodoToggleCompleted implements TodosEvent {
  const TodoToggleCompleted(this.todoId);

  final int todoId;

  /// Create a copy of TodosEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoToggleCompletedCopyWith<TodoToggleCompleted> get copyWith =>
      _$TodoToggleCompletedCopyWithImpl<TodoToggleCompleted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodoToggleCompleted &&
            (identical(other.todoId, todoId) || other.todoId == todoId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todoId);

  @override
  String toString() {
    return 'TodosEvent.toggleCompleted(todoId: $todoId)';
  }
}

/// @nodoc
abstract mixin class $TodoToggleCompletedCopyWith<$Res>
    implements $TodosEventCopyWith<$Res> {
  factory $TodoToggleCompletedCopyWith(
          TodoToggleCompleted value, $Res Function(TodoToggleCompleted) _then) =
      _$TodoToggleCompletedCopyWithImpl;
  @useResult
  $Res call({int todoId});
}

/// @nodoc
class _$TodoToggleCompletedCopyWithImpl<$Res>
    implements $TodoToggleCompletedCopyWith<$Res> {
  _$TodoToggleCompletedCopyWithImpl(this._self, this._then);

  final TodoToggleCompleted _self;
  final $Res Function(TodoToggleCompleted) _then;

  /// Create a copy of TodosEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todoId = null,
  }) {
    return _then(TodoToggleCompleted(
      null == todoId
          ? _self.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$TodosState {
  Resource<List<Todo>> get todoResource;

  /// Create a copy of TodosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodosStateCopyWith<TodosState> get copyWith =>
      _$TodosStateCopyWithImpl<TodosState>(this as TodosState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodosState &&
            (identical(other.todoResource, todoResource) ||
                other.todoResource == todoResource));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todoResource);

  @override
  String toString() {
    return 'TodosState(todoResource: $todoResource)';
  }
}

/// @nodoc
abstract mixin class $TodosStateCopyWith<$Res> {
  factory $TodosStateCopyWith(
          TodosState value, $Res Function(TodosState) _then) =
      _$TodosStateCopyWithImpl;
  @useResult
  $Res call({Resource<List<Todo>> todoResource});
}

/// @nodoc
class _$TodosStateCopyWithImpl<$Res> implements $TodosStateCopyWith<$Res> {
  _$TodosStateCopyWithImpl(this._self, this._then);

  final TodosState _self;
  final $Res Function(TodosState) _then;

  /// Create a copy of TodosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todoResource = null,
  }) {
    return _then(_self.copyWith(
      todoResource: null == todoResource
          ? _self.todoResource
          : todoResource // ignore: cast_nullable_to_non_nullable
              as Resource<List<Todo>>,
    ));
  }
}

/// Adds pattern-matching-related methods to [TodosState].
extension TodosStatePatterns on TodosState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TodosState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodosState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TodosState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TodosState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Resource<List<Todo>> todoResource)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodosState() when $default != null:
        return $default(_that.todoResource);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Resource<List<Todo>> todoResource) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosState():
        return $default(_that.todoResource);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Resource<List<Todo>> todoResource)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodosState() when $default != null:
        return $default(_that.todoResource);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TodosState implements TodosState {
  _TodosState({required this.todoResource});

  @override
  final Resource<List<Todo>> todoResource;

  /// Create a copy of TodosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodosStateCopyWith<_TodosState> get copyWith =>
      __$TodosStateCopyWithImpl<_TodosState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodosState &&
            (identical(other.todoResource, todoResource) ||
                other.todoResource == todoResource));
  }

  @override
  int get hashCode => Object.hash(runtimeType, todoResource);

  @override
  String toString() {
    return 'TodosState(todoResource: $todoResource)';
  }
}

/// @nodoc
abstract mixin class _$TodosStateCopyWith<$Res>
    implements $TodosStateCopyWith<$Res> {
  factory _$TodosStateCopyWith(
          _TodosState value, $Res Function(_TodosState) _then) =
      __$TodosStateCopyWithImpl;
  @override
  @useResult
  $Res call({Resource<List<Todo>> todoResource});
}

/// @nodoc
class __$TodosStateCopyWithImpl<$Res> implements _$TodosStateCopyWith<$Res> {
  __$TodosStateCopyWithImpl(this._self, this._then);

  final _TodosState _self;
  final $Res Function(_TodosState) _then;

  /// Create a copy of TodosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todoResource = null,
  }) {
    return _then(_TodosState(
      todoResource: null == todoResource
          ? _self.todoResource
          : todoResource // ignore: cast_nullable_to_non_nullable
              as Resource<List<Todo>>,
    ));
  }
}

// dart format on
