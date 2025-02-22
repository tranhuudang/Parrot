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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: .01,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            LocalDirectory.flutterLogo,
                            height: 30,
                            width: 30,
                          )),
                    ),
                    Opacity(
                      opacity: .05,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            LocalDirectory.flutterLogo,
                            height: 50,
                            width: 50,
                          )),
                    ),
                    Opacity(
                      opacity: .1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            LocalDirectory.flutterLogo,
                            height: 80,
                            width: 80,
                          )),
                    ),
                    Opacity(
                      opacity: .2,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(LocalDirectory.flutterLogo)),
                    ),
                  ],
                ),
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
                          Text('Cache size: ${state.cacheSize}'),
                          8.width,
                          // Icon button to open the folder that contains the Flutter SDKs
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(FluentIcons.folder_16_regular),
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.availableVersions.length,
              itemBuilder: (context, index) {
                final version = state.availableVersions[index];
                return ListTile(
                  title: Text(version),
                  trailing: IconButton(
                    icon: state.isDownloading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator())
                        : const Icon(FluentIcons.arrow_download_16_regular),
                    onPressed: state.isDownloading
                        ? null
                        : () => notifier.downloadFlutterVersionByName(version),
                  ),
                  onTap: () => notifier.selectOnlineVersion(version),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
