--------------------------------------------------------------------------------------
-- GBC Data Cabinet Demo
-- Written by John Schumacher
-- Copyright 2017 John Schumacher, Games By Candlelight
-- http://gamesbycandlelight.com
--
-- This scene demonstates the stack.
-- Here we place 5 random numbers on the stack, and retrieve them.
--------------------------------------------------------------------------------------

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local widget = require "widget"
local GBCDataCabinet = require "plugin.GBCDataCabinet"

local titleText, infoText
local pushText, popText, countText
local btnBack
local currentSceneGroup
local demoStack

-- screen shortcuts
local Screen = {
    Top = display.screenOriginY,
    Left = display.screenOriginX,  
    Right = display.viewableContentWidth + math.abs(display.screenOriginX),
    Bottom = display.viewableContentHeight + math.abs(display.screenOriginY),        
    Width = math.floor(display.actualContentWidth + 0.5),
    Height = math.floor(display.actualContentHeight + 0.5),
    CenterX = display.contentCenterX,
    CenterY = display.contentCenterY,
}

local function StackDemo()
    -- create a stack
    demoStack = GBCDataCabinet.createStack("DemoStack")
    
    -- push 5 values to the stack
    for i = 1, 5 do
        local val = math.random(1, 100)
        GBCDataCabinet.push("DemoStack", val)
        pushText.text = pushText.text.." "..tostring(val)
    end
    
    countText.text = "There are "..GBCDataCabinet.stackCount("DemoStack")..
        " items in this stack"  
        
    -- get the 5 values
    for i = 1, 5 do
        local val = GBCDataCabinet.pop("DemoStack")
        
        if val ~= nil then
            popText.text = popText.text.." "..tostring(val)
        end
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
        text = "Example 1 - Stack Example",
        x = Screen.Left + 10,
        y = Screen.Top + 15,
        font = native.systemFont,
        fontSize = 18,
        align = "left",
    })
    
    infoText = display.newText({
        parent = sceneGroup,
        text = "This example will push and pop values off the stack",
        x = Screen.Left + 10,
        y = Screen.Top + 40,
        font = native.systemFont,
        fontSize = 12,
        align = "left",
    })    
    
    btnBack = widget.newButton({
        x = Screen.Left + 100,
        y = Screen.Bottom - 50,
        width = 75,
        height = 30,
        fontSize = 12,
        id = "back",
        label = "Back",
        shape = "rect",
        onRelease = function() composer.gotoScene("top") end,       
    })

    pushText = display.newText({
        parent = sceneGroup,
        text = "Pushing 5 values to the stack:\n",
        x = Screen.Left + 10,
        y = Screen.Top + 100,
        font = native.systemFont,
        fontSize = 12,
        align = "left",
    })

    countText = display.newText({
        parent = sceneGroup,
        text = "",
        x = Screen.Left + 10,
        y = Screen.Top + 140,
        font = native.systemFont,
        fontSize = 12,
        align = "left",
    })

    popText = display.newText({
        parent = sceneGroup,
        text = "Pop 5 values off the stack:\n",
        x = Screen.Left + 10,
        y = Screen.Top + 180,
        font = native.systemFont,
        fontSize = 12,
        align = "left",
    })

    titleText.anchorX = 0
    infoText.anchorX = 0
    pushText.anchorX = 0
    popText.anchorX = 0
    countText.anchorX = 0
    sceneGroup:insert(btnBack) 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
        pushText.text = "Putting 5 values on the queue:\n"
        popText.text = "Taking 5 values from the queue:\n"
        countText.text = ""        
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        StackDemo()
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

        -- Make sure to destroy the stack when done
        -- If you do not pop all the values from the stack, then there
        -- will be values the next time you run the scene.
        GBCDataCabinet.stackDelete("StackDemo")
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

    display.remove(btnBack)
    btnBack = nil

    display.remove(titleText)
    display.remove(infoText)
    display.remove(pushText)
    display.remove(popText)
    display.remove(countText)
    
    titleText = nil
    infoText = nil
    pushText = nil
    popText = nil
    countText = nil
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