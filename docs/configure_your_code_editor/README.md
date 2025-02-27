# Configure FVM in Your Code Editor

This guide will help you set up Flutter Version Management (FVM) in Visual Studio Code and Android Studio for better Flutter version control.

## <img src="https://upload.wikimedia.org/wikipedia/commons/9/9a/Visual_Studio_Code_1.35_icon.svg" width="20" height="20"> Visual Studio Code Setup

1. Open VS Code settings (`settings.json`):
   - **Windows:** Go to `File` → `Preferences` → `Settings`, then click the icon in the top right corner as shown below:


   <img src="https://raw.githubusercontent.com/tranhuudang/Parrot/refs/heads/master/docs/configure_your_code_editor/settings_vscode.png">

1. Add the following configuration:
   ```json
   {
       "dart.flutterSdkPath": ".fvm/flutter_sdk"
   }
   ```

2. If you're using tasks in VS Code, update your `tasks.json`:
   ```json
   {
       "version": "2.0.0",
       "tasks": [
           {
               "type": "flutter",
               "command": "fvm flutter",
               "args": ["run"]
           }
       ]
   }
   ```

## <img src="https://upload.wikimedia.org/wikipedia/commons/5/51/Android_Studio_Logo_2024.svg" width="20" height="20"> Android Studio Setup

1. Open Android Studio **Settings/Preferences**.
2. Navigate to `Languages & Frameworks > Flutter`.
3. Set the Flutter SDK path to:
   - **Windows:** `<Your project path>\.fvm\flutter_sdk`
   - **macOS/Linux:** `<Your project path>/.fvm/flutter_sdk`

## Notices
1. **All embedded buttons in VS Code and Android Studio will now automatically use the Flutter version set by Parrot.**  
2. **If you want to run Flutter commands from the terminal, don't forget to prefix them with `fvm`.**

   
   ```bash
   fvm flutter pub get
   fvm dart run build_runner build
   ```

For more information, visit the [FVM documentation](https://fvm.app/docs/getting_started/overview).
