@echo off
setlocal EnableDelayedExpansion

rem =======================================================================
rem  Portable Project: Universal Launcher Core Suite (ULC)
rem  ----------------------------------------------------------------------
rem  Component: [ULC Lite Deployment Tool / 部署工具]
rem  Function: Distribute core scripts and rename INI files automatically
rem            自動分發核心腳本並重命名 INI 檔案
rem  Copyright (c) 2026 Charles Nextime
rem  Licensed under the GNU General Public License v3.0
rem =======================================================================

:: [Config / 設定區]
:: Target root directory / 目標根目錄
set "DestRoot=D:\portable"

:: Core components / 核心組件檔案
set "CoreVBS=0start.vbs"
set "CoreBAT=start.bat"
set "ConfigPath=config"

echo [%date% %time%] Starting deployment / 開始部署作業...
echo ----------------------------------------------------
echo Core Launcher  / 前導程式名 : %CoreBAT%
echo Target Root    / 目標根目錄 : %DestRoot%
echo Config Folder  / 設定檔目錄 : %ConfigPath%

:: 1. Check if core components exist / 檢查核心組件是否存在
if not exist "%CoreVBS%" (
    echo [Error] Cannot find %CoreVBS%
    echo [錯誤] 找不到 %CoreVBS%
    pause & exit
)
if not exist "%CoreBAT%" (
    echo [Error] Cannot find %CoreBAT%
    echo [錯誤] 找不到 %CoreBAT%
    pause & exit
)
if not exist "%ConfigPath%\" (
    echo [Error] Cannot find config directory
    echo [錯誤] 找不到 config 目錄
    pause & exit
)

rem Scan for config files / 列出待處理清單
set "FullList="
for %%F in (%ConfigPath%\*.ini) do (
    if "!FullList!"=="" (
        set "FullList=%%~nxF"
    ) else (
        set "FullList=!FullList! %%~nxF"
    )
)

echo Files found / 找到清單: !FullList!
echo ----------------------------------------------------------
echo Please confirm the data above / 請確認以上部署資料
echo.
pause
echo.

:: 2. Iterate through all .ini files in config folder / 遍歷 config 資料夾下所有 .ini
for %%F in (config\*.ini) do (
    set "ProgName=%%~nF"
    set "TargetDir=%DestRoot%\!ProgName!"
    
    echo Deploying / 正在部署: !ProgName!
    
    :: Create target directory if not exists / 建立目標目錄
    if not exist "!TargetDir!" (
        mkdir "!TargetDir!"
        echo    - Directory created / 已建立目錄: !TargetDir!
    )
    
    :: A. Copy and rename INI to start.ini / 複製並重命名 INI 為 start.ini
    copy /y "%%F" "!TargetDir!\start.ini" >nul
    echo    - [OK] Config / 設定檔: %%~nxF -^> start.ini
    
    :: B. Copy Core VBS / 複製核心 VBS
    copy /y "%CoreVBS%" "!TargetDir!\" >nul
    echo    - [OK] Core component / 核心組件: %CoreVBS%
    
    :: C. Copy Core BAT / 複製核心 BAT
    copy /y "%CoreBAT%" "!TargetDir!\" >nul
    echo    - [OK] Core component / 核心組件: %CoreBAT%
    
    echo ----------------------------------------------------
)

echo Deployment completed / 部署完成！
pause