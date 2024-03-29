-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import           XMonad
import           XMonad.Layout.Gaps
import           XMonad.Util.EZConfig
import           XMonad.Util.Ungrab
--Data

import           Data.Maybe                   (fromJust, isJust)
import           Data.Monoid
import           Data.Ratio

--

import           System.Exit
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

--Hooks

import           XMonad.Hooks.DynamicLog      (PP (..), dynamicLogWithPP, pad,
                                               shorten, shorten', wrap)
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers   (doCenterFloat, doFullFloat,
                                               isFullscreen)
import           XMonad.Hooks.EwmhDesktops

--Actions
import           XMonad.Actions.CycleWS
import           XMonad.Actions.FloatKeys
import           XMonad.Actions.FloatSnap
import           XMonad.Actions.UpdatePointer
import           XMonad.Actions.WorkspaceNames
import           XMonad.Actions.WorkspaceCursors


--Layouts
import           System.IO
import           XMonad.Layout.Grid           (Grid (..))
import           XMonad.Layout.Magnifier
import           XMonad.Layout.Renamed
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Spacing
import           XMonad.Layout.Spiral
import           XMonad.Layout.Tabbed
import           XMonad.Layout.ThreeColumns

import qualified Data.Map                     as M
import qualified DBus.Client                  as DC
import qualified XMonad.DBus                  as D
import qualified XMonad.StackSet              as W


-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = map show [1..9]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#585b70"
-- myFocusedBorderColor = "#cba6f7"
myFocusedBorderColor = "#e5a630"
myFocusedFullScreenColor = "#bd2a17"
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm , xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((modm,               xK_q     ), spawn "/home/shastro/.config/rofi/launchers/type-2/launcher.sh")

    -- launch qutebrowser
    , ((modm,               xK_b     ), spawn "brave")

    -- toggle news
    , ((modm .|. shiftMask, xK_n    ), spawn "/home/shastro/bin/toggle_news")

    -- Volume controls
    , ((modm,               xK_z     ), spawn "pulsemixer --toggle-mute")
    , ((modm,               xK_x     ), spawn "pulsemixer --change-volume -5")
    , ((modm,               xK_c     ), spawn "pulsemixer --change-volume +5")

    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modm , xK_f ), sendMessage $ JumpToLayout "Full")

    , ((modm .|. shiftMask, xK_f ), sendMessage $ JumpToLayout "Tall")

    -- Resize viewed windows to the correct size
    , ((modm,               xK_r     ), renameWorkspace def)

    -- Move focus to the next window
    , ((modm,               xK_e     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_i     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_s), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_e     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_i     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_n     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_o     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_k     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. controlMask , xK_q     ), spawn "xmonad --recompile; pkill xmobar; xmonad --restart")


    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- Moving to next windows
    , ((modm , xK_Right), moveTo Next (Not emptyWS))
    , ((modm , xK_Left), moveTo Prev (Not emptyWS))
    , ((modm .|. shiftMask , xK_Right), moveTo Next emptyWS)
    , ((modm .|. shiftMask , xK_Left), moveTo Prev emptyWS)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_l, xK_u, xK_y] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
rPad = 15
myLayout = avoidStruts (
  -- gaps [(D,rPad), (L,rPad), (U,rPad), (R,rPad)] $
  spacing 7 $
  tiled ||| Full ||| Grid ||| spiral (0.856))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

     -- gaps = [(U,20), (R,10)]
------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--    -- Override the PP values as you would like (see XMonad.Hooks.DynamicLog documentation)
myLogHook :: DC.Client -> PP
myLogHook dbus = def {
  -- ppCurrent = const "§",
  ppCurrent = const "%{F#bdae2b}■%{F-}",
  -- ppCurrent = wrap "[" "]",
  ppWsSep = " ",
  ppHiddenNoWindows = const "·",
  ppSep = " ",
  ppVisible = const "%{F#316585}■%{F-}",  
  -- ppRename = idc,
  ppHidden = const "¤",
  -- ppVisible = \x -> "",
  ppTitle = const "",
  ppLayout  = (\l -> case l of
     "Spacing Tall"            -> "n"
     "Spacing Mirror Tall"     -> "[=]"
     "Spacing Full"            -> "%{F#bd2a17}f%{F-}"
     "Spacing Tabbed Simplest" -> "[_]"
     "Spacing Grid"            -> "g"
     "Spacing SimplestFloat"   -> "[^]"
     "Spacing Magnifier Tall"  -> "[0]"
     "Spacing Spiral"          -> "sp"
   ),
  ppOutput = D.send dbus
  }
-- myLogHook dbus = def { ppOutput = D.send dbus }
--   { ppTitle   = xmobarColor "#89b4fa" "" . shorten 60
  --, ppCurrent = xmobarColor "#f38ba8" "" . wrap
  --    ("<box type=Bottom width=2 mb=2 color=#585b70>") "</box>"
  -- , ppCurrent =  xmobarColor "#cba6f7" "" . wrap """"
  -- , ppHidden  = xmobarColor "#6c7086" "" . wrap """"
  -- , ppVisible  = xmobarColor "#6c7086" "" . wrap """"
  -- , ppSep =  "<fc=#585b70> | </fc>"
  -- , ppHiddenNoWindows = xmobarColor "#313244"  ""
  -- , ppOutput  = hPutStrLn h . xmobarColor "#a6e3a1" ""
  --, ppLayout = id
  --, ppLayout  = (\l -> case l of
  --    "Spacing Tall"                  -> "[|]"
  --    "Spacing Mirror Tall"           -> "[=]"
  --    "Spacing Full"                  -> "[ ]"
  --    "Spacing Tabbed Simplest"       -> "[_]"
     -- "Spacing Grid"                  -> "[#]"
  --    "Spacing SimplestFloat"         -> "[^]"
  --    "Spacing Magnifier Tall"        -> "[0]"
  --    "Spacing Spiral"                -> "[@]"
  --  )
  -- }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  spawn "picom"
  spawn "/home/shastro/.config/polybar/scripts/setup/start"

------------------------------------------------------------------------
--rNow run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
   -- xmproc <- spawnPipe "xmobar -x 0 /home/sv/.config/xmobar/xmobar.config"
  dbus <- D.connect
-- Request access (needed when sending messages)
  D.requestAccess dbus
  xmonad $ ewmhFullscreen $ ewmh $ docks $ defaults dbus
  -- xmonad $ docks $ def {logHook = dynamicLogWithPP (myLogHook dbus)} $ defaults xmproc
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults h = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook,
        logHook            = updatePointer (0.5,0.5) (0,0) >> dynamicLogWithPP (myLogHook h)
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
