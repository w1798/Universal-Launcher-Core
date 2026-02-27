# Universal Software Bootstrap (USB) 萬用軟體前導程式

<p align="right">
  <b>English</b> | <a href="README_TW.md">繁體中文</a>
</p>

A professional, lightweight, and fully portable Windows batch-based launch core. USB enables you to manage registry keys, file synchronization, and directory junctions, ensuring your favorite software stays truly portable without leaving any trace on the host system.

---

## 💡 Development Philosophy (Why USB?)
In the Windows environment, re-installing software and re-configuring personal settings after a system restoration or OS re-installation is often the most time-consuming task. H was created to achieve a "Painless Restoration" experience:

System Partition Slimming: By keeping software binaries and data on a non-system partition (e.g., D: drive), the system backup image remains compact, saving significant storage space.

Instant Recovery: After a system restoration, there is no need for re-installation. Simply run the launcher to restore all personalized settings instantly.

Maintain System Purity: Data generated during software execution is automatically retracted to the storage area upon closing, ensuring the C: drive remains clean and clutter-free.

## 🛠️ Portabilization Workflow (Best Practice)
This suite is best used in conjunction with virtualization or monitoring tools (such as VMware, Sandboxie-Plus, or Total Uninstall) to achieve the best portabilization results:

Isolated Installation: Install the target software within a Virtual Machine or a Sandbox.

Change Tracking: Use Total Uninstall or the file monitoring features of Sandboxie-Plus to identify exactly which files, directories, and Registry keys the software creates on the C:\ drive.

Deployment: Copy the installed software folder to your portable directory (e.g., D:\Portable\App).

Configuration: Enter the file paths and Registry keys identified in Step 2 into the start.ini file.

One-Click Launch: Use the USB launcher to automate the restoration of settings, execute the software, and back up all changes back to MyData upon exit.

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
├── USB Deployment Tool.bat    # [Deployment] Rapid distribution tool
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
To manage multiple software packages efficiently, USB provides an automated deployment solution:

USB Rapid Distribution
Use the USB Deployment Tool.bat to install the USB core into multiple app directories:

Configuration: Place your app-specific settings (e.g., GitHubDesktop.ini) into the config directory.

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

## 🤝 Community Contributions
To make software portabilization even easier for everyone, I sincerely invite you to share your fine-tuned start.ini configurations!

How to Contribute: You can post your configuration in the Discussions area.

Why Share?: Verified configurations will be added to the config/ directory. Future users can then use the "USB Deployment Tool" to set up their portable apps instantly without having to re-analyze file paths or registry keys.

## 📜 License
This project is licensed under the GPLv3 License - see the LICENSE file for details.

✍️ Author
Charles Nextime – Passionate about software portability and automation script development.

## 💬 Feedback & Discussion
If you have any suggestions or would like to share your thoughts, feel free to join the discussion:

[![Giscus Discussions](https://img.shields.io/badge/💬-Giscus%20Discussions-blue?style=for-the-badge)](https://github.com/w1798/my-comments/discussions)

![Visitors](https://api.visitorbadge.io/api/visitors?path=w1798.USB&label=VIEWS&countColor=%2379c83d&style=flat-square)


<p align="center">Copyright (c) 2026 Charles Nextime</p>
