import 'package:freezed_annotation/freezed_annotation.dart';

part 'downloaded_flutter_sdks.freezed.dart';
part 'downloaded_flutter_sdks.g.dart';

@freezed
class DownloadedFlutterSDK with _$DownloadedFlutterSDK {
  const factory DownloadedFlutterSDK({
    required String name,
    required String directory,
    String? releaseFromChannel,
    required String type,
    required String binPath,
    required bool hasOldBinPath,
    required String dartBinPath,
    required String dartExec,
    required String flutterExec,
    String? flutterSdkVersion,
    String? dartSdkVersion,
    required bool isSetup,
  }) = _DownloadedFlutterSDK;

  factory DownloadedFlutterSDK.fromJson(Map<String, dynamic> json) =>
      _$DownloadedFlutterSDKFromJson(json);
}

@freezed
class DownloadedFlutterSDKs with _$DownloadedFlutterSDKs {
  const factory DownloadedFlutterSDKs({
    required String size,
    required List<DownloadedFlutterSDK> sdks,
  }) = _DownloadedFlutterSDKs;

  factory DownloadedFlutterSDKs.fromJson(Map<String, dynamic> json) =>
      DownloadedFlutterSDKs(
        size: json['size'] as String,
        sdks: (json['versions'] as List<dynamic>)
            .map((json) => DownloadedFlutterSDK.fromJson(json))
            .toList(),
      );
}
