{-# LANGUAGE NoMonomorphismRestriction #-}

import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.CycleWS
import XMonad.Util.WorkspaceCompare 
import XMonad hiding (Tall)
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys
import XMonad.Hooks.DynamicHooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutCombinators hiding ((|||))
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.Man
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Workspace
import XMonad.Util.Run (spawnPipe)
import Control.Monad (liftM2)
import Data.Monoid
import Graphics.X11
import System.Exit
import System.IO
import XMonad.Actions.TagWindows 
import XMonad.Prompt    -- to use tagPrompt
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ICCCMFocus
import XMonad.Actions.WindowBringer
import qualified XMonad.Actions.FlexibleResize as Flex 
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.CopyWindow(copy)
import XMonad.Actions.FloatKeys
import XMonad.Layout.Grid

myTerminal = "konsole"
myFocusFollowsMouse = True
myBorderWidth = 1
myModMask = mod4Mask
myNumlockMask = mod2Mask

myWorkspaces = [
               "1:", 
               "2:", 
               "3:", 
               "4:", 
               "5:", 
               "6:", 
               "7:", 
               "8:", 
               "9:"
               ]
               
myNormalBorderColor = "#444444"
myFocusedBorderColor = "#0051FF"

myEventHook = mempty
-- myLogHook = dynamicLogWithPP $ myDzenPP dzen
myStartupHook = return ()

myFont = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*"
-- myIconDir = "/home/attila/.dzen/icons"
-- myScriptsDir = "/home/attila/.dzen/scripts"
myDzenFGColor = "#555555"
myDzenBGColor = "#222222"
myNormalFGColor = "#ffffff"
myNormalBGColor = "#0f0f0f"
myFocusedFGColor = "#f0f0f0"
myFocusedBGColor = "#ff0000"
myUrgentFGColor = "#00008b"
myUrgentBGColor = "#00008b"
myIconFGColor = "#777777"
myIconBGColor = "#0f0f0f"
mySeperatorColor = "#555555"

-- XPConfig options:
myXPConfig = defaultXPConfig
    { font = "" ++ myFont ++ ""
    , bgColor = "" ++ myNormalBGColor ++ ""
    , fgColor = "" ++ myNormalFGColor ++ ""
    , fgHLight = "" ++ myNormalFGColor ++ ""
    , bgHLight = "" ++ myUrgentBGColor ++ ""
    , borderColor = "" ++ myFocusedBorderColor ++ ""
    , promptBorderWidth = 1
    , position = Bottom
    , height = 16
    , historySize = 100
    --, historyFilter = ""
    --, promptKeymap = ""
    --, completionKey = ""
    --, defaultText = ""
    --, autoComplete = "KeySym"
    --, showCompletionOnTab = ""
    }

-- Theme options:
myTheme = defaultTheme
    { activeColor = "" ++ myFocusedBGColor ++ ""
    , inactiveColor = "" ++ myDzenBGColor ++ ""
    , urgentColor = "" ++ myUrgentBGColor ++ ""
    , activeBorderColor = "" ++ myFocusedBorderColor ++ ""
    , inactiveBorderColor = "" ++ myNormalBorderColor ++ ""
    , urgentBorderColor = "" ++ myNormalBorderColor ++ ""
    , activeTextColor = "" ++ myFocusedFGColor ++ ""
    , inactiveTextColor = "" ++ myDzenFGColor ++ ""
    , urgentTextColor = "" ++ myUrgentFGColor ++ ""
    , fontName = "" ++ myFont ++ ""
    --, decoWidth = ""
    --, decoHeight = ""
    }

myStatusBar = "dzen2 -x '0' -y '0' -h '16' -w '880' -ta 'l' -fg '" ++ myNormalFGColor ++ "' -bg '" ++ myNormalBGColor ++ "' -fn '" ++ myFont ++ "'"

-- Urgency hint options:
-- myUrgencyHook = withUrgencyHook dzenUrgencyHook
--    { args = ["-x", "500", "-y", "0", "-h", "16", "-w", "255", "-ta", "r", "-expand", "l", "-fg", "" ++ 
-- myUrgentFGColor ++ "", "-bg", "" ++ myNormalBGColor ++ "", "-fn", "" ++ myFont ++ ""] }
 
-- Layouts:
myLayout = smartBorders $ avoidStruts  $ ( Grid ||| tiled ||| Mirror tiled ||| Full)
    where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 2/3
    delta   = 5/100

-- Key bindings:
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ 
    ((mod4Mask, xK_Right ), moveTo Next . WSIs . return $ ("SP" /=) . W.tag)
    , ((mod4Mask, xK_Left ), moveTo Prev . WSIs . return $ ("SP" /=) . W.tag)
    , ((mod4Mask, xK_p ), shellPrompt myXPConfig)
    , ((mod4Mask, xK_m ), manPrompt myXPConfig)
    -- , ((mod4Mask, xK_n ), appendFilePrompt myXPConfig "/home/attila/")
    , ((mod4Mask, xK_w ), windowPromptGoto myXPConfig  )
    , ((mod4Mask .|. shiftMask, xK_w ), windowPromptBring myXPConfig)
    , ((mod4Mask, xK_s ), workspacePrompt myXPConfig (windows . W.shift))
    , ((mod4Mask .|. shiftMask, xK_f), gotoMenu)
    , ((modMask, xK_j), windows W.focusDown)
    , ((modMask, xK_k), windows W.focusUp)
    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modMask, xK_Tab), windows W.focusDown)
    , ((modMask .|. shiftMask, xK_m), windows W.swapMaster) -- swap the focused window and the master window
    , ((modMask, xK_comma), sendMessage (IncMasterN 1))
    , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
    , ((modMask, xK_Return), windows W.focusMaster)
    , ((modMask, xK_space), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_q), io (exitWith ExitSuccess))
    , ((modMask, xK_q), spawn "xmonad --recompile && xmonad --restart")
    , ((modMask, xK_l), sendMessage MirrorExpand)
    , ((modMask, xK_l), sendMessage Expand)
    , ((modMask, xK_h), sendMessage MirrorShrink)
    , ((modMask, xK_h), sendMessage Shrink)
    , ((mod1Mask .|. shiftMask, xK_l), spawn ".dzen/scripts/togglelang")
    , ((modMask .|. shiftMask, xK_c), kill)
    , ((modMask .|. shiftMask, xK_l), spawn "xlock -mode fzort")
    , ((modMask .|. shiftMask, xK_o), spawn "sleep 1 && xset dpms force off")
    , ((modMask .|. shiftMask, xK_Return), spawn "konsole")
    , ((modMask .|. shiftMask .|. controlMask,    xK_Down  ), withFocused (keysResizeWindow (-10,-10) (1,1)) )
    , ((modMask .|. shiftMask .|. controlMask, xK_Up     ), withFocused (keysResizeWindow (10,10) (1,1)))
    , ((modMask .|. controlMask, xK_Left), withFocused (keysMoveWindow (-30,0)))
    , ((modMask .|. controlMask, xK_Right), withFocused (keysMoveWindow (30,0)))
    , ((modMask .|. controlMask, xK_Up), withFocused (keysMoveWindow (0,-30)))
    , ((modMask .|. controlMask, xK_Down), withFocused (keysMoveWindow (0,30)))
    , ((modMask .|. controlMask .|. shiftMask, xK_z), setWMName "LG3D") -- @@ Java hack
    , ((modMask .|. shiftMask, xK_space), withFocused $ windows . W.sink)
    , ((modMask .|. shiftMask, xK_BackSpace), removeWorkspace)
    , ((modMask , xK_t      ), selectWorkspace defaultXPConfig)
    , ((modMask .|. shiftMask, xK_t      ), withWorkspace defaultXPConfig (windows . W.shift))
    , ((modMask .|. controlMask .|. shiftMask, xK_t      ), withWorkspace defaultXPConfig (windows . copy))
    , ((modMask .|. controlMask .|. shiftMask, xK_r      ), renameWorkspace defaultXPConfig)
    , ((modMask, xK_f  ), tagPrompt defaultXPConfig (\s -> withFocused (addTag s) ))
    , ((modMask,  		 xK_d  ), tagDelPrompt defaultXPConfig )
    , ((modMask,   		 xK_g  ), tagPrompt defaultXPConfig (\s -> focusUpTaggedGlobal s ))
    ]
    ++
    [ ((m .|. modMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

-- Mouse bindings:
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w )) -- set the window to floating mode and move by dragging
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster)) -- raise the window to the top of the stack
    , ((modMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) -- set the window to floating mode and resize by dragging
    , ((modMask, button4), (\_ -> prevWS)) -- switch to previous workspace
    , ((modMask, button5), (\_ -> nextWS)) -- switch to next workspace
    ]

