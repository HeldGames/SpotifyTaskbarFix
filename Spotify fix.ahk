;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
;OPTIMIZATIONS END

DetectHiddenWindows, On
SetTitleMatchMode, 2

TestFull:=
Stop:= false
SpotifyWasMin:=false

loop
	{
		ifWinExist, Spotify Premium ;Is Spotify open?
			{
				WinGet, TempID, ID , Spotify Premium ;Get SpotifyID
				if (TempID != NULL and Stop != true) ;Do we have an ID and stop from looping
					{
						SpotifyID:=TempID
						WinGet,SpotifyMin, MinMax, ahk_id %SpotifyID% ;Get Minimize/maximized status of Spotify
						if (SpotifyMin = -1) ;-1 = Minimized
							{
								SpotifyWasMin := true
							}
						if (SpotifyWasMin = true)
							{
								WinRestore, ahk_id %SpotifyID%, ;Unminimize Spotify
							}
						WinGetPos, SpotifyX, SpotifyY, , , ahk_id %SpotifyID% ;Get current location of Spotify
						WinMove, ahk_id %SpotifyID%, , 1000, 1000 ;Move it to main window
						WinMove, ahk_id %SpotifyID%, , %SpotifyX%, %SpotifyY% ;Move it back
						if (SpotifyWasMin = true)
							{
								WinMinimize, ahk_id %SpotifyID% ;If it was minimized before then reminimize window
							}
						Stop:=true ;Prevent loop
						SpotifyWasMin:=false ;Prevent loop issues
					}
			}
		ifWinNotExist, ahk_id %SpotifyID%
			{
				Stop:=false
			}
	}
