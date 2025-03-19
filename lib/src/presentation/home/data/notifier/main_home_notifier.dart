import 'dart:convert';
import 'dart:io';

import 'package:fvm/fvm.dart';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/src/core/constants/storages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../model/downloaded_flutter_sdks.dart';
import '../model/flutter_versions.dart';
import 'main_home_state.dart';

final mainHomeProvider =
    StateNotifierProvider<MainHomeNotifier, MainHomeState>((ref) {
  return MainHomeNotifier();
});

class MainHomeNotifier extends StateNotifier<MainHomeState> {
  MainHomeNotifier() : super(MainHomeState.initial()) {
    initializeHome();
  }

  final TextEditingController projectPathController = TextEditingController();

  // Initialize the home page by checking FVM installation and fetching versions
  Future<void> initializeHome() async {
    await gettingSavedCurrentProjectPath();

    final isDartInstalled = await checkDartInstallation();
    if (isDartInstalled) {
      bool fvmIsNotActivated = await checkFvmInstallation();
      if (fvmIsNotActivated) {
        await installFvm();
      }
      await fetchOnlineFlutterVersions();
      await fetchDownloadedFlutterVersions();
    }
  }

  /// Reinitialize the after changing the project path
  Future<void> reInitialize() async {
    final isDartInstalled = await checkDartInstallation();
    if (isDartInstalled) {
      // bool fvmIsNotActivated = await checkFvmInstallation();
      if (true) {
        await installFvm();
      }
      await fetchOnlineFlutterVersions();
      await fetchDownloadedFlutterVersions();
    }
  }

  /// Check if FVM is installed and update the state
  Future<bool> checkFvmInstallation() async {
    state =
        state.copyWith(isDashboardScreenLoading: true); // Update loading state
    try {
      ProcessResult result = await Process.run('fvm', ['--version'],
          runInShell: true, workingDirectory: projectPathController.text);
      state = state.copyWith(isDashboardScreenLoading: false);
      if (result.exitCode == 0) {
        return true; // FVM is installed
      } else {
        return false;
      }
    } catch (e) {
      DebugLog.error(e.toString());
      state = state.copyWith(
          isDashboardScreenLoading: false); // Set loading state to false
      return false;
    }
  }

  // Check if Dart is installed
  Future<bool> checkDartInstallation() async {
    state = state.copyWith(
        isDashboardScreenLoading: true,
        isCheckingDartInstallation: true); // Update loading state
    try {
      ProcessResult result = await Process.run('dart', ['--version'],
          runInShell: true, workingDirectory: projectPathController.text);
      if (result.exitCode == 0) {
        state = state.copyWith(
            isDartInstalled: true,
            isCheckingDartInstallation: false,
            isDashboardScreenLoading: false); // Set loading state to false
        return true; // Dart is installed
      } else {
        state = state.copyWith(
            isDartInstalled: false,
            isCheckingDartInstallation: false,
            isDashboardScreenLoading: false); // Set loading state to false
        return false;
      }
    } catch (e) {
      DebugLog.error('Error checking Dart Installation: ${e.toString()}');
      state = state.copyWith(
          isDartInstalled: false,
          isCheckingDartInstallation: false,
          isDashboardScreenLoading: false); // Set loading state to false
      return false;
    }
  }

  // Reload the Flutter SDKs screen
  Future<void> reloadFlutterSdksScreen() async {
    await fetchOnlineFlutterVersions();
    await fetchDownloadedFlutterVersions();
  }

