import 'package:flutter/material.dart';
import 'package:fvm/fvm.dart';
import 'package:parrot/src/presentation/home/data/model/downloaded_flutter_sdks.dart';
import 'package:parrot/src/presentation/home/data/model/error.dart';
import 'package:parrot/src/presentation/home/data/model/flutter_versions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_home_state.freezed.dart';

@freezed
class MainHomeState with _$MainHomeState {
  const factory MainHomeState({
    required bool isFlutterSdksScreenLoading,
    required bool isDashboardScreenLoading,
    required bool isDartInstalled,
    required List<OnlineFlutterSDK> onlineFlutterVersions,
    required OnlineFlutterSDK? selectedOnlineVersion,
    required List<DownloadedFlutterSDK> downloadedFlutterSDKs,
    required String selectedVersion,
    required List<Widget> commandOutput,
    required bool isCheckingDartInstallation,
    required bool isInstallingFvm,
    required bool isFetchingVersions,
    required bool isDownloading,
    required int downloadButtonIndex,
    required bool isFetchingDownloaded,
    required bool isSwitching,
    required String currentFlutterVersionSwitchedTo,
    required bool isGettingAvailableDevices,
    required Project? currentProject,
    required String selectedPlatform,
    required List<String> availablePlatforms,
    required bool isRunning,
    required bool isHotReloading,
    required String cacheSize,
    required MainHomeStateError? error,
  }) = _MainHomeState;

  factory MainHomeState.initial() => const MainHomeState(
        isFlutterSdksScreenLoading: false,
        isDashboardScreenLoading: false,
        isDartInstalled: true,
        onlineFlutterVersions: [],
        selectedOnlineVersion: null,
        downloadedFlutterSDKs: [],
        selectedVersion: '',
        commandOutput: [],
        isCheckingDartInstallation: false,
        isInstallingFvm: false,
        isFetchingVersions: false,
        isDownloading: false,
        downloadButtonIndex: -1,
        isFetchingDownloaded: false,
        isSwitching: false,
        currentFlutterVersionSwitchedTo: '',
        isGettingAvailableDevices: false,
        currentProject: null,
        isRunning: false,
        isHotReloading: false,
        selectedPlatform: '',
        availablePlatforms: [],
        cacheSize: '',
        error: null,
      );
}
