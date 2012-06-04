-- Default from 
-- http://haskell.org/haskellwiki/Xmonad/Config_archive/Template_xmonad.hs_(0.9)
import XMonad
import Data.Monoid
import System.Exit
import Graphics.X11.ExtraTypes.XF86

import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W
import qualified Data.Map        as M



--DEFAULT BINDINGS--
{-
--KEY BINDINGS--
defKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
       
  --Launch terminal                                          mod-shift-return
  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.termial conf),
  
  --Launch dmenu                                             mod-p
  ((modm, xK_p),                    spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\""),
  
  --Launch gmrun                                             mod-shift-p
  ((modm .|. shiftMask, xK_p),      spawn "gmrun"),
  
  --Close the focused window                                 mod-shift-c
  ((modm .|. shiftMask, xK_c),      kill),
  
  --Rotate through the available layout algorithms           mod-space
  ((modm, xK_space),                sendMessage NextLayout),
  
  --Reset the layouts on the current workspace to default    mod-shift-space
  ((modm .|. shiftMask, xK_space),  setLayout $ XMonad.layoutHook conf),
  
  --Resize viewed windows to the correct size                mod-n  
  ((modm, xK_n),                    refresh),
  
  --Move focus to the next window                            mod-tab
  ((modm, xK_Tab),                  windows W.focusDown),
  
  --Move focus to the previous window                        mod-shift-tab
  ((modm .|. shiftMask, xK_Tab),    windows W.focusUp),
  
  --Move focus to the next window                            mod-j
  ((modm, xK_j),                    windows W.focusDown),
  
  --Move focus to the previous window                        mod-k
  ((modm, xK_k),                    windows W.focusUp),
  
  --Move focus to the master window                          mod-m
  ((modm, xK_m),                    windows W.focusMaster),
  
  --Swap the focused window and the master window            mod-return
  ((modm, xK_Return),               windows W.swapMaster),
  
  --Swap the focused window with the next window             mod-shift-j
  ((modm .|. shiftMask, xK_j),      windows W.swapDown),
  
  --Swap the focused window with the previous window         mod-shift-k
  ((modm .|. shiftMask, xK_k),      windows W.swapUp),
  
  --Shrink the master area                                   mod-h
  ((modm, xK_h), sendMessage Shrink),
  
  --Expand the master area                                   mod-l
  ((modm, xK_l), sendMessage Expand),
  
  --Push window back into tiling                             mod-t
  ((modm, xK_t), withFocused $ windows . W.sink),
  
  --Increment the number of windows in the master area       mod-comma
  ((modm, xK_comma), sendMessage (IncMasterN 1)),
  
  --Deincrement the number of windows in the master area     mod-period
  ((modm, xK_period), sendMessage (IncMasterN (-1))),
  
  --Toggle the status bar gap                                mod-b
  --  Use this binding with avoidStruts from Hooks.ManageDocks.
  --  See also the statusBar function from Hooks.DynamicLog.
  --
  -- ((modm, xK_b), sendMessage ToggleStruts),
  
  --Quit xmonad                                              mod-shift-q
  ((modm .|. shiftMask, xK_q), io (exitWith ExitSucces)),
  
  --Restart xmonad                                           mod-q
  ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
  ]
  ++
  
  --Switch to workspace N                                    mod-[1..9]
  --Move client to workspace N                               mod-shift-[1..9]
  [((m .|. modm, k), windows $ f i)
   | (i, k) <- zip (XMonad.workspaces conf) [xK_0 .. xK_9]
   , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++
  
  --Switch to physical/Xinerama screens 1, 2, or 3           mod-{w,e,r}
  --Move client to screen 1, 2, or 3                         mod-shift-{w,e,r}
  [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
   | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
   , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  
  

















  
  
--MOUSE BINDINGS--
defMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $ [
  --Set the window to floating mode and move by dragging     mod-button1
  ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                   >> windows W.shiftMaster)),
  
  --Raise the window to the top of the stack                 mod-button2
  ((modm, button2), (\w -> focus w >> windofs W.shiftMaster)),
  
  --Set the window to floating mode and resize by dragging   mod-button3
  ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                   >> windows W.shiftMaster))
  -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]
  
-}


