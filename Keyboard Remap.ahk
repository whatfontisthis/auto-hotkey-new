; ---------- CapsLock → ENG/KR toggle ----------
CapsLock:: {
    Send "{VK15}"   ; Hangul/English toggle
}

; ---------- Right Alt → real Caps Lock ----------
SC138:: {           ; Right Alt physical key
    SetCapsLockState !GetKeyState("CapsLock", "T")
}


; ----------DISABLE WINDOWS Hotkeys----------
;#i::return ; system settings
#w::return ; pen settings
#c::return ; cortana/copilot
#p::return ; monitor settings
#+::return ; zoom
#a::return ; notification sidebar
#f::return ; feedback hub
;#r::return ; run dialog
;#g::return ; Game Bar Xbox -> disabled in regedit
;#l::return ; sign out -> disabled in regedit
#k::return ; Connect
#v::return ; Clipboard history
#.::return ; Emojis
#,::return ; show open windows transparent


; ----------Open Downloads Folder----------
#j::
{
    downloadsPath := A_UserName "\Downloads"  ; C:\Users\[YourName]\Downloads
    fullPath := "C:\Users\" downloadsPath
    winSpec := "ahk_class CabinetWClass ahk_exe explorer.exe"  ; Explorer windows
    
    ; Check if Downloads Explorer window exists
    if WinExist("Downloads - " winSpec) || WinExist(fullPath " - " winSpec) {
        WinActivate  ; Focus existing Downloads window
        return
    }
    
    ; Open new Explorer window to Downloads
    Run 'explorer.exe "' fullPath '"'
    
    ; Wait & activate if appears
    if WinWait("ahk_class CabinetWClass ahk_exe explorer.exe", , 3) {
        WinActivate
    }
}


; ----------Open NotebookLM Chrome App----------
#l::
{
    appUrl := "https://notebooklm.google.com"
    chromePath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
    winSpec := "ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe"
    
    ; Check if NotebookLM window exists
    if WinExist("NotebookLM ahk_class Chrome_WidgetWin_1") {
        WinActivate  ; Focus existing NotebookLM window
        return
    }
    
    ; Open new Chrome window to NotebookLM
    Run '"' chromePath '" "' appUrl '"'
    
    ; Wait & activate if appears
    if WinWait("NotebookLM ahk_class Chrome_WidgetWin_1", , 3) {
        WinActivate
    }
}




F6::
{
    ; Ensure ToolTip stays in the bottom-right of the center (primary) monitor
    CoordMode "ToolTip", "Screen"

    ; Configuration
    SVV := "C:\Users\user\Documents\AutoHotkey\SoundVolumeView.exe"
    Device1 := "Realtek HD Audio 2nd output"
    Device2 := "iLoud Micro-Monitor"

    ; 1. Perform the switch
    RunWait(SVV ' /SwitchDefault "' Device1 '" "' Device2 '" 1')
    
    ; 2. Audio Feedback (Choose one)
    SoundBeep(750, 500)        ; Standard Beep (Frequency: 750Hz, Duration: 150ms)
    ; SoundPlay("*64")         ; Optional: Modern Windows "Information" chime
    
    ; 3. Visual Feedback
    PosX := A_ScreenWidth - 150
    PosY := A_ScreenHeight - 80
    ToolTip("🔊 Audio Switched", PosX, PosY) 
    
    SetTimer () => ToolTip(), -1000
}