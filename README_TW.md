# 萬用軟體啟動器核心 (Universal Launcher Core Suite)

`[English](README.md)`
   
這是一個專業、輕量且完全綠色化的 Windows 批次檔啟動核心。透過 ULC，您可以管理登錄檔、檔案同步以及目錄掛載 (Junction)，確保您喜愛的軟體在不停留任何痕跡於主機系統的前提下，實現真正的隨身攜帶。



## 🚀 核心特色

* **雙重儲存模式**：支援「實體檔案同步」與 **MkLinkJ (目錄連接點)** 掛載模式，針對大量資料讀取提供高效能解決方案。
* **登錄檔可攜化**：自動備份、還原並在關閉時清理 Windows 登錄檔鍵值。
* **動態指令鏈**：支援在主程式啟動前後執行多組自定義指令（使用 `|` 符號分隔）。
* **強健的進程監控**：主動監控程式狀態，確保所有背景「殭屍進程」在備份前皆已關閉。
* **安全清理機制**：內建 5 次強制刪除重試邏輯，解決檔案被鎖定導致的清理失敗，保護隱私。
* **透明化日誌**：詳細記錄執行過程 (`start_log.txt`)，包含系統錯誤訊息，方便排查問題。

## 📂 專案結構

```text
.
├── 0start.vbs           # 靜默啟動器 (防止彈出黑色的 CMD 視窗)
├── start.bat            # 啟動器核心引擎 (批次檔)
├── start.ini            # 核心設定檔
└── MyData/              # 可攜式資料儲存區 (自動產生)
    ├── C/               # 模擬 C 槽的檔案路徑
    └── Registry.reg     # 登錄檔備份
```

⚙️ 設定說明 (start.ini)
啟動器的所有行為皆由 start.ini 控制，以下為設定範例：
```text
[Config]
; 執行檔路徑
RunExe=App\Software.exe
; 監控的進程名稱
ExeTaskName=Software.exe
; 使用掛載模式 (1) 或 實體同步 (0)
MkLinkJ=1
; 啟動模式: 被動等待 (1: start /wait) 或 主動監控 (0: loop monitor)
StartWait=0
; 開啟除錯模式 (1: 開啟, 0: 關閉)
Debug=0

[SaveList]
; 需要持久化的資料夾或檔案
%AppData%\SoftwareName
%LocalAppData%\SoftwareName\settings.xml

[RegList]
; 需要持久化的登錄檔鍵值
HKEY_CURRENT_USER\Software\SoftwareVendor

[KillList]
; 關閉軟體後需強制結束的背景程序
SoftwareUpdater.exe

[BeforeCMDList]
; 啟動前執行的指令 (使用 | 分隔)
md temp_work | del /f /q old_cache.tmp

[AfterCMDList]
; 關閉後執行的指令
rd /s /q temp_work
```
🛠️ 開始使用
將 0start.vbs、start.bat 與 start.ini 放置於軟體根目錄。

根據需求設定 start.ini 中的路徑與登錄檔鍵值。

執行 0start.vbs 即可靜默啟動您的軟體。

若遇到問題，請查看 start_log.txt 取得詳細錯誤資訊。

🛡️ 安全性建議
系統根目錄保護：內建防誤刪機制，禁止對 Windows、Program Files、Users 等核心目錄進行寫入或清理動作。

原子化操作：使用臨時批次檔執行技術，避免執行期間發生檔案佔用衝突。

編碼提醒：若 INI 內含有中文路徑，請務必將檔案儲存為 UTF-8 with BOM 編碼。

📜 授權條款
本專案採用 MIT License 授權 - 詳情請參閱 LICENSE 檔案。

✍️ 作者
Charles Nextime 熱衷於軟體綠色化與自動化腳本開發。
