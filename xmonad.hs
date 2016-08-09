import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.ResizableTile


myLayout = ResizableTall 1 (3/100) (1/2) []


main = xmonad $ defaultConfig
	{ borderWidth        = 1
	, normalBorderColor  = "#cccccc"
	, modMask = mod4Mask
	, focusedBorderColor = "#ee2200"
        , terminal = "gnome-terminal"
	--, layoutHook = myLayout
        } `additionalKeys`
        [ ((mod4Mask , xK_r), spawn "rc")
	,((mod4Mask , xK_g), spawn "google-chrome")
	,((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
	,((mod4Mask .|. shiftMask, xK_e), spawn "emacs")
	,((mod4Mask .|. shiftMask, xK_s), spawn "subl")
	, ((mod4Mask, xK_a), sendMessage MirrorShrink)
	, ((mod4Mask, xK_z), sendMessage MirrorExpand)
	]
