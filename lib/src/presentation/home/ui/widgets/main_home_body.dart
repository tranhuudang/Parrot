import 'package:collection/collection.dart';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/src/app/app.dart';
import 'package:parrot/src/presentation/home/data/model/downloaded_flutter_sdks.dart';
import 'package:parrot/src/presentation/home/data/model/flutter_versions.dart';
import 'package:parrot/src/presentation/home/data/notifier/main_home_state.dart';
import 'package:parrot/src/presentation/home/ui/widgets/log_console_view.dart';
import 'package:parrot/src/presentation/home/ui/widgets/platform_selector.dart';
import '../../../presentation.dart';
import '../../data/notifier/main_home_notifier.dart';
import 'control_project_button.dart';

class MainHomeBody extends ConsumerWidget {
  const MainHomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainHomeProvider);
    final notifier = ref.read(mainHomeProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.height,
        buildTargetFlutterProjectSelection(state, notifier, context),
        // Check if dart is installed
        if (!state.isDartInstalled && state.currentProject != null)
          buildDartInstalation(state, context, notifier),

        DisabledWidget(
          isDisabled: !state.isDartInstalled || state.currentProject == null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildAvailableFlutterSDKreleases(state, notifier),
              if (state.currentProject != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildSelectFlutterVersionToSwitch(state, notifier),
                      8.height,
                      buildProjectRunningControl(state, notifier),
                    ],
                  ),
                )
              ],
            ],
          ),
        ),
        8.height,
        buildConsole(context, state)
      ],
    );
  }

  Widget buildDartInstalation(
      MainHomeState state, BuildContext context, MainHomeNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FilledButton(
              onPressed: () => openUrl(OnlineDirectory.installFlutterUrl),
              child: Text('Install Flutter'.i18n),
            )
            // Cut off the version if it's too long
            ,
            8.width,
            IconButton(
              onPressed: () => notifier.checkDartInstallation(),
              icon: const Icon(FluentIcons.arrow_sync_16_regular),
            ),
          ],
        ),
        Text(
          '*You must have Flutter installed to use this app.'.i18n,
          style:
              context.theme.textTheme.labelSmall?.copyWith(color: Colors.red),
        ),
        8.height,
      ],
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
            Text('Target Flutter Project:'.i18n),
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
            16.width,
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
      DebugLog.error('Pinned version: ${state.currentProject?.config!.flutter ?? 'null'}');
    }
    final DownloadedFlutterSDK? pinnedVersion = state.downloadedFlutterSDKs.firstWhereOrNull(
        (element) => element.name == state.currentProject?.pinnedVersion?.name);
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
          value: state.selectedVersionToSwitchTo != null
              ? state.selectedVersionToSwitchTo!.name
              : pinnedVersion?.name,
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
          isDisabled: state.selectedVersionToSwitchTo == null,
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
      MainHomeState state, MainHomeNotifier notifier) {
    // Check if the selected version is setup
    final isSetup = state.downloadedFlutterSDKs.any((element) =>
        element.isSetup == true && element == state.selectedVersionToSwitchTo);
    final isSwitched = state.currentFlutterVersionSwitchedTo ==
        state.selectedVersionToSwitchTo;
    return Row(
      children: [
        DisabledWidget(
          isDisabled: state.selectedVersionToSwitchTo == null ||
              !isSetup ||
              !isSwitched,
          child: Row(
            children: [
              const Icon(
                FluentIcons.circle_16_regular,
                size: 14,
              ),
              16.width,
              Text(state.currentProject != null
                  ? state.currentProject!.name
                  : ''),
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
        child: LogConsoleView(),
      ),
    );
  }
}
