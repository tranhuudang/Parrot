import 'package:collection/collection.dart';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/src/app/app.dart';
import 'package:parrot/src/presentation/home/data/model/downloaded_flutter_sdks.dart';
import 'package:parrot/src/presentation/home/data/model/flutter_versions.dart';
import 'package:parrot/src/presentation/home/data/notifier/main_home_state.dart';
import 'package:parrot/src/presentation/home/widgets/info_row.dart';
import 'package:parrot/src/presentation/home/widgets/log_console_view.dart';
import 'package:parrot/src/presentation/home/widgets/platform_selector.dart';
import '../../presentation.dart';
import '../data/notifier/main_home_notifier.dart';
import 'control_project_button.dart';

class MainHomeBody extends ConsumerWidget {
  const MainHomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainHomeProvider);
    final notifier = ref.read(mainHomeProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildTargetFlutterProjectSelection(state, notifier, context),
            ),
          ),
          16.height,
          DisabledWidget(
            isDisabled: !state.isDartInstalled || state.currentProject == null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Flutter SDK Management'.i18n, 
                          style: context.theme.textTheme.titleMedium),
                        16.height,
                        buildAvailableFlutterSDKreleases(state, notifier),
                        if (state.currentProject != null) ...[
                          16.height,
                          buildSelectFlutterVersionToSwitch(state, notifier),
                        ],
                      ],
                    ),
                  ),
                ),
                if (state.currentProject != null) ...[
                  16.height,
                  //buildProjectInfo(state, context),
                  16.height,
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Project Controls'.i18n, 
                            style: context.theme.textTheme.titleMedium),
                          16.height,
                          buildProjectRunningControl(state, notifier, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          16.height,
          Expanded(
            child: Card(
              child: buildConsole(context, state),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTargetFlutterProjectSelection(
      MainHomeState state, MainHomeNotifier notifier, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Target Flutter Project:'.i18n),
                if (state.currentProject != null) ...[
                  4.height,
                  Row(
                    children: [
                      Text(
                        'Pinned version: '.i18n,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.7),
                        ),
                      ),
                      Text(
                        state.currentProject?.pinnedVersion?.toString() ?? 'null',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            8.width,
            Expanded(
              child: state.currentProject != null
                  ? Text(state.currentProject!.path)
                  : Text(
                      'Selected Flutter Project Path'.i18n,
                      style: TextStyle(
                          color: context.theme.colorScheme.onSurface
                              .withValues(alpha: .5)),
                    ),
            ),
            if (state.currentProject != null) ...[
              IconButton(
                onPressed: () => _showProjectInfo(context, state),
                tooltip: 'Project Info'.i18n,
                icon: Icon(
                  FluentIcons.info_16_regular,
                  size: 18,
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ],
            DisabledWidget(
              isDisabled: state.currentProject == null,
              child: IconButton(
                  onPressed: () => notifier.deleteCurrentProjectPath(),
                  icon: Icon(
                    state.currentProject == null
                        ? FluentIcons.delete_12_regular
                        : FluentIcons.delete_off_20_regular,
                    size: 21,
                    color: context.theme.colorScheme.primary,
                  )),
            ),
            ElevatedButton.icon(
              icon: state.currentProject == null
                  ? const Icon(FluentIcons.edit_16_regular)
                  : const Icon(FluentIcons.folder_16_regular),
              onPressed: () => notifier.selectProjectPath(),
              label: state.currentProject != null
                  ? Text('Edit'.i18n)
                  : Text('Select Project'.i18n),
            ),
          ],
        ),
      ],
    );
  }

  void _showProjectInfo(BuildContext context, MainHomeState state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "${state.currentProject!.name.upperCaseFirstLetter()} project info".i18n,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(
              label: 'Pinned version:'.i18n,
              value: state.currentProject?.pinnedVersion?.toString() ?? 'null',
              isHighlighted: true,
            ),
            InfoRow(
              label: 'SDK Constraint:'.i18n,
              value: state.currentProject?.sdkConstraint.toString() ?? 'null',
            ),
            InfoRow(
              label: 'Dart Tool version:'.i18n,
              value: state.currentProject?.dartToolVersion ?? 'null',
            ),
            InfoRow(
              label: 'Has an FVM config file:'.i18n,
              value: '${state.currentProject?.hasConfig ?? 'null'}',
            ),
            InfoRow(
              label: 'Is .gitignore updated:'.i18n,
              value: '${state.currentProject?.config?.updateGitIgnore ?? 'null'}',
            ),
            InfoRow(
              label: 'Is VS Code Settings updated:'.i18n,
              value: '${state.currentProject?.config?.updateVscodeSettings ?? 'null'}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'.i18n),
          ),
        ],
      ),
    );
  }

  Row buildAvailableFlutterSDKreleases(
      MainHomeState state, MainHomeNotifier notifier) {
    bool isDownloaded = state.downloadedFlutterSDKs
        .any((element) => element.name == state.selectedOnlineVersion?.version);
    return Row(
      children: [
        Text("${'Flutter SDK releases'.i18n} "),
        8.width,
        RoundedDottedDropdownButton<OnlineFlutterSDK>(
          value: state.selectedOnlineVersion,
          // hint: Text("Select Flutter Version".i18n),
          items: state.onlineFlutterVersions.map((flutterSDK) {
            return DropdownMenuItem<OnlineFlutterSDK>(
              value: flutterSDK,
              child: Text(flutterSDK.version),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              notifier.selectOnlineVersion(value);
            }
          },
        ),
        8.width,
        IconButton(
          onPressed: () =>
              notifier.fetchOnlineFlutterVersions(forceRefresh: true),
          icon: const Icon(FluentIcons.arrow_sync_16_regular),
        ),
        const Spacer(),
        8.width,
        DisabledWidget(
          isDisabled: isDownloaded,
          child: ElevatedButton.icon(
            icon: const Icon(FluentIcons.arrow_download_16_regular),
            onPressed: state.isDownloading
                ? null
                : () => notifier.downloadFlutterVersion(),
            label: state.isDownloading
                ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator())
                : Text("Download".i18n),
          ),
        ),
      ],
    );
  }

  Row buildSelectFlutterVersionToSwitch(
      MainHomeState state, MainHomeNotifier notifier) {
    // Currently Pinned version is buggy, so we are using the selected version to switch to
    if (state.currentProject?.config != null) {
      DebugLog.error(
          'Pinned version: ${state.currentProject?.config!.flutter ?? 'null'}');
    }
    final DownloadedFlutterSDK? pinnedVersion = state.downloadedFlutterSDKs
        .firstWhereOrNull((element) =>
            element.name == state.currentProject?.pinnedVersion?.name);
    return Row(
      children: [
        const Icon(
          FluentIcons.circle_16_regular,
          size: 14,
        ),
        16.width,
        Text("Select new Flutter version to switch:".i18n),
        8.width,
        RoundedDottedDropdownButton<String>(
          value: state.selectedVersionToSwitchTo?.name,
          hint: Text("Select Flutter Version".i18n),
          items: state.downloadedFlutterSDKs
              .map((DownloadedFlutterSDK flutterSDK) => DropdownMenuItem(
                    value: flutterSDK.name,
                    child: Text(flutterSDK.name),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              notifier.selectDownloadedVersion(value);
            }
          },
        ),
        8.width,
        IconButton(
          onPressed: () => notifier.fetchDownloadedFlutterVersions(),
          icon: const Icon(FluentIcons.arrow_sync_16_regular),
        ),
        const Spacer(),
        8.width,
        DisabledWidget(
          isDisabled: // state.currentFlutterVersionSwitchedTo != null ||
              (state.selectedVersionToSwitchTo == pinnedVersion),
          child: ElevatedButton.icon(
            icon: const Icon(FluentIcons.arrow_shuffle_16_regular),
            onPressed: state.isSwitching
                ? null
                : () => notifier.switchFlutterVersion(),
            label: state.isSwitching
                ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator())
                : Text("Switch".i18n),
          ),
        ),
      ],
    );
  }

  Widget buildProjectRunningControl(
      MainHomeState state, MainHomeNotifier notifier, BuildContext context) {
    // Check if the selected version is setup
    final isSetup = state.downloadedFlutterSDKs.any((element) =>
        element.isSetup == true && element == state.selectedVersionToSwitchTo);
    return Row(
      children: [
        DisabledWidget(
          isDisabled: state.selectedVersionToSwitchTo == null ||
              state.availablePlatforms.isEmpty ||
              !(state.currentFlutterVersionSwitchedTo?.isSetup ?? false),
          child: Row(
            children: [
              8.width,
              const Icon(
                FluentIcons.circle_16_regular,
                size: 14,
              ),
              16.width,
              Text('Device:'.i18n),
              16.width,
              const PlatformSelector(),
              16.width,
              if (state.isGettingAvailableDevices) ...[
                const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator()),
                16.width,
              ],
              ControlProjectButton(
                backgroundColor: const Color(0xFF66BB6A),
                enabled: !state.isRunning &&
                    isSetup &&
                    !state.isGettingAvailableDevices,
                icon: const Icon(
                  FluentIcons.play_16_regular,
                  size: 16,
                ),
                onPressed: () {
                  notifier.runFlutterProject();
                },
              ),
              8.width,
              if (state.isRunning) ...[
                ControlProjectButton(
                  backgroundColor: const Color(0xFFF50057),
                  enabled: state.isRunning,
                  icon: const Icon(
                    FluentIcons.stop_16_regular,
                    size: 16,
                  ),
                  onPressed: () {
                    notifier.stopFlutterProject();
                  },
                ),
                8.width,
                ControlProjectButton(
                  backgroundColor: Colors.orange,
                  enabled: state.isRunning,
                  icon: const Icon(
                    FluentIcons.arrow_sync_24_regular,
                    size: 16,
                  ),
                  onPressed: () {
                    notifier.hotReloadFlutterProject();
                  },
                ),
                8.width,
              ],
              if (isSetup)
                IconButton(
                  onPressed: () => notifier.refreshAvailableDevices(),
                  icon: const Icon(FluentIcons.arrow_sync_16_regular),
                ),
            ],
          ),
        ),
        const Spacer(),
        // Button navigator to a website that guides user how to configure FVM on their code editor
        if (!state.isRunning)
          TextButton.icon(
            icon: const Icon(FluentIcons.question_circle_16_regular),
            iconAlignment: IconAlignment.end,
            onPressed: () {
              openUrl(OnlineDirectory.setupFVMonCodeEditorGuide);
            },
            label: Text('Configure code editor'.i18n),
          ),
      ],
    );
  }

  Expanded buildConsole(BuildContext context, MainHomeState state) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration:
            BoxDecoration(color: context.theme.colorScheme.surfaceContainer),
        child: LogConsoleView(
          shouldClearLogs: state.currentProject == null,
        ),
      ),
    );
  }
}
