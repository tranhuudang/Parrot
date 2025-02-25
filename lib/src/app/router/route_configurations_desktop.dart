import 'package:parrot/src/app/router/route_name.dart';
import 'package:parrot/src/app/router/route_path.dart';
import 'package:parrot/src/presentation/dev_notes/note_taking_screen.dart';
import 'package:parrot/src/presentation/donation/donation_screen.dart';
import 'package:parrot/src/presentation/home/ui/screens/flutter_sdks_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_extension/i18n_extension.dart';
import '../../presentation/home/ui/screens/desktop_home_screen.dart';
import '../../presentation/presentation.dart';

// private navigators key shell
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorSettingKey =
    GlobalKey<NavigatorState>(debugLabel: 'Setting');
final _shellNavigatorDonationKey =
    GlobalKey<NavigatorState>(debugLabel: 'donation');
    final _shellFlutterSDKsKey =
    GlobalKey<NavigatorState>(debugLabel: 'FlutterSDKs');
final _shellNavigatorInfoKey = GlobalKey<NavigatorState>(debugLabel: 'Info');
final _shellNavigatorDashboardKey =
    GlobalKey<NavigatorState>(debugLabel: 'Dashboard');
final _shellNavigatorNoteTakingKey =
    GlobalKey<NavigatorState>(debugLabel: 'NoteTaking');
final globalNavigationShellKey =
    GlobalKey<NavigatorState>(debugLabel: 'GlobalNavigationShell');
late StatefulNavigationShell globalNavigationShell;

void goBranch(int index) {
  globalNavigationShell.goBranch(
    index,
    //initialLocation: true,
  );
}

GoRouter routerConfigDesktop = GoRouter(
  initialLocation:
      RoutePath.dashboard, //Properties.instance.settings.selectedTab,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        globalNavigationShell = navigationShell;
        // the UI shell
        return NavigationSwitchView(navigationShell: navigationShell);
      },
      branches: [
        // 0 dashboard
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDashboardKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouteName.dashboard,
              path: RoutePath.dashboard,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const DesktopHomeScreen()));
              },
            ),
          ],
        ),
        // 1 note taking branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorNoteTakingKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouteName.noteTaking,
              path: RoutePath.noteTaking,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: I18n(child: const NoteEditorScreen()));
              },
              routes: const [],
            ),
          ],
        ),
        // 2 setting branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouteName.commonSettings,
              path: RoutePath.settings,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const SettingsView()));
              },
            ),
          ],
        ),
        // 3 info
        StatefulShellBranch(
          navigatorKey: _shellNavigatorInfoKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouteName.infos,
              path: RoutePath.infos,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: I18n(child: const InfoView()));
              },
            ),
          ],
        ),
        // 4 donation
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDonationKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouteName.donation,
              path: RoutePath.donation,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: I18n(child: const DonationScreen()));
              },
            ),
          ],
        ),
        // 5 place holder
        StatefulShellBranch(
          navigatorKey: _shellFlutterSDKsKey,
          routes: [
            // top route inside branch
            GoRoute(
              name: RouteName.flutterSDKs,
              path: RoutePath.flutterSDKs,
              pageBuilder: (context, state) {
                return NoTransitionPage(child: I18n(child: const FlutterSDKReleasesScreen()));
              },
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    return I18n(child: const DesktopHomeScreen());
  },
);
