import 'package:flutter/material.dart';
import 'package:flutter_version_manager/src/presentation/home/data/model/downloaded_flutter_sdks.dart';
import 'package:flutter_version_manager/src/presentation/home/data/model/flutter_versions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_home_state.freezed.dart';

@freezed
class MainHomeState with _$MainHomeState {
  const factory MainHomeState({
    required bool isFlutterSdksScreenLoading,
    required bool isDashboardScreenLoading,
    required String fvmVersion,
    required List<OnlineFlutterSDK> onlineFlutterVersions,
    required String selectedOnlineVersion,
    required List<DownloadedFlutterSDK> downloadedFlutterSDKs,
    required String selectedVersion,
    required List<Widget> commandOutput,
    required bool isCheckingFvm,
    required bool isInstallingFvm,
    required bool isFetchingVersions,
    required bool isDownloading,
    required int downloadButtonIndex,
    required bool isFetchingDownloaded,
    required bool isSwitching,
    required bool isGettingAvailableDevices,
    required String projectPath,
    required String selectedPlatform,
    required List<String> availablePlatforms,
    required bool isRunning,
    required bool isHotReloading,
    required String cacheSize,
  }) = _MainHomeState;

  factory MainHomeState.initial() => const MainHomeState(
        isFlutterSdksScreenLoading: false,
        isDashboardScreenLoading: false,
        fvmVersion: '',
        onlineFlutterVersions: [],
        selectedOnlineVersion: '',
        downloadedFlutterSDKs: [],
        selectedVersion: '',
        commandOutput: [],
        isCheckingFvm: false,
        isInstallingFvm: false,
        isFetchingVersions: false,
        isDownloading: false,
        downloadButtonIndex: -1,
        isFetchingDownloaded: false,
        isSwitching: false,
        isGettingAvailableDevices: false,
        projectPath: '',
        isRunning: false,
        isHotReloading: false,
        selectedPlatform: '',
        availablePlatforms: [],
        cacheSize: '',
      );
}
