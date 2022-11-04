import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

main :: IO ()
main = xmonad $ def
  { modMask = mod4Mask}
  `additionalKeysP`
  [ ("M-q", spawn "rofi -show run")
  , ("M-S-q", kill)]
