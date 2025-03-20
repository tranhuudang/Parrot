import 'package:flutter/material.dart';
import 'package:parrot/src/app/app.dart';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:windows_status_bar/windows_status_bar.dart';

class OpenAppLoading extends StatelessWidget {
  const OpenAppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WindowsStatusBarWidget(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            actions: [
              SizedBox(
                width: kToolbarHeight,
                height: kToolbarHeight - 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    isProVersion
                        ? LocalDirectory.parrotProLogo
                        : LocalDirectory.parrotPreviewLogo,
                  ),
                ),
              ),
              Text(
                AppConfigs.appName,
              ),
              const Spacer(),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    isProVersion
                        ? LocalDirectory.parrotProLogo
                        : LocalDirectory.parrotPreviewLogo,
                    height: 120,
                  ),
                  48.height,
                  const SizedBox(
                      width: 80, height: 4, child: LinearProgressIndicator()),
                  const Spacer(),
                  MarinaLabsBrand(
                    color: context.theme.colorScheme.onSurface
                        .withValues(alpha: 0.5),
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
