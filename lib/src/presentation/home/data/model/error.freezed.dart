// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MainHomeStateError {
  String get message => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Create a copy of MainHomeStateError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MainHomeStateErrorCopyWith<MainHomeStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainHomeStateErrorCopyWith<$Res> {
  factory $MainHomeStateErrorCopyWith(
          MainHomeStateError value, $Res Function(MainHomeStateError) then) =
      _$MainHomeStateErrorCopyWithImpl<$Res, MainHomeStateError>;
  @useResult
  $Res call({String message, String title});
}

/// @nodoc
class _$MainHomeStateErrorCopyWithImpl<$Res, $Val extends MainHomeStateError>
    implements $MainHomeStateErrorCopyWith<$Res> {
  _$MainHomeStateErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MainHomeStateError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainHomeStateErrorImplCopyWith<$Res>
    implements $MainHomeStateErrorCopyWith<$Res> {
  factory _$$MainHomeStateErrorImplCopyWith(_$MainHomeStateErrorImpl value,
          $Res Function(_$MainHomeStateErrorImpl) then) =
      __$$MainHomeStateErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String title});
}

/// @nodoc
class __$$MainHomeStateErrorImplCopyWithImpl<$Res>
    extends _$MainHomeStateErrorCopyWithImpl<$Res, _$MainHomeStateErrorImpl>
    implements _$$MainHomeStateErrorImplCopyWith<$Res> {
  __$$MainHomeStateErrorImplCopyWithImpl(_$MainHomeStateErrorImpl _value,
      $Res Function(_$MainHomeStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of MainHomeStateError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? title = null,
  }) {
    return _then(_$MainHomeStateErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MainHomeStateErrorImpl implements _MainHomeStateError {
  const _$MainHomeStateErrorImpl({required this.message, required this.title});

  @override
  final String message;
  @override
  final String title;

  @override
  String toString() {
    return 'MainHomeStateError(message: $message, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainHomeStateErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, title);

  /// Create a copy of MainHomeStateError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MainHomeStateErrorImplCopyWith<_$MainHomeStateErrorImpl> get copyWith =>
      __$$MainHomeStateErrorImplCopyWithImpl<_$MainHomeStateErrorImpl>(
          this, _$identity);
}

abstract class _MainHomeStateError implements MainHomeStateError {
  const factory _MainHomeStateError(
      {required final String message,
      required final String title}) = _$MainHomeStateErrorImpl;

  @override
  String get message;
  @override
  String get title;

  /// Create a copy of MainHomeStateError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MainHomeStateErrorImplCopyWith<_$MainHomeStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
