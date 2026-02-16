# Universal Launcher Core Suite (ULC)

<p align="right">
  <b>English</b> | <a href="README_TW.md">繁體中文</a>
</p>

A professional, lightweight, and fully portable Windows batch-based launch core. ULC enables you to manage registry keys, file synchronization, and directory junctions, ensuring your favorite software stays truly portable without leaving any trace on the host system.

---

## 🚀 Key Features

* **Dual Storage Modes**: Supports both "Physical File Sync" and **MkLinkJ (Junction)** mounting modes, providing high-performance solutions for data-heavy applications.
* **Registry Portability**: Automatically backs up, restores, and cleans up Windows Registry keys upon exit.
* **Dynamic Command Chains**: Supports multiple custom commands before and after the main program execution (separated by the `|` symbol).
* **Robust Process Monitoring**: Actively monitors program status to ensure all background "zombie processes" are terminated before final backup.
* **Safe Cleanup Mechanism**: Built-in 5-retry logic for forced deletion to resolve file-lock issues and protect privacy.
* **Transparent Logging**: Detailed execution logs (`start_log.txt`) including system error messages for easy troubleshooting.

---

## 📂 Project Structure

```text
.
├── 0start.vbs                 # Silent Launcher (Prevents CMD window pop-ups)
├── start.bat                  # Core Launcher Engine (Batch script)
├── start.ini                  # Core Configuration File
├── ULC Lite Deployment Tool.bat # [Deployment] Rapid distribution tool
├── config/                    # [Deployment] App-specific config files (*.ini)
├── SyncBackFree4USB.bat       # Entry loader for USB root (Example for SyncBackFree)
└── MyData/                    # Portable Data Storage (Auto-generated)
    ├── C/                     # Simulated C: Drive file paths
    └── Registry.reg           # Registry backup file



💡 USB Entry Loader (e.g., SyncBackFree4USB.bat)
Specifically designed for software placed at the root of a USB drive:

Environment Variable Support: Automatically detects the current drive letter and defines %MyDrive%, %MY_DRIVE%, and %USB%.

Cross-Path Referencing: Regardless of the drive letter assigned (e.g., Z:), you can use %MyDrive%\Doc in settings to accurately locate folders on the USB drive.

```

## 🏗️ Deployment Guide
To manage multiple software packages efficiently, ULC provides an automated deployment solution:

ULC Lite Rapid Distribution
Use the ULC Lite Deployment Tool.bat to install the ULC core into multiple app directories:

Configuration: Place your app-specific settings (e.g., Chrome.ini, VSCode.ini) into the config directory.

Automated Distribution: Run the tool to automatically create folders in the target path (e.g., D:\Portable) based on the filenames, distribute the core scripts, and rename the specific INI to start.ini.

## ⚙️ Configuration (start.ini)
```text
The launcher is entirely driven by the start.ini file.
[Config]
; Main executable path
RunExe=App\Software.exe
; Process name for monitoring
ExeTaskName=Software.exe
; Use MkLink Junction (1) or Physical Sync (0)
MkLinkJ=1
; Mode: Passive (1: start /wait) or Active (0: loop monitor)
StartWait=0
; Enable debug pause (1: On, 0: Off)
Debug=0

[SaveList]
; Folders or files to persist
%AppData%\SoftwareName
%LocalAppData%\SoftwareName\settings.xml

[RegList]
; Registry keys to persist
HKEY_CURRENT_USER\Software\SoftwareVendor

[KillList]
; Background processes to terminate after closing
SoftwareUpdater.exe

[BeforeCMDList]
; Commands to run before launch (use | to separate)
md temp_work | del /f /q old_cache.tmp

[AfterCMDList]
; Commands to run after closing
rd /s /q temp_work
```

## 🛠️ Getting Started
Place 0start.vbs, start.bat, and your start.ini in the application's root directory.

Configure your paths and registry keys in start.ini.

Run 0start.vbs to launch your application silently.

Check start_log.txt if any issues occur during the process.

## 🛡️ Safety & Security
System Root Protection: Built-in protection prevents writing to or cleaning critical directories like Windows, Program Files, or Users.

Atomic Operations: Uses temporary batch execution techniques to avoid file occupancy conflicts during runtime.

Encoding Note: If the INI contains non-ASCII characters (e.g., Chinese paths), ensure the file is saved with UTF-8 with BOM encoding.

## 📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

✍️ Author
Charles Nextime – Passionate about software portability and automation script development.

## 💬 Feedback & Discussion
If you have any suggestions or would like to share your thoughts, feel free to join the discussion:

[![Giscus Discussions](https://img.shields.io/badge/💬-Giscus%20Discussions-blue?style=for-the-badge)](https://github.com/w1798/my-comments/discussions)

![Visitor Count](https://count.getloli.com/get/@w1798-ulc?theme=rule34)