--KEY BINDINGS--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
  {-
  --Volume
  ("XF86AudioRaiseVolume", spawn "amixer set Master 5+%"),
  ("XF86AudioLowerVolume", spawn "amixer set Master 5-%"),
  ("XF85AudioMute"       , spawn "amixer set Master toggle")
  -}
  
  --Volume
  ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 1+"),
  ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 1-"),
  ((0, xF86XK_AudioMute), spawn "amixer -q  set Master toggle"),
  
  --Launch terminal                                          mod-shift-return
  ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
  
  --Launch dmenu                                             mod-p
  --((modm, xK_p),                    spawn "dmenu_run"),
  ((modm, xK_p),                    spawn "exec /home/pilen/.menu.sh"),

  --Launch gmrun                                             mod-shift-p
  ((modm .|. shiftMask, xK_p),      spawn "gmrun"),
  
  --Close the focused window                                 mod-shift-c
  ((modm .|. shiftMask, xK_c),      kill),
  
  --Rotate through the available layout algorithms           mod-space
  ((modm, xK_space),                sendMessage NextLayout),
  
  --Reset the layouts on the current workspace to default    mod-shift-space
  ((modm .|. shiftMask, xK_space),  setLayout $ XMonad.layoutHook conf),
  
  --Resize viewed windows to the correct size                mod-n  
  ((modm, xK_n),                    refresh),
  
  --Move focus to the next window                            mod-tab
  ((modm, xK_Tab),                  windows W.focusDown),
  
  --Move focus to the previous window                        mod-shift-tab
  ((modm .|. shiftMask, xK_Tab),    windows W.focusUp),
  
  --Move focus to the next window                            mod-j
  ((modm, xK_j),                    windows W.focusDown),
  
  --Move focus to the previous window                        mod-k
  ((modm, xK_k),                    windows W.focusUp),
  
  --Move focus to the master window                          mod-m
  ((modm, xK_m),                    windows W.focusMaster),
  
  --Swap the focused window and the master window            mod-return
  ((modm, xK_Return),               windows W.swapMaster),
  
  --Swap the focused window with the next window             mod-shift-j
  ((modm .|. shiftMask, xK_j),      windows W.swapDown),
  
  --Swap the focused window with the previous window         mod-shift-k
  ((modm .|. shiftMask, xK_k),      windows W.swapUp),
  
  --Shrink the master area                                   mod-h
  ((modm, xK_h), sendMessage Shrink),
  
  --Expand the master area                                   mod-l
  ((modm, xK_l), sendMessage Expand),
  
  --Push window back into tiling                             mod-t
  ((modm, xK_t), withFocused $ windows . W.sink),
  
  --Increment the number of windows in the master area       mod-comma
  ((modm, xK_comma), sendMessage (IncMasterN 1)),
  
  --Deincrement the number of windows in the master area     mod-period
  ((modm, xK_period), sendMessage (IncMasterN (-1))),
  
  --Toggle the status bar gap                                mod-b
  --  Use this binding with avoidStruts from Hooks.ManageDocks.
  --  See also the statusBar function from Hooks.DynamicLog.
  --
  -- ((modm, xK_b), sendMessage ToggleStruts),
  
  --Quit xmonad                                              mod-shift-q
  ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
  
  --Restart xmonad                                           mod-q
  ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
  ]
  ++
  
  --Switch to workspace N                                    mod-[1..9]
  --Move client to workspace N                               mod-shift-[1..9]
  [((m .|. modm, k), windows $ f i)
   | (i, k) <- zip (XMonad.workspaces conf) [xK_0 .. xK_9]
   , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++
  
  --Switch to physical/Xinerama screens 1, 2, or 3           mod-{w,e,r}
  --Move client to screen 1, 2, or 3                         mod-shift-{w,e,r}
  [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
   | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
   , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
  
  
  
  
--MOUSE BINDINGS--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $ [
  --Set the window to floating mode and move by dragging     mod-button1
  ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                   >> windows W.shiftMaster)),
  
  --Raise the window to the top of the stack                 mod-button2
  ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
  
  --Set the window to floating mode and resize by dragging   mod-button3
  ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                   >> windows W.shiftMaster))
  -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]
  
main = xmonad $ defaultConfig {
  -- Simple
  terminal         = "urxvtc",
  workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
  -- Visuals
  borderWidth        = 1,
  normalBorderColor  = "#000000",
  focusedBorderColor = "#aa0000",
  
  -- Key bindings
  modMask = mod4Mask, --Set win as mod key
  keys = myKeys,
  mouseBindings = myMouseBindings,
                  
                  
  layoutHook = smartBorders $ layoutHook  defaultConfig
  }
