# NG Setup — One‑Click Angular & Node.js Installer

## Overview

A simple, cross‑platform setup to get you ready for Angular development fast. The scripts will install:

- Node.js (LTS)
- npm (latest)
- Angular CLI v20 (global)

Supported platforms:
- Windows 10/11 (PowerShell)
- macOS (Homebrew)
- Linux (Debian/Ubuntu family)

## Support Matrix
- Windows: Installs Node.js via official MSI; installs Angular CLI globally with npm; run via PowerShell/batch. Requires execution policy bypass handled by the launcher.
- macOS: Installs Node.js via Homebrew (installs Homebrew if missing); updates npm; installs Angular CLI globally.
- Debian/Ubuntu: Adds NodeSource LTS repo; installs Node.js via apt; updates npm; installs Angular CLI globally.
- Other Linux distros: Not automated. Use manual instructions in the Alternative section.

## Prerequisites
- Internet connection (downloads installers and packages).
- Administrative privileges when prompted:
  - Windows: MSI install and script execution may require running PowerShell as Administrator.
  - Linux: Uses sudo for apt install.
  - macOS: Homebrew install may prompt for your password.
- Disk space: At least ~1 GB free for Node.js, npm cache, and Angular CLI.

---

## Table of Contents
- [Overview](#overview)
- [Support Matrix](#support-matrix)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
  - [Windows](#windows)
  - [macos--linux-debianubuntu](#macos--linux-debianubuntu)
- [Verify Installation](#verify-installation)
- [Alternative: Install without scripts](#alternative-install-without-scripts)
  - [Use official installers per OS](#use-official-installers-per-os)
  - [Helpful documentation links](#helpful-documentation-links)
- [Troubleshooting](#troubleshooting)
- [Uninstall / Cleanup](#uninstall--cleanup)
- [Project Structure](#project-structure)
- [Security Notes](#security-notes)
- [License](#license)

## Quick Start

Choose your OS and follow the steps below.

### Windows

Option A — Double‑click
1. Open the `windows` folder.
2. Double‑click `install-windows.bat`.
   - This will start PowerShell and run `install.ps1` with the correct policy settings.

Option B — Run from PowerShell
1. Right‑click Start → “Windows PowerShell” (or “PowerShell 7”) → Run as Administrator (recommended).
2. Navigate to this repo folder, then run:

   ```powershell
   # If needed, temporarily allow script execution for this session only
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

   # Run the installer
   .\windows\install.ps1
   ```

### macOS & Linux (Debian/Ubuntu)

1. Open a terminal in the repository root.
2. Make the script executable (first time only):

   ```bash
   chmod +x mac_linux/install.sh
   ```

3. Run the installer:

   ```bash
   ./mac_linux/install.sh
   ```

Permissions:
- On Linux, you may be prompted for your password because `sudo` is required for apt installation.

Unsupported distros:
- Non‑Debian/Ubuntu distributions aren’t automated by this script. Please install Node.js manually on those systems first, then run:

  ```bash
  npm install -g @angular/cli
  ```

---

## Verify Installation
After the installer finishes, check versions:

```bash
node -v
npm -v
ng --version
```

---

## Alternative: Install without scripts

If you prefer not to run scripts, here are safe, manual options to set up Node.js and Angular CLI.

### Use official installers per OS

- Windows (recommended for most users)
    1. Download and install Node.js: https://nodejs.org/en/download
    2. Open a new PowerShell/Command Prompt and install Angular CLI:
       ```powershell
       npm install -g @angular/cli
       ```
    3. Verify:
       ```powershell
       node -v
       npm -v
       ng version
       ```
    - Optional: If you use Chocolatey:
      ```powershell
      choco install nodejs-lts -y
      npm install -g @angular/cli
      ```

- macOS
    - With Homebrew (if you already have it):
      ```bash
      brew install node
      npm install -g @angular/cli
      ```
    - Without Homebrew: Download the macOS installer (PKG) from Node.js:
        - https://nodejs.org/en/download
        - Then open a new terminal and run:
          ```bash
          npm install -g @angular/cli
          ```

- Linux
    - Debian/Ubuntu via NodeSource (LTS):
      ```bash
      curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      sudo apt-get install -y nodejs
      npm install -g @angular/cli
      ```

---

## Troubleshooting

- Windows: Execution policy error
  - Symptom: “running scripts is disabled on this system”
  - Fix (current session only):
    ```powershell
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    .\windows\install.ps1
    ```
  - Or use the `install-windows.bat` launcher by double‑clicking it.

- macOS: “Developer cannot be verified” / Gatekeeper
  - If macOS blocks execution, right‑click the script in Finder → Open, or allow it from System Settings → Privacy & Security.

- Homebrew not found (macOS)
  - The script will install Homebrew automatically. If you still can’t run `brew` afterwards, open a new terminal or ensure your shell init files include:
    ```bash
    eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
    # or
    eval "$(/usr/local/bin/brew shellenv)"      # Intel
    ```

- npm permission errors (EACCES)
  - Try prefixing with sudo on Linux/macOS:
    ```bash
    sudo npm install -g @angular/cli
    ```
  - Consider configuring a Node version manager (nvm) to avoid global sudo installs.

- Linux distro not supported
  - If you’re not on Debian/Ubuntu, install Node.js LTS using your distro’s instructions or nvm, then:
    ```bash
    npm install -g @angular/cli
    ```

---

## Uninstall / Cleanup

- Angular CLI (global):
  ```bash
  npm uninstall -g @angular/cli
  ```

- Node.js:
  - Windows: Remove via “Apps & Features” (Node.js entry).
  - macOS (Homebrew):
    ```bash
    brew uninstall node
    ```
  - Debian/Ubuntu:
    ```bash
    sudo apt-get remove -y nodejs
    sudo apt-get autoremove -y
    ```

---

## Project Structure

```
ng-setup/
├─ mac_linux/
│  └─ install.sh
└─ windows/
   ├─ install-windows.bat
   └─ install.ps1
```

---

## Security Notes
- Scripts download installers from official sources (Node.js, Homebrew, NodeSource).
- Review scripts before running, especially when using `sudo` or changing PowerShell execution policy.

---

## License
This project is licensed under the MIT License — see the LICENSE file for details.

---


### Helpful documentation links
- Angular CLI docs: https://angular.dev/cli
- Node.js downloads: https://nodejs.org/en/download
- Homebrew (macOS): https://brew.sh/
- Chocolatey (Windows): https://chocolatey.org/
- NodeSource distributions: https://github.com/nodesource/distributions
- PowerShell execution policy (what and why): https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_Execution_Policies


