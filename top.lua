--------------------------------------------------------------------------------------
-- GBC Data Cabinet Demo
-- Written by John Schumacher
-- Copyright 2017 John Schumacher, Games By Candlelight
-- http://gamesbycandlelight.com
--------------------------------------------------------------------------------------

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local widget = require "widget"

local titleText, infoText
local Buttons = {}

local Screen = {
    Top = display.screenOriginY,
    Left = display.screenOriginX,  
    Right = display.viewableContentWidth + math.abs(display.screenOriginX),
    Bottom = display.viewableContentHeight + math.abs(display.screenOriginY),        
    Height = math.floor(display.actualContentWidth + 0.5),
    Width = math.floor(display.actualContentHeight + 0.5),
    CenterX = display.contentCenterX,
    CenterY = display.contentCenterY,
}

local Examples = {
    {text = "Example 1 - Cabinet", scene = "scene_cabinet"},
    {text = "Example 2 - Stack", scene = "scene_stack"},
    {text = "Example 3 - Queue", scene = "scene_queue"},
}

local function onButtonPress(event)
    if event.phase == "ended" then
        composer.gotoScene(event.target.id)
    end
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    titleText = display.newText({
        parent = sceneGroup,
        text = "GBC Data Cabinet Demo",
        x = Screen.CenterX,
        y = Screen.Top + 15,
        font = native.systemFont,
        fontSize = 18,
        align = "left",
    })
    
    infoText = display.newText({
        parent = sceneGroup,
        text = "This app demonstrates the use of GBC Data Cabinet",
        x = Screen.Left + 10,
        y = Screen.Top + 50,
        font = native.systemFont,
        fontSize = 12,
        align = "left",
    })

    for i = 1, #Examples do
        Buttons[i] = widget.newButton({
            x = Screen.CenterX,
            y = Screen.Top + 100 + (50 * i),
            width = 200,
            height = 30,
            fontSize = 12,
            id = Examples[i].scene,
            label = Examples[i].text,
            shape = "rect",
            onRelease = onButtonPress,       
        })
    
        sceneGroup:insert(Buttons[i])
    end
    
    infoText.anchorX = 0
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene