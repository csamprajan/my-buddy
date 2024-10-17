// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_iota_response_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetIotaResponseOutputImpl _$$GetIotaResponseOutputImplFromJson(
        Map<String, dynamic> json) =>
    _$GetIotaResponseOutputImpl(
      vp: json['vp'] as String?,
      nounce: json['nounce'] as String?,
      jwt: json['jwt'] as String?,
    );

Map<String, dynamic> _$$GetIotaResponseOutputImplToJson(
    _$GetIotaResponseOutputImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('vp', instance.vp);
  writeNotNull('nounce', instance.nounce);
  writeNotNull('jwt', instance.jwt);
  return val;
}
