import 'package:freezed_annotation/freezed_annotation.dart';

part 'flutter_versions.freezed.dart';
part 'flutter_versions.g.dart';

@freezed
class OnlineFlutterSDK with _$OnlineFlutterSDK {
  const factory OnlineFlutterSDK({
    required String hash,
    required String channel,
    required String version,
    required String? releaseDate,
    required String sha256,
    required String? dartSdkArch,
    required String? dartSdkVersion,
    required String channelName,
    required String archiveUrl,
  }) = _OnlineFlutterSDK;

  factory OnlineFlutterSDK.fromJson(Map<String, dynamic> json) {
    return _OnlineFlutterSDK(
      hash: json['hash'] as String,
      channel: json['channel'] as String,
      version: json['version'] as String,
      releaseDate: json['release_date'] as String?,
      sha256: json['sha256'] as String,
      dartSdkArch: json['dart_sdk_arch'] as String?,
      dartSdkVersion: json['dart_sdk_version'] as String?,
      channelName: json['channelName'] as String,
      archiveUrl: json['archiveUrl'] as String,
    );
  }
}

@freezed
class OnlineFlutterSDKVersions with _$OnlineFlutterSDKVersions {
  const factory OnlineFlutterSDKVersions({
    required List<OnlineFlutterSDK> versions,
  }) = _OnlineFlutterSDKVersions;

  factory OnlineFlutterSDKVersions.fromJson(List<dynamic> json) =>
      _OnlineFlutterSDKVersions(
        versions: json.map((e) => OnlineFlutterSDK.fromJson(e)).toList(),
      );
}
