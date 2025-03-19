# Parrot Not Displaying Flutter SDKs

If Parrot isn't showing any Flutter SDK versions, try these solutions:


# Solution 1: Quick Troubleshooting Steps

1. **Check Internet Connection**  
   Ensure you have a stable internet connection

2. **Verify FVM Installation**  
   ```bash
   fvm --version
   ```

3. **Refresh SDK List**   
   Use the refresh button in Parrot's interface

4. **Validate Project Path**  
   Make sure you've selected a valid Flutter project directory

5. **Check Dart Installation**  
   ```bash
   dart --version
   ```

**Quick Fix:** If issues persist, try reinstalling FVM:
```bash
dart pub global deactivate fvm
dart pub global activate fvm
```

# Solution 2: Fresh FVM Installation

### Installation Methods by Platform

## Windows Installation

| Method | Command | 
|--------|---------|
| Chocolatey (Recommended) | `choco install fvm` |
| Dart pub | `dart pub global activate fvm` | 


## macOS Installation

| Method | Command | 
|--------|---------|
| Install Script (Recommended) | `curl -fsSL https://fvm.app/install.sh \| bash` |
| Homebrew | `brew tap leoafarias/fvm`<br>`brew install fvm` |
| Dart pub | `dart pub global activate fvm` |



## Linux Installation

| Method | Command | 
|--------|---------|
| Install Script (Recommended) | `curl -fsSL https://fvm.app/install.sh \| bash` |
| Homebrew | `brew tap leoafarias/fvm`<br>`brew install fvm` | 
| Dart pub | `dart pub global activate fvm` | 



### Post-Installation Steps

1. **Add to PATH**  
   Ensure FVM is added to your system PATH

2. **Restart Terminal**  
   Close and reopen your terminal/command prompt

3. **Verify Installation**  
   ```bash
   fvm --version
   ```
