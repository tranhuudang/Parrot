import 'dart:async';
import 'package:marina_labs_common/marina_labs_common.dart';
import 'package:parrot/src/app/app.dart';
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

  Settings settings = AppConfigs.settings;

  Future<void> _saveSettings(Settings newSetting) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      DebugLog.info(
          'Saving current project path: ${newSetting.currentTargetProjectPath}');

      await prefs.setString(SharedPreferencesKey.currentTargetProjectPath,
          newSetting.currentTargetProjectPath);

      // Verify the save
      final savedPath =
          prefs.getString(SharedPreferencesKey.currentTargetProjectPath);
      DebugLog.info('Verified saved path: $savedPath');

      // Save other settings
      await prefs.setInt(
          SharedPreferencesKey.openAppCount, newSetting.openAppCount);
      await prefs.setString(SharedPreferencesKey.language, newSetting.language);
      await prefs.setDouble(
          SharedPreferencesKey.widthOfWindowSize, newSetting.windowsWidth);
      await prefs.setDouble(
          SharedPreferencesKey.heightOfWindowSize, newSetting.windowsHeight);
      await prefs.setString(
          SharedPreferencesKey.themeMode, newSetting.themeMode);
      await prefs.setInt(
          SharedPreferencesKey.themeColor, newSetting.themeColor);
      await prefs.setBool(SharedPreferencesKey.enableAdaptiveTheme,
          newSetting.enableAdaptiveTheme);
      await prefs.setBool(
          SharedPreferencesKey.didRateApp, newSetting.didRateApp);

      DebugLog.info('All settings saved successfully');
    } catch (e) {
      DebugLog.error('Error saving settings: $e');
      throw Exception('Failed to save settings: $e');
    }
  }

  Future<Settings> _getSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DebugLog.info('Loading settings from SharedPreferences');

      // Get project path first and log it
      final savedProjectPath =
          prefs.getString(SharedPreferencesKey.currentTargetProjectPath);
      DebugLog.info('Loaded project path: $savedProjectPath');

      var savedSetting = settings.copyWith(
        currentTargetProjectPath:
            savedProjectPath ?? settings.currentTargetProjectPath,
        openAppCount: prefs.getInt(SharedPreferencesKey.openAppCount) ??
            settings.openAppCount,
        language:
            prefs.getString(SharedPreferencesKey.language) ?? settings.language,
        windowsWidth: prefs.getDouble(SharedPreferencesKey.widthOfWindowSize) ??
            settings.windowsWidth,
        windowsHeight:
            prefs.getDouble(SharedPreferencesKey.heightOfWindowSize) ??
                settings.windowsHeight,
        themeMode: prefs.getString(SharedPreferencesKey.themeMode) ??
            settings.themeMode,
        themeColor: prefs.getInt(SharedPreferencesKey.themeColor) ??
            settings.themeColor,
        enableAdaptiveTheme:
            prefs.getBool(SharedPreferencesKey.enableAdaptiveTheme) ??
                settings.enableAdaptiveTheme,
        didRateApp: prefs.getBool(SharedPreferencesKey.didRateApp) ??
            settings.didRateApp,
      );

      DebugLog.info('Settings loaded successfully');
      return savedSetting;
    } catch (e) {
      DebugLog.error('Error loading settings: $e');
      // Return default settings on error
      return settings;
    }
  }
}
