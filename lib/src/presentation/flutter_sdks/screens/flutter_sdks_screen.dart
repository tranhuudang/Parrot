import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_version_manager/src/core/core.dart';
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
          SizedBox(
            height: 56,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  'Available versions'.i18n,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => notifier.fetchOnlineFlutterVersions(),
                  icon: const Icon(FluentIcons.arrow_sync_16_regular),
                ),
                IconButton(
                  onPressed: () => notifier.fetchOnlineFlutterVersions(),
                  icon: const Icon(FluentIcons.filter_16_regular),
                ),
                8.width,
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: .5,
          ),
          8.height,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.onlineFlutterVersions.length,
                    itemBuilder: (context, index) {
                      final onlineFlutterSDK =
                          state.onlineFlutterVersions[index];
                      bool isDownloaded = state.downloadedFlutterSDKs.any(
                          (element) =>
                              element.name == onlineFlutterSDK.version);
                      return ListTile(
                        title: Text(onlineFlutterSDK.version),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon button to open the folder that contains the downloaded Flutter SDK
                            if (isDownloaded)
                            IconButton(icon:
                              const Icon(FluentIcons.folder_16_regular),
                              onPressed: () {
                                openDirectory(state.downloadedFlutterSDKs
                                    .firstWhere((element) =>
                                        element.name == onlineFlutterSDK.version)
                                    .directory);
                              },
                            ),
                            // Icon button to download the Flutter SDK
                            if (!isDownloaded)
                              IconButton(
                                icon: state.isDownloading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator())
                                    : const Icon(
                                        FluentIcons.arrow_download_16_regular),
                                onPressed: state.isDownloading
                                    ? null
                                    : () =>
                                        notifier.downloadFlutterVersionByName(
                                            onlineFlutterSDK.version),
                              ),
                          ],
                        ),
                        onTap: () => notifier
                            .selectOnlineVersion(onlineFlutterSDK.version),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
