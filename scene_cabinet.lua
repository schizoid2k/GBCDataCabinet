local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local widget = require "widget"
local GBCDataCabinet = require "plugin.GBCDataCabinet"

local titleText, infoText
local statusText = {}
local btnBack
local currentSceneGroup

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


local function CabinetDemo()
    -------------------------------------------
    -- 1. create a cabinet in memory
    -------------------------------------------
    local success = GBCDataCabinet.createCabinet("My First Cabinet")
    
    statusText[1] = display.newText(currentSceneGroup, "First cabinet created: "..tostring(success), 
        Screen.CenterX, Screen.Top + 75, native.systemFont, 14)

    -- add some data to cabinet
    success = GBCDataCabinet.set("My First Cabinet", "Date", os.date())
    
    statusText[2] = display.newText(currentSceneGroup, "Data added to first cabinet: "..tostring(success), 
        Screen.CenterX, Screen.Top + 100, native.systemFont, 14)

    -------------------------------------------
    -- 2. create another cabinet and save data to disk
    -------------------------------------------

    success = GBCDataCabinet.createCabinet("My Second Cabinet")
    
    statusText[3] = display.newText(currentSceneGroup, "Second Cabinet Created: "..tostring(success), 
        Screen.CenterX, Screen.Top + 125, native.systemFont, 14)

    -- add some data to the cabinet
    success = GBCDataCabinet.set("My Second Cabinet", "Score", 100)
    
    statusText[4] = display.newText(currentSceneGroup, "Data added to second cabinet: "..tostring(success), 
        Screen.CenterX, Screen.Top + 150, native.systemFont, 14)

    -- add a table to the cabinet
    success = GBCDataCabinet.set("My Second Cabinet", "Other Info", {
        ["My First Name"] = "First Name",
        ["My Last Name"] = "Last Name",
    })

    statusText[5] = display.newText(currentSceneGroup, "Table added to second cabinet: "..tostring(success), 
        Screen.CenterX, Screen.Top + 175, native.systemFont, 14)  
    
    -- change the value of some data that was previously added
    -- Note "My First Name" has a different value
    success = GBCDataCabinet.set("My Second Cabinet", "Other Info", {
        ["My First Name"] = "Another First Name",
        ["My Last Name"] = "Last Name",
    })

    -- save this cabinet to disk for later use
    success = GBCDataCabinet.save("My Second Cabinet")
    
    statusText[6] = display.newText(currentSceneGroup, "Second cabinet saved to disk: "..tostring(success), 
        Screen.CenterX, Screen.Top + 200, native.systemFont, 14)    
    
    -- delete the cabinet in memory, but not from the disk
    success = GBCDataCabinet.deleteCabinet("My Second Cabinet")
    
    
    -------------------------------------------
    -- 3. recall some persistent data
    -------------------------------------------

    -- Load some saved data
    success = GBCDataCabinet.load("My Second Cabinet")
    
    statusText[7] = display.newText(currentSceneGroup, "Second cabinet loaded into memory: "..tostring(success), 
        Screen.CenterX, Screen.Top + 225, native.systemFont, 14)

    -- get a value previously saved
    local value = GBCDataCabinet.get("My Second Cabinet", "Score")
    
    if value ~= nil then
        statusText[8] = display.newText(currentSceneGroup, "Score: "..value, 
            Screen.CenterX, Screen.Top + 250, native.systemFont, 14)
    end

    -------------------------------------------
    -- 4. Try to recall some data that was NOT 
    --    saved to disk.
    -------------------------------------------

    success = GBCDataCabinet.load("My First Cabinet")
    
    statusText[9] = display.newText(currentSceneGroup, "First cabinet loaded into memory: "..tostring(success), 
        Screen.CenterX, Screen.Top + 275, native.systemFont, 14)
    
    if not success then
        statusText[10] = display.newText(currentSceneGroup, "Error message: This cabinet does not exist", 
            Screen.CenterX, Screen.Top + 300, native.systemFont, 14)
    end  
end 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    currentSceneGroup = sceneGroup
    
    titleText = display.newText({
        parent = sceneGroup,
        text = "Example 1 - Cabinet Example",
        x = Screen.Left + 10,
        y = Screen.Top + 15,
        font = native.systemFont,
        fontSize = 18,
        align = "left",
    })
    
    infoText = display.newText({
        parent = sceneGroup,
        text = "This example will add and extract data from cabinets\n"..
            "Check out the code to see what's happening",
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

    titleText.anchorX = 0
    infoText.anchorX = 0
    sceneGroup:insert(btnBack)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        
        CabinetDemo()
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

        -- removes all in-memory cabinets
        GBCDataCabinet.clean()
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

    display.remove(btnBack)
    display.remove(titleText)
    display.remove(infoText)

    btnBack = nil
    titleText = nil
    infoText = nil
    
    for i = #statusText, 1, -1 do
        display.remove(statusText[i])
        statusText[i] = nil
    end
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