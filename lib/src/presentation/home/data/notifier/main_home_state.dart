import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_home_state.freezed.dart';

@freezed
class MainHomeState with _$MainHomeState {
  const factory MainHomeState({
    required String fvmVersion,
    required List<String> availableVersions,
    required String selectedOnlineVersion,
    required List<String> downloadedFlutterVersions,
    required String selectedVersion,
    required List<Widget> commandOutput,
    required bool isCheckingFvm,
    required bool isInstallingFvm,
    required bool isFetchingVersions,
    required bool isDownloading,
    required bool isFetchingDownloaded,
    required bool isSwitching,
    required bool isGettingAvailableDevices,
    required String projectPath,
    required String selectedPlatform,
    required List<String> availablePlatforms,
    required bool isRunning,
    required bool isHotReloading,
    required double cacheSize,
  }) = _MainHomeState;

  factory MainHomeState.initial() => const MainHomeState(
        fvmVersion: '',
        availableVersions: [],
        selectedOnlineVersion: '',
        downloadedFlutterVersions: [],
        selectedVersion: '',
        commandOutput: [],
        isCheckingFvm: false,
        isInstallingFvm: false,
        isFetchingVersions: false,
        isDownloading: false,
        isFetchingDownloaded: false,
        isSwitching: false,
        isGettingAvailableDevices: false,
        projectPath: '',
        isRunning: false,
        isHotReloading: false,
        selectedPlatform: '',
        availablePlatforms: [],
        cacheSize: 0,
      );
}
