#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPI.au3>
#include <Misc.au3>
#include <EditConstants.au3>

#Region
	#AutoIt3Wrapper_Icon = ./settings.ico
#EndRegion

#Region ### START Koda GUI section ### Form=
Global $FormMain = GUICreate("Window Tool - By Duy Minh", 425, 232, -1, -1, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
GUISetIcon(".\Image\settings.ico", -1)
Global $GroupWindowName = GUICtrlCreateGroup("Finder Tool", 8, 8, 78, 78, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
Global $ButtonFind = GUICtrlCreateButton("+", 20, 24, 50, 50, $BS_ICON)
GUICtrlSetFont(-1, 15, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0x808080)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $LabelOpacity = GUICtrlCreateLabel("Opacity", 96, 22, 40, 17)
Global $SliderOpacity = GUICtrlCreateSlider(136, 22, 222, 21)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, 255)
Global $CheckboxSetOnTop = GUICtrlCreateCheckbox("Place the window on top", 96, 61, 153, 17)
Global $LabelOpacityNumber = GUICtrlCreateLabel("255", 16, 96, 93, 17)
Global $LabelClassWindow = GUICtrlCreateLabel("...", 120, 96, 277, 17)
Global $GroupWindowSize = GUICtrlCreateGroup("Window Size", 8, 128, 209, 89)
Global $LabelHeight = GUICtrlCreateLabel("Height", 24, 153, 35, 17)
Global $InputHeight = GUICtrlCreateInput("", 61, 150, 65, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
Global $InputWidth = GUICtrlCreateInput("", 61, 184, 65, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
Global $ButtonOk = GUICtrlCreateButton("OK", 136, 150, 65, 57)
Global $LabelWidth = GUICtrlCreateLabel("Width", 24, 188, 32, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Group1 = GUICtrlCreateGroup("Window Title", 224, 128, 177, 89)
Global $LabelTitle = GUICtrlCreateLabel("Title:", 232, 152, 27, 17)
Global $InputTitle = GUICtrlCreateInput("", 259, 149, 129, 21)
Global $ButtonSetTitle = GUICtrlCreateButton("Set Title", 256, 184, 137, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ButtonFind
			While True
				If _IsPressed("01") Then
					Global $handle = _WinAPI_GetForegroundWindow()
					Global $class = _WinAPI_GetClassName($handle)
					GUICtrlSetData($LabelClassWindow,$class)

					Global $title = WinGetTitle("[Class:" & $class & "]")
					GUICtrlSetData($InputTitle,$title)

					Global $pos = WinGetPos("[Class:" & $class & "]")
					If GUICtrlRead($LabelClassWindow) Then
						GUICtrlSetData($InputHeight,$pos[3])
						GUICtrlSetData($InputWidth,$pos[2])
						ExitLoop
					EndIf

				EndIf
			WEnd
		Case $SliderOpacity
			Global $value = GUICtrlRead($SliderOpacity)
			GUICtrlSetData($LabelOpacityNumber,$value)
			WinSetTrans("[Class:" & $class & "]",'',$value)
		Case $CheckboxSetOnTop
			If GUICtrlRead($CheckboxSetOnTop) == $GUI_CHECKED  Then
				WinSetOnTop("[Class:" & $class & "]",'',1)
			Else
				WinSetOnTop("[Class:" & $class & "]",'',0)
			EndIf
		Case $ButtonOk
			Local $height = GUICtrlRead($InputHeight)
			Local $width = GUICtrlRead($InputWidth)
			WinMove("[CLASS:" & $class & "]",'',0,0,$width,$height)
		Case $ButtonSetTitle
			Local $title = GUICtrlRead($InputTitle)
			Local $titleWindow = WinGetTitle("[CLASS:" & $class & "]")
			WinSetTitle("[CLASS:" & $class & "]",'',$title)
			If $title == $titleWindow  Then
				MsgBox(16+262144,"Window Tool","Failed, Please try again!",0,$FormMain)

			EndIf
	EndSwitch

WEnd
