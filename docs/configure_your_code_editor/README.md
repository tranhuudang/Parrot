# Configure FVM in Your Code Editor

This guide will help you set up Flutter Version Management (FVM) in Visual Studio Code and Android Studio for better Flutter version control.

## Visual Studio Code Setup

1. Install the [Flutter extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) if you haven't already.

2. Open your VS Code settings.json file and add the following configuration:
```json
{
    "dart.flutterSdkPath": ".fvm/flutter_sdk",
}
```

3. If you're using tasks in VS Code, update your tasks.json:
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "type": "flutter",
            "command": "fvm flutter",
            "args": ["run"],
        }
    ]
}
```

## Android Studio Setup

1. Open Android Studio Settings/Preferences.

2. Navigate to `Languages & Frameworks > Flutter`.

3. Set Flutter SDK path to:
   - Windows: `<project-dir>\.fvm\flutter_sdk`
   - macOS/Linux: `<project-dir>/.fvm/flutter_sdk`

## Usage

1. Switch Flutter versions using Parrot or FVM command bellow:
```bash
fvm use <version>
```

2. Your editor will automatically use the project-specific Flutter SDK.

3. All Flutter commands will now use the version specified in your project.


For more information, visit the [FVM documentation](https://fvm.app/docs/getting_started/overview).