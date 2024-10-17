import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_iota_response_output.freezed.dart';
part 'get_iota_response_output.g.dart';

@freezed
sealed class GetIotaResponseOutput with _$GetIotaResponseOutput {
  const GetIotaResponseOutput._();
  @JsonSerializable(includeIfNull: false)
  const factory GetIotaResponseOutput({
    String? vp,
    String? nounce,
    String? jwt,
  }) = _GetIotaResponseOutput;

  factory GetIotaResponseOutput.fromJson(Map<String, Object?> json) =>
      _$GetIotaResponseOutputFromJson(json);
}
