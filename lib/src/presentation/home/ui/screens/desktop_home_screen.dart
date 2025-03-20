import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parrot/src/app/app.dart';
import 'package:parrot/src/presentation/home/data/notifier/main_home_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../app/utils/utils.dart';
import '../../../presentation.dart';
import '../widgets/main_home_body.dart';

class DesktopHomeScreen extends ConsumerStatefulWidget {
  const DesktopHomeScreen({super.key});

  @override
  ConsumerState<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends ConsumerState<DesktopHomeScreen> {
  @override
  void initState() {
    super.initState();
    _seekFeedback();
  }

  void _seekFeedback() async {
    final didRateApp = Properties.instance.settings.didRateApp;
    final openAppCount = Properties.instance.settings.openAppCount;
    DebugLog.info('Open App Count: $openAppCount');
    if ((!didRateApp && openAppCount != 0 && openAppCount % 2 == 0) ||
        (didRateApp && openAppCount % 50 == 0)) {
      await Future.delayed(const Duration(seconds: 2), () {
        context.showAlertDialog(
            actionButtonTitle: 'Feedback'.i18n,
            title: 'Help Us Improve'.i18n,
            content:
                "If something isn’t working as expected, we’d like to know. Share your feedback on how we can improve or let us know what you enjoy about our app."
                    .i18n,
            action: () {
              goToStoreListing();
              Properties.instance.saveSettings(
                  Properties.instance.settings.copyWith(didRateApp: true));
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(mainHomeProvider);

      return Scaffold(
        body: Column(
          children: [
            buildAppHeader(context),
            const Divider(
              height: 0,
              thickness: .5,
            ),
            // Control Section
            Expanded(
                child: SystemLoadingIndicator(
              isLoading: state.isDashboardScreenLoading,
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: MainHomeBody(),
              ),
            )),
          ],
        ),
      );
    });
  }

  Row buildAppHeader(BuildContext context) {
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: 82,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                const HeaderFlutters(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          3.height,
                          Row(
                            children: [
                              // Text(
                              //   AppFlavor.instance.appName,
                              //   style: context.theme.textTheme.titleMedium,
                              // ),
                              // Text(
                              //   " | ",
                              //   style: context.theme.textTheme.titleMedium,
                              // ),
                              Opacity(
                                opacity: .5,
                                child: Text(
                                  AppConfigs.appTitleDescription.i18n,
                                  style: context.theme.textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          //const SizedBox(width: 100, child: Divider()),
                          8.height,
                          Text(
                              'A user-friendly, robust, and adaptable tool for managing multiple Flutter SDK versions.'
                                  .i18n,
                              style: context.theme.textTheme.labelMedium),
                          8.height,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
