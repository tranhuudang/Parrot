import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:fvm/fvm.dart';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/src/app/app.dart';
import 'package:parrot/src/app/router/route_configurations_desktop.dart';
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

  // Initialize the home page by checking FVM installation and fetching versions
  Future<void> initializeHome() async {
    state = state.copyWith(isJustOpened: true);
    // Max time to show the splash screen
    Future.delayed(const Duration(seconds: 10), () {
      if (state.isJustOpened == true) {
        state = state.copyWith(isJustOpened: false);
      }
    });

    // Load the current project path
    await gettingSavedCurrentProjectPath();
    // Get list of available flutter sdk online
    await fetchOnlineFlutterVersions();
    // Get downloaded flutter sdk
    await fetchDownloadedFlutterVersions();

    state = state.copyWith(isJustOpened: false);
  }

  /// Reinitialize the after changing the project path
  Future<void> reInitialize() async {
    await fetchOnlineFlutterVersions();
    await fetchDownloadedFlutterVersions();
  }

  /// Check if FVM is installed and update the state
  Future<bool> checkFvmInstallation() async {
    state =
        state.copyWith(isDashboardScreenLoading: true); // Update loading state
    try {
      ProcessResult result = await Process.run('fvm', ['--version'],
          runInShell: true, workingDirectory: state.currentProject!.path);
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
          runInShell: true, workingDirectory: state.currentProject!.path);
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
      await APIService.fromContext.getReleases().then((value) {
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
            selectedOnlineVersion: onlineFlutterSDKVersions.versions.first,
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
    if (state.selectedOnlineVersion == null) return;
    state = state.copyWith(isDownloading: true); // Update loading state
    try {
      final version = FlutterVersion.release(
          state.selectedOnlineVersion!.version,
          releaseFromChannel: state.selectedOnlineVersion!.channelName);
      await FlutterService.fromContext.install(version, useGitCache: true);

      state = state.copyWith(isDownloading: false);
      // Trigger a refresh of the Flutter SDKs screen
      await fetchDownloadedFlutterVersions();
    } catch (e) {
      DebugLog.error("Error: $e");
      state =
          state.copyWith(isDownloading: false); // Set loading state to false
      // Show error message to user
      rootNavigatorKey.currentContext?.showAlertDialogWithoutAction(
        title: 'Error downloading Flutter SDK',
        content:
            'An error occurred while downloading the Flutter SDK. Please try again later.',
      );
    }
  }

  // Download the selected Flutter version
  Future<void> downloadFlutterVersionByName(OnlineFlutterSDK targetVersion,
      {int downloadButtonIndex = -1}) async {
    state = state.copyWith(
        isDownloading: true,
        downloadButtonIndex: downloadButtonIndex); // Update loading state
    try {
      final version = FlutterVersion.release(targetVersion.version,
          releaseFromChannel: targetVersion.channelName);
      await FlutterService.fromContext.install(version, useGitCache: true);
      state = state.copyWith(
        isDownloading: false,
      ); // Set loading state to false
      // Trigger a refresh of the Flutter SDKs screen
      reloadFlutterSdksScreen();
    } catch (e) {
      DebugLog.error("Error: $e");
      state =
          state.copyWith(isDownloading: false); // Set loading state to false
      // Show error message to user
      rootNavigatorKey.currentContext?.showAlertDialogWithoutAction(
        title: 'Error downloading Flutter SDK',
        content:
            'An error occurred while downloading the Flutter SDK. Please try again later.',
      );
    }
  }

  // Fetch the downloaded Flutter versions
  Future<void> fetchDownloadedFlutterVersions() async {
    state = state.copyWith(
        isFetchingDownloaded: true,
        isDashboardScreenLoading: true,
        isFlutterSdksScreenLoading: true); // Update loading state
    try {
      /// Get cached versions
      await APIService.fromContext.getCachedVersions().then((value) {
        final cacheSize = value.size;
        final downloadedFlutterSDKs =
            value.versions.map((CacheFlutterVersion cachedVersion) {
          return DownloadedFlutterSDK(
            name: cachedVersion.name,
            directory: cachedVersion.directory,
            releaseFromChannel: cachedVersion.releaseFromChannel,
            type: cachedVersion.type.name,
            binPath: cachedVersion.binPath,
            hasOldBinPath: cachedVersion.hasOldBinPath,
            dartBinPath: cachedVersion.dartBinPath,
            dartExec: cachedVersion.dartExec,
            flutterExec: cachedVersion.flutterExec,
            flutterSdkVersion: cachedVersion.flutterSdkVersion,
            dartSdkVersion: cachedVersion.dartSdkVersion,
            isSetup: cachedVersion.isSetup,
          );
        }).toList();
        if (state.currentProject != null) {
          final DownloadedFlutterSDK? pinnedVersion =
              downloadedFlutterSDKs.firstWhereOrNull((element) =>
                  element.name == state.currentProject!.pinnedVersion?.name);
          if (pinnedVersion != null) {
            DebugLog.info('Pinned version found: ${pinnedVersion.name}');
            state = state.copyWith(
                selectedVersionToSwitchTo: pinnedVersion,
                currentFlutterVersionSwitchedTo: pinnedVersion);
          }
        }

        state = state.copyWith(
            cacheSize: cacheSize,
            downloadedFlutterSDKs: downloadedFlutterSDKs,
            isFetchingDownloaded: false, // Set loading state to false
            isDashboardScreenLoading: false,
            isFlutterSdksScreenLoading: false);
      });
    } catch (e) {
      DebugLog.error("Error fetching Flutter versions: $e");
      state = state.copyWith(
          isFetchingDownloaded: false,
          isDashboardScreenLoading: false,
          isFlutterSdksScreenLoading: false); // Set loading state to false
    }
  }

  // Switch the Flutter version for the project
  Future<void> switchFlutterVersion() async {
    if (state.selectedVersionToSwitchTo == null) return;

    try {
      if (state.currentProject != null &&
          state.selectedVersionToSwitchTo != null) {
        state = state.copyWith(
            isSwitching: true,
            currentFlutterVersionSwitchedTo: null); // Update loading state
        DebugLog.info('Configuring project...');
        // VS Code modifications
        ProjectService.fromContext.update(state.currentProject!,
            flutterSdkVersion: state.selectedVersionToSwitchTo!.name,
            updateVscodeSettings: true);
        // Use Flutter version
        CacheFlutterVersion cacheFlutterVersion = CacheFlutterVersion(
            FlutterVersion(state.selectedVersionToSwitchTo!.name,
                type: VersionType.release),
            directory: state.selectedVersionToSwitchTo!.directory);
        // Checks if version is installed, and installs or exits
        DebugLog.info('Setting up project...');
        await useVersionWorkflow(
            version: cacheFlutterVersion,
            project: state.currentProject!,
            force: true,
            skipSetup: false,
            runPubGetOnSdkChange: true);
        DebugLog.info('Project configured successfully.');
        state = state.copyWith(
            isSwitching: false,
            currentFlutterVersionSwitchedTo:
                state.selectedVersionToSwitchTo); // Update loading state
        // Reload downloaded Flutter versions
        await fetchDownloadedFlutterVersions();
        // Trigger getting available devices for current project
        await gettingFlutterPlatform();
      }
    } catch (e) {
      DebugLog.error("Error: $e");
      state = state.copyWith(isSwitching: false); // Set loading state to false
    }
  }

  // Install FVM if not already installed
  Future<void> installFvm() async {
    try {
      ProcessResult result = await Process.run(
        'dart',
        ['pub', 'global', 'activate', 'fvm'],
        workingDirectory: state.currentProject!.path,
        runInShell: true,
      );
      if (result.exitCode == 0) {
        DebugLog.info("FVM installed successfully!");
      }
    } catch (e) {
      DebugLog.error("Exception installing FVM: $e");
    }
  }

  // Select the online Flutter version
  void selectOnlineVersion(OnlineFlutterSDK version) {
    state = state.copyWith(
      selectedOnlineVersion: version,
    );
  }

  // Select the downloaded Flutter version
  void selectDownloadedVersion(String version) {
    final DownloadedFlutterSDK? selectedVersion = state.downloadedFlutterSDKs
        .firstWhereOrNull((element) => element.name == version);
    state = state.copyWith(selectedVersionToSwitchTo: selectedVersion);
  }

  // Open file picker to select project directory
  Future<void> selectProjectPath() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      final currentProject = Project.loadFromPath(selectedDirectory);
      // Check if project is Flutter project
      if (!currentProject.isFlutter) {
        _showNotAFlutterProjectAlert();
        return;
      }
      // Clear all state before setting new project
      _resetState();

      // Save the current project path
      await Properties.instance.saveSettings(Properties.instance.settings
          .copyWith(currentTargetProjectPath: currentProject.path));

      state = state.copyWith(currentProject: currentProject);
      await reInitialize();
      await gettingFlutterPlatform();
    }
  }

  /// Reset the state to initial state
  _resetState() {
    final mainHomeStateInit = MainHomeState.initial();
    state = state.copyWith(
      isFlutterSdksScreenLoading: mainHomeStateInit.isFlutterSdksScreenLoading,
      isDashboardScreenLoading: mainHomeStateInit.isDashboardScreenLoading,
      isDartInstalled: mainHomeStateInit.isDartInstalled,
      //onlineFlutterVersions: mainHomeStateInit.onlineFlutterVersions,
      //selectedOnlineVersion: mainHomeStateInit.selectedOnlineVersion,
      //downloadedFlutterSDKs: mainHomeStateInit.downloadedFlutterSDKs,
      selectedVersionToSwitchTo: mainHomeStateInit.selectedVersionToSwitchTo,
      //isJustOpened: false,
      isCheckingDartInstallation: mainHomeStateInit.isCheckingDartInstallation,
      isInstallingFvm: mainHomeStateInit.isInstallingFvm,
      isFetchingVersions: mainHomeStateInit.isFetchingVersions,
      isDownloading: mainHomeStateInit.isDownloading,
      downloadButtonIndex: mainHomeStateInit.downloadButtonIndex,
      isFetchingDownloaded: mainHomeStateInit.isFetchingDownloaded,
      isSwitching: mainHomeStateInit.isSwitching,
      currentFlutterVersionSwitchedTo:
          mainHomeStateInit.currentFlutterVersionSwitchedTo,
      isGettingAvailableDevices: mainHomeStateInit.isGettingAvailableDevices,
      currentProject: mainHomeStateInit.currentProject,
      isRunning: mainHomeStateInit.isRunning,
      isHotReloading: mainHomeStateInit.isHotReloading,
      selectedPlatform: mainHomeStateInit.selectedPlatform,
      availablePlatforms: mainHomeStateInit.availablePlatforms,
      //cacheSize: mainHomeStateInit.cacheSize,
      error: mainHomeStateInit.error,
    );
  }

  // Delete the current project path
  Future<void> deleteCurrentProjectPath() async {
    _resetState();
    Properties.instance.saveSettings(
        Properties.instance.settings.copyWith(currentTargetProjectPath: ''));
    state = state.copyWith(currentProject: null);
  }

  Future<void> gettingSavedCurrentProjectPath() async {
    // Add debug logging
    DebugLog.info("Getting saved project path");

    final currentTargetProjectPath =
        Properties.instance.settings.currentTargetProjectPath;

    if (currentTargetProjectPath.isNotEmpty) {
      final currentProject = Project.loadFromPath(currentTargetProjectPath);
      // Check if project is Flutter project
      if (!currentProject.isFlutter) {
        return;
      }
      DebugLog.info("Loaded project from path: ${currentProject.path}");
      state = state.copyWith(
        currentProject: currentProject,
      );
      //
      gettingFlutterPlatform();
    } else {
      DebugLog.info("No saved project path found");
    }
  }

  Future<void> gettingFlutterPlatform() async {
    state = state.copyWith(isGettingAvailableDevices: true);
    List<String> availablePlatforms = await _fetchFlutterPlatforms();
    state = state.copyWith(
        availablePlatforms: availablePlatforms,
        isGettingAvailableDevices: false);
  }

  Future<void> refreshAvailableDevices() async {
    state = state.copyWith(isGettingAvailableDevices: true);
    List<String> availablePlatforms = await _fetchFlutterPlatforms();
    state = state.copyWith(
        availablePlatforms: availablePlatforms,
        isGettingAvailableDevices: false);
  }

  void selectPlatform(String platform) {
    state = state.copyWith(selectedPlatform: platform);
  }

  Process? flutterProcess;

  Future<void> runFlutterProject() async {
    if (state.currentProject == null) return;
    state = state.copyWith(isRunning: true);
    try {
      await installFvm();
      logger
        ..detail('Project name: ${state.currentProject!.name}')
        ..detail('Start running project in: ${state.currentProject!.path}');
      flutterProcess = await Process.start(
          'fvm', ['flutter', 'run', '-d', state.selectedPlatform],
          workingDirectory: state.currentProject!.path, runInShell: true);
      DebugLog.info('Run project in: ${state.currentProject!.path}');
      flutterProcess!.stdout.transform(utf8.decoder).listen((data) {
        logger.detail(data);
      });
      flutterProcess!.exitCode.then((exitCode) {
        logger.err('Project exited with code: $exitCode');
        DebugLog.info('Flutter process exited with code: $exitCode');
        state = state.copyWith(isRunning: false);
      });
    } catch (e) {
      DebugLog.error("Error running Flutter project: $e");
      state = state.copyWith(isRunning: false);
    }
  }

  Future<void> stopFlutterProject() async {
    if (flutterProcess == null) return;

    try {
      flutterProcess!.kill();
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

  Future<List<String>> _fetchFlutterPlatforms() async {
    try {
      // Install FVM if not already installed
      await installFvm();
      // Run the flutter devices command
      DebugLog.info('Getting available devices...');
      ProcessResult result = await Process.run('fvm', ['flutter', 'devices'],
          workingDirectory: state.currentProject!.path, runInShell: true);
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
        state = state.copyWith(availablePlatforms: platforms);
        return platforms;
      }
    } catch (e) {
      DebugLog.error("Error fetching available devices: $e");
    }
    DebugLog.info('Available devices is EMPTY');
    return [];
  }

  _showNotAFlutterProjectAlert() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      rootNavigatorKey.currentContext?.showAlertDialogWithoutAction(
        title: 'Not a Flutter Project',
        content:
            'The selected directory is not a Flutter project. Please select a valid Flutter project.',
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterProcess?.kill();
  }
}
