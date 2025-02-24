import 'package:freezed_annotation/freezed_annotation.dart';

part 'flutter_versions.freezed.dart';
part 'flutter_versions.g.dart';

// This @Freezed anotation instead of @freezed allow me to custom this class to not generating toJson method
@Freezed(toJson: false)
class OnlineFlutterSDK with _$OnlineFlutterSDK {
  // Private constructor is required when using @Freezed anotation instead of @freezed
  const OnlineFlutterSDK._();
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

  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'channel': channel,
      'version': version,
      'release_date': releaseDate,
      'sha256': sha256,
      'dart_sdk_arch': dartSdkArch,
      'dart_sdk_version': dartSdkVersion,
      'channelName': channelName,
      'archiveUrl': archiveUrl,
    };
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