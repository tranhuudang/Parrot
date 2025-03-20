import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:parrot/src/app/app.dart';
import 'package:upgrader/upgrader.dart';

class UpgraderConfig {
  static const _proUrl =
      'https://raw.githubusercontent.com/tranhuudang/parrot/master/upgrader_pro.xml';
  static const _preUrl =
      'https://raw.githubusercontent.com/tranhuudang/parrot/master/upgrader_free.xml';
  static final upgrader = Upgrader(
    languageCode: Properties.instance.settings.language.toLocale().languageCode,
    //debugDisplayAlways: true,
    storeController: UpgraderStoreController(
      onWindows: () =>
          UpgraderAppcastStore(appcastURL: isProVersion ? _proUrl : _preUrl),
      onMacOS: () =>
          UpgraderAppcastStore(appcastURL: isProVersion ? _proUrl : _preUrl),
    ),
  );
}
