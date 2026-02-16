# Universal Launcher Core (ULC) Suite
<p align="right">
  <b>English</b> | <a href="README_TW.md">繁體中文</a>
</p>

A professional, portable, and lightweight batch-driven launcher core designed for Windows applications. ULC ensures your favorite software remains truly portable by managing registry keys, file synchronization, and directory mounting (Junctions) without leaving traces on the host system.



## 🚀 Key Features

* **Dual Storage Modes**: Supports both physical file synchronization and **MkLinkJ (Directory Junction)** mounting for high-performance data handling.
* **Registry Portability**: Automatically backs up, restores, and cleans up Windows Registry keys.
* **Dynamic Command Chain**: Execute multiple custom commands (via `|` pipe syntax) before and after the main application launch.
* **Robust Process Monitor**: Actively monitors application status and ensures background "zombie" processes are terminated before backup.
* **Safe-Cleanup Engine**: Features a 5-retry logic with forced deletion to ensure host privacy and prevent data loss from file locking.
* **Transparent Logging**: Detailed execution logs (`start_log.txt`) capturing every step, including system error messages for easy debugging.

## 📂 Project Structure

```text
.
├── 0start.vbs           # Silent launcher (prevents CMD window pop-up)
├── start.bat            # The Core Engine (Batch Script)
├── start.ini            # Configuration file
└── MyData/              # Portable data storage (Auto-generated)
    ├── C/               # Mirrored path for Drive C
    └── Registry.reg     # Registry backups

```
⚙️ Configuration (start.ini)
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


🛠️ Getting Started
Place 0start.vbs, start.bat, and your start.ini in the application's root directory.

Configure your paths and registry keys in start.ini.

Run 0start.vbs to launch your application silently.

Check start_log.txt if any issues occur during the process.

🛡️ Safety & Security
Root Protection: Built-in safeguards prevent accidental deletion of critical system directories (e.g., Windows, Program Files, Users).

Atomic Operations: Uses temporary batch execution to prevent file-in-use conflicts during runtime.

📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

✍️ Author
Charles Nextime Passionate about portable software and automation.
