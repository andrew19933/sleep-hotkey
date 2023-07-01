; This script allows me to put the computer to quickly put the computer
; to sleep with a keyboard shortcut.
;
; Written April 2021
; Updated to work with AHKv2 in July 2023


#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.


; Win + s
#s::
{
	; build the confirmation box
	confirmation_box := Gui(, "Sleep?")
	confirmation_box.Add("Text", , "Put the computer to sleep?")
	confirmation_box.OnEvent("Escape", confirmation_box.Destroy)
	confirmation_box.OnEvent("Close", confirmation_box.Destroy)
	confirmation_box.Add("Button", "Default w80", "Yes").OnEvent("Click", GoToSleep)
	confirmation_box.Add("Button", "w80", "No").OnEvent("Click", NoSleep)
	confirmation_box.Show("Center")
	
	; Puts computer to sleep
	GoToSleep(*) {
		confirmation_box.Destroy()
		DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0)
		return
	}

	; don't put the computer to sleep
	NoSleep(*) {
		confirmation_box.Destroy()
		return
	}
}
