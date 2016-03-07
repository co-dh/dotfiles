import XMonad
import XMonad.Util.EZConfig(additionalKeys)

main = xmonad $ defaultConfig
	{ borderWidth        = 1
	, normalBorderColor  = "#cccccc"
	, modMask = mod4Mask
	, focusedBorderColor = "#ee2200"
        , terminal = "gnome-terminal"
        } `additionalKeys`
        [ ((mod4Mask , xK_r), spawn "rc"),
          ((mod4Mask , xK_g), spawn "google-chrome"),
          ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l"),
          ((mod4Mask .|. shiftMask, xK_e), spawn "emacs"),
          ((mod4Mask .|. shiftMask, xK_s), spawn "subl")
          ]