-- Window rules:
myManageHook = composeAll . concat $
   -- [ [isDialog --> doFloat]
    [ [className =? c --> doFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("1:") | x <- my1Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("2:") | x <- my2Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("3:") | x <- my3Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("4:") | x <- my4Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("5:") | x <- my5Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("6:") | x <- my6Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("7:") | x <- my7Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift ("8:") | x <- my8Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShiftAndGo ("9:") | x <- my9Shifts]
    ]
    where
    doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift
    myCFloats = ["Kcalc", "Smplayer", "MPlayer", "XCalc", "XFontsel", "Plasma-desktop", "Kmix", "vlc", "Vlc", "VirtualBox"]
    myTFloats = ["Save As..."]
    myRFloats = []
    myIgnores = []
    my1Shifts = []
    my2Shifts = []
    my3Shifts = []
    my4Shifts = []
    my5Shifts = []
    my6Shifts = []
    my7Shifts = []
    my8Shifts = []
    my9Shifts = []

-- dynamicLog pretty printer for dzen:
myDzenPP h = defaultPP
    { ppCurrent = wrap ("^fg(" ++ myUrgentFGColor ++ ")^bg(" ++ myFocusedBGColor ++ ")^p()^fg(" ++ myNormalFGColor ++ ")") "^fg()^bg()^p()" . \wsId -> dropIx wsId
    , ppVisible = wrap ("^fg(" ++ myNormalFGColor ++ ")^bg(" ++ myNormalBGColor ++ ")^p()^fg(" ++ myNormalFGColor ++ ")") "^fg()^bg()^p()" . \wsId -> dropIx wsId
    , ppHidden =  wrap ("") "^fg()^bg()^p()" . \wsId -> if (':' `elem` wsId) then drop 2 wsId else wsId -- don't use ^fg() here!!
    --, ppHiddenNoWindows = wrap ("^fg(" ++ myDzenFGColor ++ ")^bg()^p()^i(" ++ myIconDir ++ "/corner.xbm)") "^fg()^bg()^p()" . \wsId -> dropIx wsId
    , ppHiddenNoWindows = \wsId -> wrap ("^fg(" ++ myDzenFGColor ++ ")^bg()^p()") "^fg()^bg()^p()" . dropIx $ wsId
    , ppUrgent = wrap (("^fg(" ++ myUrgentFGColor ++ ")^bg(" ++ myNormalBGColor ++ ")^p()^fg(" ++ myUrgentFGColor ++ ")")) "^fg()^bg()^p()" . \wsId -> dropIx wsId
    , ppSep = " "
    , ppWsSep = " "
    , ppTitle = dzenColor ("" ++ myNormalFGColor ++ "") "" . wrap "< " " >"
    , ppLayout = dzenColor ("" ++ myNormalFGColor ++ "") "" .
        (\x -> case x of
        "Full" -> "^fg(" ++ myIconFGColor ++ ")"
        "Tall" -> "^fg(" ++ myIconFGColor ++ ")"
        "Mirror Tall" -> "^fg(" ++ myIconFGColor ++ ")"
        _ -> x
        )
    , ppOutput = hPutStrLn h
    }
    where
    dropIx wsId = if (':' `elem` wsId) then drop 2 wsId else wsId

main =  --do 
  -- dzen <- spawnPipe myStatusBar 
   -- xmproc <- spawnPipe "xmobar"
  -- xmonad $ xmobar defaultConfig
    xmonad =<< xmobar defaultConfig
  --  xmonad $ defaultConfig
    { terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    -- , numlockMask        = myNumlockMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
 
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
 
    , layoutHook         = myLayout
    , manageHook         = myManageHook <+> manageDocks -- <+> dynamicMasterHook
    -- , logHook            = dynamicLogWithPP $  myDzenPP dzen
    -- , logHook = takeTopFocus >> dynamicLogWithPP xmobarPP
    --                    { ppOutput = hPutStrLn xmproc
    --                    , ppTitle = xmobarColor "green" "" . shorten 50
    --                    } >> ewmhDesktopsLogHook >> setWMName "LG3D"
    , logHook = ewmhDesktopsLogHook >> setWMName "LG3D"
    , startupHook        = ewmhDesktopsStartup 
    }
