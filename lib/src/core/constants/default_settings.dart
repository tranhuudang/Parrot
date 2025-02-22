import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class DefaultSettings {
  static String appTitleDescription = 'Flutter Version Manager for Desktop';
  static const String appShortName = 'Parrot';
  static const Size defaultWindowsSize = Size(950, 620);
  static const Size minWindowsSize = Size(950, 620);
  static const Size maxWindowsSize = Size(5000, 10000);
  static const double overflowHeight = 745;
  static final Settings settings = Settings(
    language: 'System default',
    windowsWidth: defaultWindowsSize.width,
    windowsHeight: defaultWindowsSize.height,
    themeMode: 'ThemeMode.system',
    openAppCount: 0,
    didRateApp: false,
    themeColor: Colors.orange.value,
    enableAdaptiveTheme: true,
    currentTargetProjectPath: '',
  );
}
