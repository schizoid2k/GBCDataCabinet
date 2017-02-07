--------------------------------------------------------------------------------------
-- GBC Data Cabinet Demo
-- Written by John Schumacher
-- Copyright 2017 John Schumacher, Games By Candlelight
-- http://gamesbycandlelight.com
--
-- This application demonstrates the use of GBC Data Cabinet, my CoronaSDK plugin.
-- Feel free to use or modify this code for your benefit.
--------------------------------------------------------------------------------------
-- 
-- Abstract: GBCDataCabinet Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
------------------------------------------------------------

-- Load plugin library
local GBCDataCabinet = require "plugin.GBCDataCabinet"
local widget = require "widget"

-------------------------------------------------------------------------------
-- BEGIN (Insert your sample test starting here)
-------------------------------------------------------------------------------
local composer = require( "composer" )

display.setStatusBar(display.HiddenStatusBar)
widget.setTheme("widget_theme_android_holo_light")

-- For Zerobrane debugging
if system.getInfo("environment") == "simulator" then
    require("mobdebug").start() 
end

composer.gotoScene("top")
-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------