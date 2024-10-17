// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_iota_response_output.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetIotaResponseOutput _$GetIotaResponseOutputFromJson(
    Map<String, dynamic> json) {
  return _GetIotaResponseOutput.fromJson(json);
}

/// @nodoc
mixin _$GetIotaResponseOutput {
  String? get vp => throw _privateConstructorUsedError;
  String? get nounce => throw _privateConstructorUsedError;
  String? get jwt => throw _privateConstructorUsedError;

  /// Serializes this GetIotaResponseOutput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetIotaResponseOutput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetIotaResponseOutputCopyWith<GetIotaResponseOutput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetIotaResponseOutputCopyWith<$Res> {
  factory $GetIotaResponseOutputCopyWith(GetIotaResponseOutput value,
          $Res Function(GetIotaResponseOutput) then) =
      _$GetIotaResponseOutputCopyWithImpl<$Res, GetIotaResponseOutput>;
  @useResult
  $Res call({String? vp, String? nounce, String? jwt});
}

/// @nodoc
class _$GetIotaResponseOutputCopyWithImpl<$Res,
        $Val extends GetIotaResponseOutput>
    implements $GetIotaResponseOutputCopyWith<$Res> {
  _$GetIotaResponseOutputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetIotaResponseOutput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vp = freezed,
    Object? nounce = freezed,
    Object? jwt = freezed,
  }) {
    return _then(_value.copyWith(
      vp: freezed == vp
          ? _value.vp
          : vp // ignore: cast_nullable_to_non_nullable
              as String?,
      nounce: freezed == nounce
          ? _value.nounce
          : nounce // ignore: cast_nullable_to_non_nullable
              as String?,
      jwt: freezed == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetIotaResponseOutputImplCopyWith<$Res>
    implements $GetIotaResponseOutputCopyWith<$Res> {
  factory _$$GetIotaResponseOutputImplCopyWith(
          _$GetIotaResponseOutputImpl value,
          $Res Function(_$GetIotaResponseOutputImpl) then) =
      __$$GetIotaResponseOutputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? vp, String? nounce, String? jwt});
}

/// @nodoc
class __$$GetIotaResponseOutputImplCopyWithImpl<$Res>
    extends _$GetIotaResponseOutputCopyWithImpl<$Res,
        _$GetIotaResponseOutputImpl>
    implements _$$GetIotaResponseOutputImplCopyWith<$Res> {
  __$$GetIotaResponseOutputImplCopyWithImpl(_$GetIotaResponseOutputImpl _value,
      $Res Function(_$GetIotaResponseOutputImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetIotaResponseOutput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vp = freezed,
    Object? nounce = freezed,
    Object? jwt = freezed,
  }) {
    return _then(_$GetIotaResponseOutputImpl(
      vp: freezed == vp
          ? _value.vp
          : vp // ignore: cast_nullable_to_non_nullable
              as String?,
      nounce: freezed == nounce
          ? _value.nounce
          : nounce // ignore: cast_nullable_to_non_nullable
              as String?,
      jwt: freezed == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$GetIotaResponseOutputImpl extends _GetIotaResponseOutput {
  const _$GetIotaResponseOutputImpl({this.vp, this.nounce, this.jwt})
      : super._();

  factory _$GetIotaResponseOutputImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetIotaResponseOutputImplFromJson(json);

  @override
  final String? vp;
  @override
  final String? nounce;
  @override
  final String? jwt;

  @override
  String toString() {
    return 'GetIotaResponseOutput(vp: $vp, nounce: $nounce, jwt: $jwt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetIotaResponseOutputImpl &&
            (identical(other.vp, vp) || other.vp == vp) &&
            (identical(other.nounce, nounce) || other.nounce == nounce) &&
            (identical(other.jwt, jwt) || other.jwt == jwt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, vp, nounce, jwt);

  /// Create a copy of GetIotaResponseOutput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetIotaResponseOutputImplCopyWith<_$GetIotaResponseOutputImpl>
      get copyWith => __$$GetIotaResponseOutputImplCopyWithImpl<
          _$GetIotaResponseOutputImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetIotaResponseOutputImplToJson(
      this,
    );
  }
}

abstract class _GetIotaResponseOutput extends GetIotaResponseOutput {
  const factory _GetIotaResponseOutput(
      {final String? vp,
      final String? nounce,
      final String? jwt}) = _$GetIotaResponseOutputImpl;
  const _GetIotaResponseOutput._() : super._();

  factory _GetIotaResponseOutput.fromJson(Map<String, dynamic> json) =
      _$GetIotaResponseOutputImpl.fromJson;

  @override
  String? get vp;
  @override
  String? get nounce;
  @override
  String? get jwt;

  /// Create a copy of GetIotaResponseOutput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetIotaResponseOutputImplCopyWith<_$GetIotaResponseOutputImpl>
      get copyWith => throw _privateConstructorUsedError;
}
