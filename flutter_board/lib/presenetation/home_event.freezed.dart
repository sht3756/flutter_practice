// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HomeEventTearOff {
  const _$HomeEventTearOff();

  Query<T> query<T>() {
    return Query<T>();
  }

  Insert<T> insert<T>(String content) {
    return Insert<T>(
      content,
    );
  }

  Update<T> update<T>(int id, String content) {
    return Update<T>(
      id,
      content,
    );
  }

  Delete<T> delete<T>(int id) {
    return Delete<T>(
      id,
    );
  }
}

/// @nodoc
const $HomeEvent = _$HomeEventTearOff();

/// @nodoc
mixin _$HomeEvent<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() query,
    required TResult Function(String content) insert,
    required TResult Function(int id, String content) update,
    required TResult Function(int id) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Query<T> value) query,
    required TResult Function(Insert<T> value) insert,
    required TResult Function(Update<T> value) update,
    required TResult Function(Delete<T> value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeEventCopyWith<T, $Res> {
  factory $HomeEventCopyWith(
          HomeEvent<T> value, $Res Function(HomeEvent<T>) then) =
      _$HomeEventCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$HomeEventCopyWithImpl<T, $Res> implements $HomeEventCopyWith<T, $Res> {
  _$HomeEventCopyWithImpl(this._value, this._then);

  final HomeEvent<T> _value;
  // ignore: unused_field
  final $Res Function(HomeEvent<T>) _then;
}

/// @nodoc
abstract class $QueryCopyWith<T, $Res> {
  factory $QueryCopyWith(Query<T> value, $Res Function(Query<T>) then) =
      _$QueryCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$QueryCopyWithImpl<T, $Res> extends _$HomeEventCopyWithImpl<T, $Res>
    implements $QueryCopyWith<T, $Res> {
  _$QueryCopyWithImpl(Query<T> _value, $Res Function(Query<T>) _then)
      : super(_value, (v) => _then(v as Query<T>));

  @override
  Query<T> get _value => super._value as Query<T>;
}

/// @nodoc

class _$Query<T> implements Query<T> {
  const _$Query();

  @override
  String toString() {
    return 'HomeEvent<$T>.query()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Query<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() query,
    required TResult Function(String content) insert,
    required TResult Function(int id, String content) update,
    required TResult Function(int id) delete,
  }) {
    return query();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
  }) {
    return query?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
    required TResult orElse(),
  }) {
    if (query != null) {
      return query();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Query<T> value) query,
    required TResult Function(Insert<T> value) insert,
    required TResult Function(Update<T> value) update,
    required TResult Function(Delete<T> value) delete,
  }) {
    return query(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
  }) {
    return query?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
    required TResult orElse(),
  }) {
    if (query != null) {
      return query(this);
    }
    return orElse();
  }
}

abstract class Query<T> implements HomeEvent<T> {
  const factory Query() = _$Query<T>;
}

/// @nodoc
abstract class $InsertCopyWith<T, $Res> {
  factory $InsertCopyWith(Insert<T> value, $Res Function(Insert<T>) then) =
      _$InsertCopyWithImpl<T, $Res>;
  $Res call({String content});
}

