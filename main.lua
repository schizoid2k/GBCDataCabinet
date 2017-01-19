-- 
-- Abstract: GBCDataCabinet Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
------------------------------------------------------------

-- Load plugin library
local GBCDataCabinet = require "plugin.GBCDataCabinet"

-------------------------------------------------------------------------------
-- BEGIN (Insert your sample test starting here)
-------------------------------------------------------------------------------

local success = false
local center = display.contentCenterX
local top = display.screenOriginY + 30

-- 1. create a cabinet in memory
success = GBCDataCabinet.createCabinet("My First Cabinet")
display.newText("First cabinet created: "..tostring(success), center, top + 25, native.systemFont, 14)

success = GBCDataCabinet.set("My First Cabinet", "Date", os.date())
display.newText("Data added to first cabinet: "..tostring(success), center, top + 50, native.systemFont, 14)

-- 2.create another cabinet and save to disk
success = GBCDataCabinet.createCabinet("My Second Cabinet")
display.newText("Second Cabinet Created: "..tostring(success), center, top + 75, native.systemFont, 14)

success = GBCDataCabinet.set("My Second Cabinet", "Score", 100)
display.newText("Data added to second cabinet: "..tostring(success), center, top + 100, native.systemFont, 14)

success = GBCDataCabinet.set("My Second Cabinet", "Other Info", {
    ["My First Name"] = "First Name",
    ["My Last Name"] = "Last Name",
})
display.newText("Table added to second cabinet: "..tostring(success), center, top + 125, native.systemFont, 14)

success = GBCDataCabinet.save("My Second Cabinet")
display.newText("Second cabinet saved to disk: "..tostring(success), center, top + 150, native.systemFont, 14)


-- to test reading data from a persistent cabinet, 
-- comment out the code in steps 1 and 2 and uncomment step 3 and 4 below.

-- 3. Recall some saved data
success = GBCDataCabinet.load("My Second Cabinet")
display.newText("Second cabinet loaded into memory: "..tostring(success), center, top + 175, native.systemFont, 14)

local value = GBCDataCabinet.get("My Second Cabinet", "Score")
display.newText("Score: "..value, center, top + 200, native.systemFont, 14)

-- 4. Try to recall data from a cabinet not saved to disk
-- This should be "false" since the first cabinet is a memory-only cabinet
success = GBCDataCabinet.load("My First Cabinet")
display.newText("First cabinet loaded into memory: "..tostring(success), center, top + 225, native.systemFont, 14)
if not success then
    display.newText("Error message: "..GBCDataCabinet.getLastError(), center, top + 250, native.systemFont, 14)
end
-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------