  // Fetch online Flutter SDK versions
  Future<void> fetchOnlineFlutterVersions({bool forceRefresh = false}) async {
    state = state.copyWith(
        isFetchingVersions: true,
        isDashboardScreenLoading: true,
        isFlutterSdksScreenLoading: true);

    try {
      // Fetch new data
      DebugLog.info('Fetching new data...');
      APIService.fromContext.getReleases().then((value) {
        final prefs = SharedPreferences.getInstance();
        final jsonData = json.encode(value.toJson());
        prefs.then((prefs) {
          prefs.setString(StorageKeys.flutterVersionsCache, jsonData);
          prefs.setInt(StorageKeys.lastFetchTimestamp,
              DateTime.now().millisecondsSinceEpoch);
        });
        final versions =
            value.versions.map((FlutterSdkRelease flutterSdkRelease) {
          return OnlineFlutterSDK(
            hash: flutterSdkRelease.hash,
            channel: flutterSdkRelease.channel.name,
            version: flutterSdkRelease.version,
            releaseDate: flutterSdkRelease.releaseDate.toIso8601String(),
            sha256: flutterSdkRelease.sha256,
            dartSdkArch: flutterSdkRelease.dartSdkArch,
            dartSdkVersion: flutterSdkRelease.dartSdkVersion,
            channelName: flutterSdkRelease.channelName,
            archiveUrl: flutterSdkRelease.archiveUrl,
          );
        }).toList();
        OnlineFlutterSDKVersions onlineFlutterSDKVersions =
            OnlineFlutterSDKVersions(versions: versions);

        state = state.copyWith(
            onlineFlutterVersions: onlineFlutterSDKVersions.versions,
            selectedOnlineVersion: onlineFlutterSDKVersions.versions.isNotEmpty
                ? onlineFlutterSDKVersions.versions.first.version
                : '',
            isFetchingVersions: false,
            isDashboardScreenLoading: false,
            isFlutterSdksScreenLoading: false);
      });
      //}
    } catch (e) {
      DebugLog.error("Error fetching Flutter versions: $e");
      state = state.copyWith(
          isFetchingVersions: false,
          isDashboardScreenLoading: false,
          isFlutterSdksScreenLoading: false);
    }
  }

  // Download the selected Flutter version
  Future<void> downloadFlutterVersion() async {
    if (state.selectedOnlineVersion.isEmpty) return;
    state = state.copyWith(isDownloading: true); // Update loading state
    try {
      Process process = await Process.start(
          'fvm', ['install', state.selectedOnlineVersion],
          runInShell: true, workingDirectory: projectPathController.text);
      process.stdout.transform(utf8.decoder).listen((data) {
        List<Widget> newList =
            List.from(state.commandOutput); // Make a copy of the list
        newList.insert(0, Text(data)); // Modify the list
        state = state.copyWith(
            commandOutput: newList); // Update state with the new list
      });
      process.exitCode.then((exitCode) async {
        await fetchDownloadedFlutterVersions();
        state =
            state.copyWith(isDownloading: false); // Set loading state to false
      });
    } catch (e) {
      DebugLog.error("Error: $e");
      state =
          state.copyWith(isDownloading: false); // Set loading state to false
    }
  }

  // Download the selected Flutter version
  Future<void> downloadFlutterVersionByName(String version,
      {int downloadButtonIndex = -1}) async {
    state = state.copyWith(
        isDownloading: true,
        downloadButtonIndex: downloadButtonIndex); // Update loading state
    try {
      Process process = await Process.start('fvm', ['install', version],
          runInShell: true, workingDirectory: projectPathController.text);
      process.stdout.transform(utf8.decoder).listen((data) {
        List<Widget> newList =
            List.from(state.commandOutput); // Make a copy of the list
        newList.insert(0, Text(data)); // Modify the list
        state = state.copyWith(
            commandOutput: newList); // Update state with the new list
      });
      process.exitCode.then((exitCode) {
        state = state.copyWith(
          isDownloading: false,
        ); // Set loading state to false
        // Trigger a refresh of the Flutter SDKs screen
        reloadFlutterSdksScreen();
      });
    } catch (e) {
      DebugLog.error("Error: $e");
      state =
          state.copyWith(isDownloading: false); // Set loading state to false
    }
  }

  // Fetch the downloaded Flutter versions
  Future<void> fetchDownloadedFlutterVersions() async {
    state = state.copyWith(
        isFetchingDownloaded: true,
        isDashboardScreenLoading: true,
        isFlutterSdksScreenLoading: true); // Update loading state
    try {
      ProcessResult result = await Process.run('fvm', ['api', 'list'],
          runInShell: true, workingDirectory: projectPathController.text);
      String jsonString = result.stdout.toString();
      // jsonString = jsonString.substring(
      //     jsonString.indexOf("["), jsonString.lastIndexOf("]") + 1);
      final data = json.decode(jsonString);
      final cacheSize = DownloadedFlutterSDKs.fromJson(data).size;
      DebugLog.info("Cache size: $cacheSize");
      List<DownloadedFlutterSDK> downloadedFlutterSDKs =
          DownloadedFlutterSDKs.fromJson(data).sdks;
      // Showing if the downloadedFlutterSDKs is not empty
      List<String> versions =
          downloadedFlutterSDKs.map((sdk) => sdk.name).toList();
      DebugLog.info(versions.toString());

      state = state.copyWith(
          cacheSize: cacheSize,
          downloadedFlutterSDKs: downloadedFlutterSDKs,
          isFetchingDownloaded: false, // Set loading state to false
          isDashboardScreenLoading: false,
          isFlutterSdksScreenLoading: false);
    } catch (e) {
      DebugLog.error("Error fetching Flutter versions: $e");
      state = state.copyWith(
          isFetchingDownloaded: false,
          isDashboardScreenLoading: false,
          isFlutterSdksScreenLoading: false); // Set loading state to false
    }
  }

