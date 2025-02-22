// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_flutter_sdks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DownloadedFlutterSDKImpl _$$DownloadedFlutterSDKImplFromJson(
        Map<String, dynamic> json) =>
    _$DownloadedFlutterSDKImpl(
      name: json['name'] as String,
      directory: json['directory'] as String,
      releaseFromChannel: json['releaseFromChannel'] as String?,
      type: json['type'] as String,
      binPath: json['binPath'] as String,
      hasOldBinPath: json['hasOldBinPath'] as bool,
      dartBinPath: json['dartBinPath'] as String,
      dartExec: json['dartExec'] as String,
      flutterExec: json['flutterExec'] as String,
      flutterSdkVersion: json['flutterSdkVersion'] as String?,
      dartSdkVersion: json['dartSdkVersion'] as String?,
      isSetup: json['isSetup'] as bool,
    );

Map<String, dynamic> _$$DownloadedFlutterSDKImplToJson(
        _$DownloadedFlutterSDKImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'directory': instance.directory,
      'releaseFromChannel': instance.releaseFromChannel,
      'type': instance.type,
      'binPath': instance.binPath,
      'hasOldBinPath': instance.hasOldBinPath,
      'dartBinPath': instance.dartBinPath,
      'dartExec': instance.dartExec,
      'flutterExec': instance.flutterExec,
      'flutterSdkVersion': instance.flutterSdkVersion,
      'dartSdkVersion': instance.dartSdkVersion,
      'isSetup': instance.isSetup,
    };

_$DownloadedFlutterSDKsImpl _$$DownloadedFlutterSDKsImplFromJson(
        Map<String, dynamic> json) =>
    _$DownloadedFlutterSDKsImpl(
      size: json['size'] as String,
      sdks: (json['sdks'] as List<dynamic>)
          .map((e) => DownloadedFlutterSDK.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DownloadedFlutterSDKsImplToJson(
        _$DownloadedFlutterSDKsImpl instance) =>
    <String, dynamic>{
      'size': instance.size,
      'sdks': instance.sdks,
    };
