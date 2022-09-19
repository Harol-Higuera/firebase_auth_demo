// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'email_link_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EmailLinkState {
  String get description => throw _privateConstructorUsedError;
  String get entryEmailAddress => throw _privateConstructorUsedError;
  bool get isUserLoggedIn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailLinkStateCopyWith<EmailLinkState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailLinkStateCopyWith<$Res> {
  factory $EmailLinkStateCopyWith(
          EmailLinkState value, $Res Function(EmailLinkState) then) =
      _$EmailLinkStateCopyWithImpl<$Res>;
  $Res call(
      {String description, String entryEmailAddress, bool isUserLoggedIn});
}

/// @nodoc
class _$EmailLinkStateCopyWithImpl<$Res>
    implements $EmailLinkStateCopyWith<$Res> {
  _$EmailLinkStateCopyWithImpl(this._value, this._then);

  final EmailLinkState _value;
  // ignore: unused_field
  final $Res Function(EmailLinkState) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? entryEmailAddress = freezed,
    Object? isUserLoggedIn = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      entryEmailAddress: entryEmailAddress == freezed
          ? _value.entryEmailAddress
          : entryEmailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isUserLoggedIn: isUserLoggedIn == freezed
          ? _value.isUserLoggedIn
          : isUserLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_EmailLinkStateCopyWith<$Res>
    implements $EmailLinkStateCopyWith<$Res> {
  factory _$$_EmailLinkStateCopyWith(
          _$_EmailLinkState value, $Res Function(_$_EmailLinkState) then) =
      __$$_EmailLinkStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String description, String entryEmailAddress, bool isUserLoggedIn});
}

/// @nodoc
class __$$_EmailLinkStateCopyWithImpl<$Res>
    extends _$EmailLinkStateCopyWithImpl<$Res>
    implements _$$_EmailLinkStateCopyWith<$Res> {
  __$$_EmailLinkStateCopyWithImpl(
      _$_EmailLinkState _value, $Res Function(_$_EmailLinkState) _then)
      : super(_value, (v) => _then(v as _$_EmailLinkState));

  @override
  _$_EmailLinkState get _value => super._value as _$_EmailLinkState;

  @override
  $Res call({
    Object? description = freezed,
    Object? entryEmailAddress = freezed,
    Object? isUserLoggedIn = freezed,
  }) {
    return _then(_$_EmailLinkState(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      entryEmailAddress: entryEmailAddress == freezed
          ? _value.entryEmailAddress
          : entryEmailAddress // ignore: cast_nullable_to_non_nullable
              as String,
      isUserLoggedIn: isUserLoggedIn == freezed
          ? _value.isUserLoggedIn
          : isUserLoggedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_EmailLinkState implements _EmailLinkState {
  _$_EmailLinkState(
      {this.description = '',
      this.entryEmailAddress = '',
      this.isUserLoggedIn = false});

  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String entryEmailAddress;
  @override
  @JsonKey()
  final bool isUserLoggedIn;

  @override
  String toString() {
    return 'EmailLinkState(description: $description, entryEmailAddress: $entryEmailAddress, isUserLoggedIn: $isUserLoggedIn)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmailLinkState &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.entryEmailAddress, entryEmailAddress) &&
            const DeepCollectionEquality()
                .equals(other.isUserLoggedIn, isUserLoggedIn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(entryEmailAddress),
      const DeepCollectionEquality().hash(isUserLoggedIn));

  @JsonKey(ignore: true)
  @override
  _$$_EmailLinkStateCopyWith<_$_EmailLinkState> get copyWith =>
      __$$_EmailLinkStateCopyWithImpl<_$_EmailLinkState>(this, _$identity);
}

abstract class _EmailLinkState implements EmailLinkState {
  factory _EmailLinkState(
      {final String description,
      final String entryEmailAddress,
      final bool isUserLoggedIn}) = _$_EmailLinkState;

  @override
  String get description;
  @override
  String get entryEmailAddress;
  @override
  bool get isUserLoggedIn;
  @override
  @JsonKey(ignore: true)
  _$$_EmailLinkStateCopyWith<_$_EmailLinkState> get copyWith =>
      throw _privateConstructorUsedError;
}