  // Switch the Flutter version for the project
  Future<void> switchFlutterVersion(String projectPath) async {
    if (state.selectedVersion.isEmpty) return;
    state = state.copyWith(
        isSwitching: true,
        currentFlutterVersionSwitchedTo: ''); // Update loading state
    try {
      Process process = await Process.start(
          'cmd', ['/c', 'echo y | fvm use ${state.selectedVersion}'],
          workingDirectory: projectPath, runInShell: true);
      process.stdout.transform(utf8.decoder).listen((data) {
        List<Widget> newList =
            List.from(state.commandOutput); // Make a copy of the list
        newList.insert(0, Text(data)); // Modify the list
        state = state.copyWith(
            commandOutput: newList); // Update state with the new list
      });
      process.exitCode.then((exitCode) {
        state = state.copyWith(
            isSwitching: false,
            currentFlutterVersionSwitchedTo:
                state.selectedVersion); // Set loading state to false
      });
      // Fetching available devices after switching successfully
      if (state.downloadedFlutterSDKs.isNotEmpty) {
        final isSetup = state.downloadedFlutterSDKs
            .any((element) => element.isSetup == true);
        if (isSetup) {
          await gettingFlutterPlatform();
        }
      }
    } catch (e) {
      DebugLog.error("Error: $e");
      state = state.copyWith(isSwitching: false); // Set loading state to false
    }
  }

  // Install FVM if not already installed
  Future<void> installFvm() async {
    state = state.copyWith(
        isInstallingFvm: true,
        isDashboardScreenLoading: true); // Update loading state
    try {
      ProcessResult result = await Process.run(
        'dart',
        ['pub', 'global', 'activate', 'fvm'],
        workingDirectory: projectPathController.text,
        runInShell: true,
      );
      if (result.exitCode == 0) {
        DebugLog.info("FVM installed successfully!");
        state = state.copyWith(
            isInstallingFvm: false,
            isDashboardScreenLoading: false); // Set loading state to false
      }
    } catch (e) {
      DebugLog.error("Exception installing FVM: $e");
      state = state.copyWith(
          isInstallingFvm: false,
          isDashboardScreenLoading: false); // Set loading state to false
    }
  }

  // Select the online Flutter version
  void selectOnlineVersion(String version) {
    if (state.onlineFlutterVersions
        .map((flutterSDK) => flutterSDK.version)
        .toList()
        .contains(version)) {
      state = state.copyWith(selectedOnlineVersion: version);
    }
  }

  // Select the downloaded Flutter version
  void selectDownloadedVersion(String version) {
    state = state.copyWith(selectedVersion: version);
  }

