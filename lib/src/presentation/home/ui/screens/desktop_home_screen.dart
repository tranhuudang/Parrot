import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_version_manager/src/core/core.dart';
import 'package:flutter_version_manager/src/core/utils/launchUrl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../presentation.dart';
import '../widgets/main_home_body.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({super.key});

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
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
    return Scaffold(
      body: Column(
        children: [
          buildAppHeader(context),
          const Divider(
            height: 0,
            thickness: .5,
          ),
          // Control Section
          const Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: MainHomeBody(),
          )),
        ],
      ),
    );
  }

  Row buildAppHeader(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
          height: 109,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //     colors: [
          //       Colors.black,
          //       Colors.transparent,
          //       Colors.transparent,
          //     ],
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                            'assets/flutter.png',
                            height: 30,
                            width: 30,
                          )),
                    ),
                    Opacity(
                      opacity: .05,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/flutter.png',
                            height: 50,
                            width: 50,
                          )),
                    ),
                    Opacity(
                      opacity: .1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            'assets/flutter.png',
                            height: 80,
                            width: 80,
                          )),
                    ),
                    Opacity(
                      opacity: .2,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset('assets/flutter.png')),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.height,
                          Row(
                            children: [
                              Text(
                                "${DefaultSettings.appShortName}",
                                style: context.theme.textTheme.titleMedium,
                              ),
                              Text(
                                " | ",
                                style: context.theme.textTheme.titleMedium,
                              ),
                              Opacity(
                                opacity: .5,
                                child: Text(
                                  "${DefaultSettings.appTitleDescription.i18n}",
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
                          Opacity(
                            opacity: .5,
                            child: Row(
                              children: [
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () =>
                                        openUrl('https://github.com/tranhuudang'),
                                    child: const Icon(
                                      FontAwesomeIcons.github,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                8.width,
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                      child: const Icon(
                                        FluentIcons.mail_20_regular,
                                        size: 20,
                                      ),
                                      onTap: () =>
                                          openUrl('mailto:dt148f148@gmail.com')),
                                ),
                              ],
                            ),
                          ),
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
