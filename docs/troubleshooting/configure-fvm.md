# How to Configure FVM in Your Code Editor

## Visual Studio Code
1. Install the FVM extension for VS Code
2. Add this to your settings.json:
```json
{
    "dart.flutterSdkPath": ".fvm/flutter_sdk"
}
```
3. Restart VS Code

## Android Studio / IntelliJ
1. Go to Languages & Frameworks > Flutter
2. Set Flutter SDK path to: YourProjectPath/.fvm/flutter_sdk
3. Restart IDE
