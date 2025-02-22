# Install FVM CLI on Windows

Follow these steps to install FVM on your Windows machine:

## Step 1: Install Chocolatey (if you don't have it)

Run the following command in your PowerShell (as Administrator):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Step 2: Install FVM using Chocolatey

Run this command to install FVM:

```powershell
choco install fvm
```

---

For more information about how to install FVM, please visit:

[![FVM CLI Installation](https://fvm.app/assets/logo.svg)](https://fvm.app/documentation/getting-started/installation)
