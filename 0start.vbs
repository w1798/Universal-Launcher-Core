Dim objShell, strCommand
Set objShell = WScript.CreateObject("WScript.Shell")

' 傳參數 s 給 start.bat 關掉除錯模式。
' 參數 0 代表隱藏視窗，False 代表不等待 start.bat 結束
' Pass "s" to start.bat to disable debug mode.
' Parameter "0" = Hide window; "False" = Do not wait for execution to finish.

strCommand = "cmd.exe /c start.bat s"
objShell.Run strCommand, 0, False