part of '../../main.dart';

class _Initializer {
  static Future<void> start() async {
    if (isWindows) {
      await _initForWindows();
    }
    if (isMacOS) {
      await _initForMacOS();
    }
  }

  static Future<void> _initForWindows() async {
    // ui
    await Properties.initialize().then((_) {});
    await WindowsStatusBar.initialize();
    await windowManager.ensureInitialized();
    // Get setting and set default value for windows size, title
    Size savedWindowsSize = Size(Properties.instance.settings.windowsWidth,
        Properties.instance.settings.windowsHeight);
    WindowManager.instance.setSize(savedWindowsSize);
    WindowManager.instance.setMinimumSize(AppConfigs.minWindowsSize);
    WindowManager.instance.setMaximumSize(AppConfigs.maxWindowsSize);
    WindowManager.instance.setTitle(AppConfigs.appTitleDescription);
    WindowManager.instance.setTitleBarStyle(TitleBarStyle.hidden);
  }

  static Future<void> _initForMacOS() async {
    // ui
    await Properties.initialize().then((_) {});

    await windowManager.ensureInitialized();
    // Get setting and set default value for windows size, title
    Size savedWindowsSize = Size(Properties.instance.settings.windowsWidth,
        Properties.instance.settings.windowsHeight);
    WindowManager.instance.setSize(savedWindowsSize);
    WindowManager.instance.setMinimumSize(AppConfigs.minWindowsSize);
    WindowManager.instance.setMaximumSize(AppConfigs.maxWindowsSize);
    WindowManager.instance.setTitle(AppConfigs.appTitleDescription);
    // Future.delayed(const Duration(seconds: 10), () {
    //   OpenAIKeySelector.init();
    // });
  }
}
