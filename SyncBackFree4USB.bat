@echo off
setlocal EnableDelayedExpansion

rem =======================================================================
rem  Portable Project: Universal Launcher Core Suite (ULC)
rem  ----------------------------------------------------------------------
rem  Component: [Entry Loader / 外部引導器]
rem  This script enters the app directory and triggers the silent launcher.
rem  本腳本負責進入程式目錄並觸發靜默啟動器。
rem =======================================================================

rem --- [Configuration / 設定區] ---
rem Target directory name / 程式所在資料夾名稱
set "RunPath=SyncBackFree"
rem Silent launcher filename / 靜默啟動檔名
set "RunVBS=0start.vbs"
rem ------------------------------

rem 1. Define drive letter for portable use (e.g., E:)
rem 1. 定義隨身碟磁碟代號，方便後續環境變數調用
set "MyDrive=%~d0"
set "MY_DRIVE=%MyDrive%"
set "USB=%MyDrive%"

rem 2. Enter the target application directory
rem 2. 進入目標資料夾
if exist "%~dp0%RunPath%" (
    cd /d "%~dp0%RunPath%"
) else (
    echo [Error] Target directory not found: %RunPath%
    echo [錯誤] 找不到目標目錄: %RunPath%
    pause & exit
)

rem 3. Execute VBS via 'start' to ensure the CMD window closes instantly
rem 3. 使用 start 執行 VBS，確保此黑視窗在呼叫後立即關閉
if exist "%RunVBS%" (
    start "" "%RunVBS%"
) else (
    echo [Error] Cannot find silent launcher: %RunVBS%
    echo [錯誤] 找不到靜默啟動檔案: %RunVBS%
    pause & exit
)

exit