  // Open file picker to select project directory
  Future<void> selectProjectPath() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      projectPathController.text = selectedDirectory;
      // Save the current project path to shared preferences
      Properties.instance.saveSettings(Properties.instance.settings
          .copyWith(currentTargetProjectPath: selectedDirectory));
      state = state.copyWith(projectPath: selectedDirectory);
      await reInitialize();
      // await gettingFlutterPlatform();
    }
  }

  // Delete the current project path
  Future<void> deleteCurrentProjectPath() async {
    projectPathController.clear();
    Properties.instance.saveSettings(
        Properties.instance.settings.copyWith(currentTargetProjectPath: ''));
    state = state.copyWith(projectPath: '');
    await reInitialize();
    // await gettingFlutterPlatform();
  }

  Future<void> gettingSavedCurrentProjectPath() async {
    final currentTargetProjectPath =
        Properties.instance.settings.currentTargetProjectPath;
    if (currentTargetProjectPath.isNotEmpty) {
      projectPathController.text = currentTargetProjectPath;
      state = state.copyWith(
        projectPath: currentTargetProjectPath,
      );
      // if (state.downloadedFlutterSDKs.isNotEmpty) {
      //   final isSetup = state.downloadedFlutterSDKs
      //       .any((element) => element.isSetup == true);
      //   if (isSetup) {
      //     await gettingFlutterPlatform();
      //   }
      // }
    }
  }

  Future<void> gettingFlutterPlatform() async {
    state = state.copyWith(isGettingAvailableDevices: true);
    List<String> availablePlatforms = await fetchFlutterPlatforms();
    state = state.copyWith(
        availablePlatforms: availablePlatforms,
        isGettingAvailableDevices: false);
  }

  Future<void> refreshAvailableDevices() async {
    state = state.copyWith(isGettingAvailableDevices: true);
    List<String> availablePlatforms = await fetchFlutterPlatforms();
    state = state.copyWith(
        availablePlatforms: availablePlatforms,
        isGettingAvailableDevices: false);
  }

  void selectPlatform(String platform) {
    state = state.copyWith(selectedPlatform: platform);
  }

  Process? flutterProcess;

  Future<void> runFlutterProject() async {
    if (state.projectPath.isEmpty) return;
    state = state.copyWith(isRunning: true);
    try {
      flutterProcess = await Process.start(
          'fvm', ['flutter', 'run', '-d', state.selectedPlatform],
          workingDirectory: state.projectPath, runInShell: true);
      DebugLog.info('Run project in :${state.projectPath}');
      flutterProcess!.stdout.transform(utf8.decoder).listen((data) {
        List<Widget> newList = List.from(state.commandOutput);
        newList.insert(0, Text(data));
        state = state.copyWith(commandOutput: newList);
      });

      flutterProcess!.exitCode.then((exitCode) {
        state = state.copyWith(isRunning: false);
      });
    } catch (e) {
      DebugLog.error("Error running Flutter project: $e");
      state = state.copyWith(isRunning: false);
    }
  }

  // Future<void> stopFlutterProject() async {
  //   if (flutterProcess == null) return;
  //
  //   state = state.copyWith(isRunning: false);
  //   try {
  //     flutterProcess!.kill();
  //     flutterProcess = null;
  //   } catch (e) {
  //     DebugLog.error("Error stopping Flutter project: $e");
  //   }
  // }

  Future<void> stopFlutterProject() async {
    if (flutterProcess == null) return;

    try {
      // Try to gracefully exit Flutter process
      flutterProcess!.stdin.writeln('q');
      await Future.delayed(
          const Duration(seconds: 2)); // Give time for graceful shutdown
      if (flutterProcess != null && flutterProcess!.kill()) {
        DebugLog.info("Flutter process killed successfully.");
      }
      flutterProcess = null;
      state = state.copyWith(isRunning: false);
    } catch (e) {
      DebugLog.error("Error stopping Flutter project: $e");
    }
  }

  Future<void> hotReloadFlutterProject() async {
    if (flutterProcess == null) return;

    state = state.copyWith(isHotReloading: true);
    try {
      flutterProcess!.stdin.writeln('r'); // Sends 'r' to trigger hot reload
      state = state.copyWith(isHotReloading: false);
    } catch (e) {
      DebugLog.error("Error triggering hot reload: $e");
      state = state.copyWith(isHotReloading: false);
    }
  }

  Future<List<String>> fetchFlutterPlatforms() async {
    try {
      // Run the flutter devices command
      DebugLog.info('Getting available devices...');
      ProcessResult result = await Process.run('fvm', ['flutter', 'devices'],
          workingDirectory: state.projectPath, runInShell: true);
      if (result.exitCode == 0) {
        String output = result.stdout.toString();
        List<String> platforms = [];

        // Split the output into lines
        List<String> lines = output.split('\n');

        // Loop through the lines and extract the platform names
        for (var line in lines) {
          // Look for lines that start with the platform name (Windows, Chrome, etc.)
          if (line.contains('(')) {
            // Example: "Windows (desktop) • windows • windows-x64    • Microsoft Windows"
            // Extract the platform name before the first '('
            var platformName = line.split('(').first.trim();

            // Add the platform to the list
            platforms.add(platformName);
          }
        }
        DebugLog.info('Available devices: $platforms');

        return platforms;
      }
    } catch (e) {
      DebugLog.error("Error fetching available devices: $e");
    }
    DebugLog.info('Available devices is EMPTY');
    return [];
  }
}
