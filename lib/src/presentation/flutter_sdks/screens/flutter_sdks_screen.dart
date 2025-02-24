import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_version_manager/src/core/core.dart';
import 'package:flutter_version_manager/src/presentation/home/data/model/flutter_versions.dart';
import 'package:flutter_version_manager/src/presentation/home/data/notifier/main_home_notifier.dart';
import 'package:flutter_version_manager/src/presentation/presentation.dart';

class FlutterSDKReleasesScreen extends ConsumerWidget {
  const FlutterSDKReleasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainHomeProvider);
    final notifier = ref.read(mainHomeProvider.notifier);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 109,
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                const HeaderFlutters(),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flutter SDK releases'.i18n,
                        style: context.theme.textTheme.titleMedium,
                      ),
                      const Spacer(),
                      // Label showing cache size of downloaded Flutter SDKs and button to open the folder that contains the Flutter SDKs
                      Row(
                        children: [
                          Text(
                            'Cache size: ${state.cacheSize}',
                            style: context.theme.textTheme.labelMedium,
                          ),
                          4.width,
                          // Icon button to open the folder that contains the Flutter SDKs
                          IconButton(
                            onPressed: () {
                              openDirectory(state
                                  .downloadedFlutterSDKs[0].directory
                                  .substring(
                                      0,
                                      state.downloadedFlutterSDKs[0].directory
                                          .indexOf(state
                                              .downloadedFlutterSDKs[0].name)));
                            },
                            icon: const Icon(FluentIcons.folder_16_regular,
                                size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: .5,
          ),
          Expanded(
            child: SystemLoadingIndicator(
              isLoading: state.isFlutterSdksScreenLoading,
              child: Column(
                children: [
                  SizedBox(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.only(left: 16),
                                height: double.infinity,
                                child: Row(
                                  children: [
                                    Text(
                                      'Available versions'.i18n,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              height: double.infinity,
                              child: Row(
                                children: [
                                  Text('Channel'.i18n),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(left: 16),
                              height: double.infinity,
                              child: Row(
                                children: [
                                  Text('Release date'.i18n),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      notifier.reloadFlutterSdksScreen(),
                                  icon: const Icon(
                                      FluentIcons.arrow_sync_16_regular),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      notifier.fetchOnlineFlutterVersions(),
                                  icon:
                                      const Icon(FluentIcons.filter_16_regular),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: .5,
                  ),
                  8.height,
                  Expanded(
                    child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: state.onlineFlutterVersions.length,
                      itemBuilder: (context, index) {
                        final onlineFlutterSDK =
                            state.onlineFlutterVersions[index];
                        bool isDownloaded = state.downloadedFlutterSDKs.any(
                            (element) =>
                                element.name == onlineFlutterSDK.version);
                        return InkWell(
                          onTap: () {
                            showInfoBottomSheet(context, onlineFlutterSDK);
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(onlineFlutterSDK.version),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 9),
                                      child: Text(onlineFlutterSDK.channelName
                                          .upperCaseFirstLetter()),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        onlineFlutterSDK.releaseDate
                                                ?.split('T')
                                                .first ??
                                            '',
                                        style: TextStyle(
                                            color: context.theme.dividerColor),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Icon button to open the folder that contains the downloaded Flutter SDK
                                        isDownloaded
                                            ? IconButton(
                                                icon: const Icon(FluentIcons
                                                    .folder_16_regular),
                                                onPressed: () {
                                                  openDirectory(state
                                                      .downloadedFlutterSDKs
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          onlineFlutterSDK
                                                              .version)
                                                      .directory);
                                                },
                                              )
                                            :
                                            // Icon button to download the Flutter SDK
                                            IconButton(
                                                icon: state.isDownloading &&
                                                        state.downloadButtonIndex ==
                                                            index
                                                    ? const SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator())
                                                    : const Icon(FluentIcons
                                                        .arrow_download_16_regular),
                                                onPressed: state.isDownloading
                                                    ? null
                                                    : () {
                                                        notifier.downloadFlutterVersionByName(
                                                            onlineFlutterSDK
                                                                .version,
                                                            downloadButtonIndex:
                                                                index);
                                                      },
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showInfoBottomSheet(
    BuildContext context,
    OnlineFlutterSDK onlineFlutterSDK,
  ) {
    showModalBottomSheet(
      context: context,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${'Version:'.i18n} ${onlineFlutterSDK.version}',
                      style: context.theme.textTheme.titleMedium,
                    ),
                    Text(
                      ' (${onlineFlutterSDK.channelName})',
                      style: context.theme.textTheme.titleMedium,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: () {
                        openUrl(
                            '${OnlineDirectory.flutterReleaseNotes}${onlineFlutterSDK.version}');
                      },
                      label: Text('Release notes'.i18n),
                      icon: const Icon(FluentIcons.open_12_regular),
                    ),
                  ],
                ),
                8.height,
                8.height,
                Text(
                  'Dart SDK version: ${onlineFlutterSDK.dartSdkVersion}',
                  style: context.theme.textTheme.labelMedium,
                ),
                8.height,
                Text(
                  'Dart SDK architecture: ${onlineFlutterSDK.dartSdkArch}',
                  style: context.theme.textTheme.labelMedium,
                ),
                8.height,
                Row(
                  children: [
                    Text(
                      'Download:',
                      style: context.theme.textTheme.labelMedium,
                    ),
                    8.width,
                    FilledButton.tonalIcon(
                      onPressed: () {
                        openUrl(onlineFlutterSDK.archiveUrl);
                      },
                      label: Text('Download to Parrot'.i18n),
                      icon: const Icon(FluentIcons.arrow_download_16_regular),
                    ),
                    8.width,
                    FilledButton.tonalIcon(
                      onPressed: () {
                        openUrl(onlineFlutterSDK.archiveUrl);
                      },
                      label: Text('Download zip'.i18n),
                      icon: const Icon(FluentIcons.cloud_arrow_down_32_regular),
                    ),
                  ],
                ),
                8.height,
                Row(
                  children: [
                    ActionChip(
                      label: const Text('Hash'),
                      onPressed: () {
                        copyToClipboard(context, text: onlineFlutterSDK.hash);
                      },
                    ),
                    8.width,
                    ActionChip(
                      label: const Text('SHA256'),
                      onPressed: () {
                        copyToClipboard(context, text: onlineFlutterSDK.sha256);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
