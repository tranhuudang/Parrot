// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_versions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnlineFlutterSDKVersionsImpl _$$OnlineFlutterSDKVersionsImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlineFlutterSDKVersionsImpl(
      versions: (json['versions'] as List<dynamic>)
          .map((e) => OnlineFlutterSDK.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OnlineFlutterSDKVersionsImplToJson(
        _$OnlineFlutterSDKVersionsImpl instance) =>
    <String, dynamic>{
      'versions': instance.versions,
    };
