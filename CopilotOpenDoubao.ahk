;server 1.0.1

#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn
#ClipboardTimeout 1000

; 配置参数
ChromePath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
TargetURL := "https://www.doubao.com/chat"
UrlKeyword := "doubao.com/chat"

; 热键：Win+Shift+F23
#++F23:: {
    if !FileExist(ChromePath) {
        MsgBox("Chrome路径错误`n当前路径：" ChromePath, "错误", 0x10)
        return
    }

    ; 优先激活已有chat页
    if (chatWin := FindChatTabSilent()) {
        ActivateChatTab(chatWin)
        return
    }

    ; 无chat页但有Chrome窗口：用Chrome命令行直接在现有窗口打开chat页
    if (existingChrome := GetAnyChromeWindow()) {
        Run('"' ChromePath '" --new-tab ' TargetURL)
        Sleep(1000) ; 等待页面加载
        return
    }

    ; 无任何Chrome窗口：新建窗口打开chat页（已去掉居中功能）
    Run(ChromePath ' --new-window ' TargetURL)
    if (newWin := WinWait("ahk_exe chrome.exe",, 5)) {
        WinActivate("ahk_id " newWin)
    } else {
        MsgBox("Chrome启动失败", "提示", 0x40)
    }
}

; 静默查找chat标签页
FindChatTabSilent() {
    chromeWins := WinGetList("ahk_exe chrome.exe",, "Chrome_WidgetWin_1")
    for winId in chromeWins {
        if !WinExist("ahk_id " winId)
            continue
        
        WinActivate("ahk_id " winId)
        Sleep(100)
        
        winTitle := WinGetTitle("ahk_id " winId)
        if InStr(winTitle, "豆包", false) || InStr(winTitle, UrlKeyword, false) {
            return winId
        }
        
        Send "^{Tab}"
        Sleep(100)
        winTitle := WinGetTitle("ahk_id " winId)
        if InStr(winTitle, "豆包", false) || InStr(winTitle, UrlKeyword, false) {
            return winId
        }
        Send "^1"
        Sleep(50)
    }
    return 0
}

; 激活chat标签页
ActivateChatTab(winId) {
    if WinGetMinMax(winId) = -1 {
        WinRestore("ahk_id " winId)
    }

    WinActivate("ahk_id " winId)
    DllCall("User32.dll\SetForegroundWindow", "UInt", winId, "UInt")
    
    ; 临时置顶
    DllCall("User32.dll\SetWindowPos"
        , "UInt", winId, "Int", -1, "Int", 0, "Int", 0, "Int", 0, "Int", 0
        , "UInt", 0x0002 | 0x0001)
    SetTimer(() => DllCall("User32.dll\SetWindowPos"
        , "UInt", winId, "Int", -2, "Int", 0, "Int", 0, "Int", 0, "Int", 0
        , "UInt", 0x0002 | 0x0001), -1000)
}

; 获取任意Chrome窗口
GetAnyChromeWindow() {
    chromeWins := WinGetList("ahk_exe chrome.exe",, "Chrome_WidgetWin_1")
    for winId in chromeWins {
        if WinExist("ahk_id " winId) {
            return winId
        }
    }
    return 0
}
