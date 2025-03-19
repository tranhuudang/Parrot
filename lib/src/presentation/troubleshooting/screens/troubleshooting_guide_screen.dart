import 'package:flutter/material.dart';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:parrot/src/app/app.dart';

class TroubleshootingGuideScreen extends StatelessWidget {
  const TroubleshootingGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            leading: const Icon(FluentIcons.bug_16_regular),
            title: 'Common Issues & Solutions'.i18n,
            children: const [],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildIssueCard(
                  context,
                  title: 'How to Configure FVM in Your Code Editor?',
                  description:
                      'Learn how to set up FVM integration in VS Code and Android Studio',
                  mdPath: OnlineDirectory.configureFvm,
                ),
                _buildIssueCard(
                  context,
                  title: 'Parrot Not Displaying Flutter SDKs',
                  description:
                      'Troubleshoot when Flutter SDK versions are not showing up',
                  mdPath: OnlineDirectory.noFlutterSdks,
                ),
                _buildIssueCard(
                  context,
                  title: 'Project Not Running After Version Change',
                  description:
                      'Fix issues when project fails to run after switching Flutter versions',
                  mdPath: OnlineDirectory.projectNotRunning,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueCard(
    BuildContext context, {
    required String title,
    required String description,
    required String mdPath,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title.i18n),
        subtitle: Text(
          description.i18n,
          style: context.theme.textTheme.bodySmall,
        ),
        trailing: const Icon(FluentIcons.chevron_right_16_regular),
        onTap: () => openUrl(mdPath),
      ),
    );
  }
}
