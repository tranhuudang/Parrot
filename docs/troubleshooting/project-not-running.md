# Project Not Running After Version Change

If your project won't run after changing Flutter versions, try:

1. Clean your project:
```bash
fvm flutter clean
```

2. Get dependencies again:
```bash
fvm flutter pub get
```

3. Verify IDE configuration:
- Ensure your IDE is using the correct Flutter SDK path
- Check if the FVM integration is properly set up

4. Check pubspec.yaml:
- Make sure your dependencies are compatible with the new Flutter version
