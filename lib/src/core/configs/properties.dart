import 'dart:async';
import 'package:parrot/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/domain.dart';

class Properties {
  // Ensures end-users cannot initialize the class
  Properties._();
  static final Properties _instance = Properties._();
  static Properties get instance => _instance;

  static Future<void> initialize() async {
    instance.settings = await instance._getSettings();
  }

  Future<void> saveSettings(Settings newSettings) async {
    await instance._saveSettings(newSettings);
    // Reload setting after saving new value;
    settings = newSettings;
  }

  Settings settings = DefaultSettings.settings;

  Future<void> _saveSettings(Settings newSetting) async {
    var prefs = SharedPreferencesAsync();
    await prefs.setInt(
        SharedPreferencesKey.openAppCount, newSetting.openAppCount);
    await prefs.setString(SharedPreferencesKey.language, newSetting.language);
    await prefs.setDouble(
        SharedPreferencesKey.widthOfWindowSize, newSetting.windowsWidth);
    await prefs.setDouble(
        SharedPreferencesKey.heightOfWindowSize, newSetting.windowsHeight);
    await prefs.setString(SharedPreferencesKey.themeMode, newSetting.themeMode);
    await prefs.setString(SharedPreferencesKey.currentTargetProjectPath,
        newSetting.currentTargetProjectPath);
    await prefs.setInt(SharedPreferencesKey.themeColor, newSetting.themeColor);
    await prefs.setBool(SharedPreferencesKey.enableAdaptiveTheme,
        newSetting.enableAdaptiveTheme);
    await prefs.setBool(SharedPreferencesKey.didRateApp, newSetting.didRateApp);
    DebugLog.info('Setting saved');
  }

  Future<Settings> _getSettings() async {
    var prefs = SharedPreferencesAsync();
    var savedSetting = settings.copyWith(
      openAppCount: await prefs.getInt(SharedPreferencesKey.openAppCount) ??
          settings.openAppCount,
      language: await prefs.getString(SharedPreferencesKey.language) ??
          settings.language,
      currentTargetProjectPath: await prefs
              .getString(SharedPreferencesKey.currentTargetProjectPath) ??
          settings.currentTargetProjectPath,
      windowsWidth:
          await prefs.getDouble(SharedPreferencesKey.widthOfWindowSize) ??
              settings.windowsWidth,
      windowsHeight:
          await prefs.getDouble(SharedPreferencesKey.heightOfWindowSize) ??
              settings.windowsHeight,
      themeMode: await prefs.getString(SharedPreferencesKey.themeMode) ??
          settings.themeMode,
      themeColor: await prefs.getInt(SharedPreferencesKey.themeColor) ??
          settings.themeColor,
      enableAdaptiveTheme:
          await prefs.getBool(SharedPreferencesKey.enableAdaptiveTheme) ??
              settings.enableAdaptiveTheme,
      didRateApp: await prefs.getBool(SharedPreferencesKey.didRateApp) ??
          settings.didRateApp,
    );
    return savedSetting;
  }
}
