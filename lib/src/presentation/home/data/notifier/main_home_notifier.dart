import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    state = state.copyWith(isDashboardScreenLoading: true);
    await checkFvmInstallation();
    await fetchOnlineFlutterVersions();
    await fetchDownloadedFlutterVersions();
    await gettingSavedCurrentProjectPath();
    state = state.copyWith(isDashboardScreenLoading: false);
  }

  // Check if FVM is installed and update the state
  Future<void> checkFvmInstallation() async {
    state = state.copyWith(isCheckingFvm: true); // Update loading state
    try {
      ProcessResult result = await Process.run('fvm', ['--version']);
      state = state.copyWith(
        fvmVersion: result.stdout.toString().trim(),
        isCheckingFvm: false, // Set loading state to false
      );
    } catch (e) {
      DebugLog.error(e.toString());
      state =
          state.copyWith(isCheckingFvm: false); // Set loading state to false
    }
  }

  // Reload the Flutter SDKs screen
  Future<void> reloadFlutterSdksScreen() async {
    state = state.copyWith(isFlutterSdksScreenLoading: true);
    await fetchOnlineFlutterVersions();
    await fetchDownloadedFlutterVersions();
    state = state.copyWith(isFlutterSdksScreenLoading: false);
  }

  // Fetch online Flutter SDK versions
  Future<void> fetchOnlineFlutterVersions() async {
    state = state.copyWith(isFetchingVersions: true); // Update loading state
    try {
      ProcessResult result = await Process.run('fvm', ['api', 'releases']);
      if (result.exitCode == 0) {
        String jsonString = result.stdout.toString();
        jsonString = jsonString.substring(
            jsonString.indexOf("["), jsonString.lastIndexOf("]") + 1);
        List<dynamic> jsonData = json.decode(jsonString);
        OnlineFlutterSDKVersions onlineFlutterSDKVersions =
            OnlineFlutterSDKVersions.fromJson(jsonData);
        // List<String> versions =
        //     releases.versions.map((release) => release.version).toList();
        state = state.copyWith(
          onlineFlutterVersions: onlineFlutterSDKVersions.versions,
          selectedOnlineVersion: onlineFlutterSDKVersions.versions.isNotEmpty
              ? onlineFlutterSDKVersions.versions.first.version
              : '',
          isFetchingVersions: false, // Set loading state to false
        );
      }
    } catch (e) {
      DebugLog.error("Error fetching Flutter versions: $e");
      state = state.copyWith(
          isFetchingVersions: false); // Set loading state to false
    }
  }

  // Download the selected Flutter version
  Future<void> downloadFlutterVersion() async {
    if (state.selectedOnlineVersion.isEmpty) return;
    state = state.copyWith(isDownloading: true); // Update loading state
    try {
      Process process =
          await Process.start('fvm', ['install', state.selectedOnlineVersion]);
      process.stdout.transform(utf8.decoder).listen((data) {
        List<Widget> newList =
            List.from(state.commandOutput); // Make a copy of the list
        newList.insert(0, Text(data)); // Modify the list
        state = state.copyWith(
            commandOutput: newList); // Update state with the new list
      });
      process.exitCode.then((exitCode) {
        if (exitCode == 0) {
          state = state.copyWith(
              isDownloading: false); // Set loading state to false
        } else {
          state = state.copyWith(
              isDownloading: false); // Set loading state to false
        }
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
      Process process = await Process.start('fvm', ['install', version]);
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
    state = state.copyWith(isFetchingDownloaded: true); // Update loading state
    try {
      ProcessResult result = await Process.run('fvm', ['api', 'list']);
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
      );
    } catch (e) {
      DebugLog.error("Error fetching Flutter versions: $e");
      state = state.copyWith(
          isFetchingDownloaded: false); // Set loading state to false
    }
  }

  // Switch the Flutter version for the project
  Future<void> switchFlutterVersion(String projectPath) async {
    if (state.selectedVersion.isEmpty) return;
    state = state.copyWith(isSwitching: true); // Update loading state
    try {
      Process process = await Process.start(
          'cmd', ['/c', 'echo y | fvm use ${state.selectedVersion}'],
          workingDirectory: projectPath);
      process.stdout.transform(utf8.decoder).listen((data) {
        List<Widget> newList =
            List.from(state.commandOutput); // Make a copy of the list
        newList.insert(0, Text(data)); // Modify the list
        state = state.copyWith(
            commandOutput: newList); // Update state with the new list
      });
      process.exitCode.then((exitCode) {
        state =
            state.copyWith(isSwitching: false); // Set loading state to false
      });
    } catch (e) {
      DebugLog.error("Error: $e");
      state = state.copyWith(isSwitching: false); // Set loading state to false
    }
  }

  // Install FVM if not already installed
  Future<void> installFvm() async {
    state = state.copyWith(isInstallingFvm: true); // Update loading state
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
            isInstallingFvm: false); // Set loading state to false
      }
    } catch (e) {
      DebugLog.error("Exception installing FVM: $e");
      state =
          state.copyWith(isInstallingFvm: false); // Set loading state to false
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
      await gettingFlutterPlatform();
    }
  }

  Future<void> gettingSavedCurrentProjectPath() async {
    final currentTargetProjectPath =
        Properties.instance.settings.currentTargetProjectPath;
    if (currentTargetProjectPath.isNotEmpty) {
      projectPathController.text = currentTargetProjectPath;
      state = state.copyWith(
        projectPath: currentTargetProjectPath,
      );
      await gettingFlutterPlatform();
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
          workingDirectory: state.projectPath);
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
          workingDirectory: state.projectPath);
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
