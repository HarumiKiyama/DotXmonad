import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops(ewmh)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar.PP
import System.IO
import XMonad.Config.Desktop
import XMonad.Actions.SpawnOn



web = "web"
code = "code"
term = "terminal"
myWorkspaces = [web, code, term] ++ map show [4..9]

main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad $ ewmh desktopConfig {
    startupHook = do
      spawnOn web "google-chrome-stable"
      spawnOn code "emacs"
      spawnOn term "alacritty"
      spawnOnce "fcitx5"
      spawnOnce "udiskie"
      spawnOnce "nitrogen --set-zoom-fill /home/harumi/Desktop/alice.jpg --head=0"
      spawnOnce "nitrogen --set-zoom-fill /home/harumi/Desktop/alice.jpg --head=1"
      setWMName "LG3D"
    ,terminal = "alacritty"
    ,modMask = mod4Mask
    ,workspaces = myWorkspaces
    ,manageHook = manageSpawn
    ,logHook =  dynamicLogWithPP xmobarPP {
              ppOutput = hPutStrLn xmproc
             ,ppExtras = []
             ,ppOrder = \(ws:_) -> [ws]
    }
  } `additionalKeys` [
        ((mod4Mask, xK_p), spawn "rofi -show drun")
    ]