/// @nodoc
class _$InsertCopyWithImpl<T, $Res> extends _$HomeEventCopyWithImpl<T, $Res>
    implements $InsertCopyWith<T, $Res> {
  _$InsertCopyWithImpl(Insert<T> _value, $Res Function(Insert<T>) _then)
      : super(_value, (v) => _then(v as Insert<T>));

  @override
  Insert<T> get _value => super._value as Insert<T>;

  @override
  $Res call({
    Object? content = freezed,
  }) {
    return _then(Insert<T>(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Insert<T> implements Insert<T> {
  const _$Insert(this.content);

  @override
  final String content;

  @override
  String toString() {
    return 'HomeEvent<$T>.insert(content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Insert<T> &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(content));

  @JsonKey(ignore: true)
  @override
  $InsertCopyWith<T, Insert<T>> get copyWith =>
      _$InsertCopyWithImpl<T, Insert<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() query,
    required TResult Function(String content) insert,
    required TResult Function(int id, String content) update,
    required TResult Function(int id) delete,
  }) {
    return insert(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
  }) {
    return insert?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
    required TResult orElse(),
  }) {
    if (insert != null) {
      return insert(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Query<T> value) query,
    required TResult Function(Insert<T> value) insert,
    required TResult Function(Update<T> value) update,
    required TResult Function(Delete<T> value) delete,
  }) {
    return insert(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
  }) {
    return insert?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
    required TResult orElse(),
  }) {
    if (insert != null) {
      return insert(this);
    }
    return orElse();
  }
}

abstract class Insert<T> implements HomeEvent<T> {
  const factory Insert(String content) = _$Insert<T>;

  String get content;
  @JsonKey(ignore: true)
  $InsertCopyWith<T, Insert<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateCopyWith<T, $Res> {
  factory $UpdateCopyWith(Update<T> value, $Res Function(Update<T>) then) =
      _$UpdateCopyWithImpl<T, $Res>;
  $Res call({int id, String content});
}

/// @nodoc
class _$UpdateCopyWithImpl<T, $Res> extends _$HomeEventCopyWithImpl<T, $Res>
    implements $UpdateCopyWith<T, $Res> {
  _$UpdateCopyWithImpl(Update<T> _value, $Res Function(Update<T>) _then)
      : super(_value, (v) => _then(v as Update<T>));

  @override
  Update<T> get _value => super._value as Update<T>;

  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
  }) {
    return _then(Update<T>(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Update<T> implements Update<T> {
  const _$Update(this.id, this.content);

  @override
  final int id;
  @override
  final String content;

  @override
  String toString() {
    return 'HomeEvent<$T>.update(id: $id, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Update<T> &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(content));

  @JsonKey(ignore: true)
  @override
  $UpdateCopyWith<T, Update<T>> get copyWith =>
      _$UpdateCopyWithImpl<T, Update<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() query,
    required TResult Function(String content) insert,
    required TResult Function(int id, String content) update,
    required TResult Function(int id) delete,
  }) {
    return update(id, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
  }) {
    return update?.call(id, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(id, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Query<T> value) query,
    required TResult Function(Insert<T> value) insert,
    required TResult Function(Update<T> value) update,
    required TResult Function(Delete<T> value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class Update<T> implements HomeEvent<T> {
  const factory Update(int id, String content) = _$Update<T>;

  int get id;
  String get content;
  @JsonKey(ignore: true)
  $UpdateCopyWith<T, Update<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteCopyWith<T, $Res> {
  factory $DeleteCopyWith(Delete<T> value, $Res Function(Delete<T>) then) =
      _$DeleteCopyWithImpl<T, $Res>;
  $Res call({int id});
}

/// @nodoc
class _$DeleteCopyWithImpl<T, $Res> extends _$HomeEventCopyWithImpl<T, $Res>
    implements $DeleteCopyWith<T, $Res> {
  _$DeleteCopyWithImpl(Delete<T> _value, $Res Function(Delete<T>) _then)
      : super(_value, (v) => _then(v as Delete<T>));

  @override
  Delete<T> get _value => super._value as Delete<T>;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(Delete<T>(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$Delete<T> implements Delete<T> {
  const _$Delete(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'HomeEvent<$T>.delete(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Delete<T> &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  $DeleteCopyWith<T, Delete<T>> get copyWith =>
      _$DeleteCopyWithImpl<T, Delete<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() query,
    required TResult Function(String content) insert,
    required TResult Function(int id, String content) update,
    required TResult Function(int id) delete,
  }) {
    return delete(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
  }) {
    return delete?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? query,
    TResult Function(String content)? insert,
    TResult Function(int id, String content)? update,
    TResult Function(int id)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Query<T> value) query,
    required TResult Function(Insert<T> value) insert,
    required TResult Function(Update<T> value) update,
    required TResult Function(Delete<T> value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Query<T> value)? query,
    TResult Function(Insert<T> value)? insert,
    TResult Function(Update<T> value)? update,
    TResult Function(Delete<T> value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class Delete<T> implements HomeEvent<T> {
  const factory Delete(int id) = _$Delete<T>;

  int get id;
  @JsonKey(ignore: true)
  $DeleteCopyWith<T, Delete<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
