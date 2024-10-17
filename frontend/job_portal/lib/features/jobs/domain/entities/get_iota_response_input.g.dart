// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_iota_response_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetIotaResponseInputImpl _$$GetIotaResponseInputImplFromJson(
        Map<String, dynamic> json) =>
    _$GetIotaResponseInputImpl(
      configurationId: json['configurationId'] as String?,
      queryId: json['queryId'] as String?,
      redirectUri: json['redirectUri'] as String?,
      responseCode: json['responseCode'] as String?,
    );

Map<String, dynamic> _$$GetIotaResponseInputImplToJson(
    _$GetIotaResponseInputImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('configurationId', instance.configurationId);
  writeNotNull('queryId', instance.queryId);
  writeNotNull('redirectUri', instance.redirectUri);
  writeNotNull('responseCode', instance.responseCode);
  return val;
}
