-- Itemshop & Casino by Mr_Bubba 

-- Peripheral Setup
leftMonitor = peripheral.wrap("left")  -- The 1x2 monitor on the left
topMonitor = peripheral.wrap("top")   -- The 2x3 monitor on top
diskDrive = peripheral.wrap("right")  -- Disk drive on the right
inputChest = peripheral.wrap("minecraft:chest_2")  -- Input chest for item-to-credit conversion
outputChest = peripheral.wrap("minecraft:chest_3")  -- Output chest for purchased items
storageController = peripheral.wrap("sophisticatedstorage:controller_0")  -- Storage Controller

-- Define item prices here
itemPrices = {
    -- Basic Blocks
    ["minecraft:dirt"] = 1,
    ["minecraft:grass_block"] = 1,
    ["minecraft:sand"] = 1,
    ["minecraft:cobblestone"] = 1,
    ["minecraft:stone"] = 2,
    ["minecraft:oak_log"] = 2,
    ["minecraft:birch_log"] = 2,
    ["minecraft:spruce_log"] = 2,
    ["minecraft:dark_oak_log"] = 2,
    ["minecraft:acacia_log"] = 2,
    ["minecraft:jungle_log"] = 2,

    -- Minerals and Ores
    ["minecraft:coal"] = 1,
    ["minecraft:iron_ore"] = 3,
    ["minecraft:iron_ingot"] = 4,
    ["minecraft:gold_ore"] = 4,
    ["minecraft:gold_ingot"] = 6,
    ["minecraft:diamond"] = 20,
    ["minecraft:emerald"] = 25,
    ["minecraft:netherite_ingot"] = 100,
    ["minecraft:netherite_scrap"] = 50,
    ["minecraft:redstone"] = 2,
    ["minecraft:lapis_lazuli"] = 3,
    ["minecraft:quartz"] = 4,

    -- Precious Materials
    ["minecraft:nether_star"] = 500,
    ["minecraft:ender_pearl"] = 15,
    ["minecraft:blaze_powder"] = 10,
    ["minecraft:ghast_tear"] = 50,

    -- Tools and Weapons
    ["minecraft:iron_sword"] = 10,
    ["minecraft:diamond_sword"] = 30,
    ["minecraft:iron_pickaxe"] = 15,
    ["minecraft:diamond_pickaxe"] = 35,
    ["minecraft:netherite_sword"] = 100,
    ["minecraft:netherite_pickaxe"] = 120,
    ["minecraft:iron_shovel"] = 5,
    ["minecraft:diamond_shovel"] = 15,
    ["minecraft:iron_axe"] = 15,
    ["minecraft:diamond_axe"] = 30,
    ["minecraft:iron_hoe"] = 5,
    ["minecraft:diamond_hoe"] = 15,

    -- Armor
    ["minecraft:iron_helmet"] = 20,
    ["minecraft:iron_chestplate"] = 30,
    ["minecraft:iron_leggings"] = 25,
    ["minecraft:iron_boots"] = 15,
    ["minecraft:diamond_helmet"] = 50,
    ["minecraft:diamond_chestplate"] = 80,
    ["minecraft:diamond_leggings"] = 65,
    ["minecraft:diamond_boots"] = 45,
    ["minecraft:netherite_helmet"] = 150,
    ["minecraft:netherite_chestplate"] = 200,
    ["minecraft:netherite_leggings"] = 180,
    ["minecraft:netherite_boots"] = 130,

    -- Food Items
    ["minecraft:apple"] = 2,
    ["minecraft:golden_apple"] = 40,
    ["minecraft:enchanted_golden_apple"] = 200,
    ["minecraft:bread"] = 3,
    ["minecraft:steak"] = 4,
    ["minecraft:cooked_porkchop"] = 4,
    ["minecraft:cooked_chicken"] = 3,
    ["minecraft:cooked_mutton"] = 3,
    ["minecraft:carrot"] = 2,
    ["minecraft:potato"] = 2,
    ["minecraft:baked_potato"] = 3,
    ["minecraft:pumpkin_pie"] = 5,

    -- Farming
    ["minecraft:wheat_seeds"] = 1,
    ["minecraft:melon_seeds"] = 2,
    ["minecraft:pumpkin_seeds"] = 2,
    ["minecraft:sugar_cane"] = 1,
    ["minecraft:cactus"] = 2,
    ["minecraft:wheat"] = 2,
    ["minecraft:melon_slice"] = 2,

    -- Mobs and Combat Items
    ["minecraft:bow"] = 10,
    ["minecraft:arrow"] = 1,
    ["minecraft:spectral_arrow"] = 2,
    ["minecraft:trident"] = 100,
    ["minecraft:shield"] = 8,
    ["minecraft:totem_of_undying"] = 200,

    -- Potions and Brewing
    ["minecraft:potion"] = 15,  -- General price for basic potions
    ["minecraft:splash_potion"] = 20,
    ["minecraft:lingering_potion"] = 25,
    ["minecraft:brewing_stand"] = 30,
    ["minecraft:blaze_rod"] = 10,

    -- Enchanting and Experience
    ["minecraft:experience_bottle"] = 10,
    ["minecraft:enchanting_table"] = 40,
    ["minecraft:anvil"] = 50,
    ["minecraft:book"] = 2,
    ["minecraft:enchanted_book"] = 30,

    -- Miscellaneous
    ["minecraft:elytra"] = 500,
    ["minecraft:dragon_egg"] = 1000,
    ["minecraft:end_crystal"] = 100,
    ["minecraft:saddle"] = 25,
    ["minecraft:name_tag"] = 15,
    ["minecraft:lead"] = 10,

    -- Decoration Blocks
    ["minecraft:glass"] = 1,
    ["minecraft:glass_pane"] = 1,
    ["minecraft:glowstone"] = 5,
    ["minecraft:sea_lantern"] = 6,
    ["minecraft:redstone_lamp"] = 5,

    -- Nether and End Items
    ["minecraft:netherrack"] = 1,
    ["minecraft:end_stone"] = 2,
    ["minecraft:obsidian"] = 10,
    ["minecraft:end_rod"] = 20,
    ["minecraft:shulker_box"] = 50,

    -- Transport and Redstone
    ["minecraft:minecart"] = 5,
    ["minecraft:hopper"] = 10,
    ["minecraft:redstone_torch"] = 1,
    ["minecraft:piston"] = 5,
    ["minecraft:sticky_piston"] = 8,
    ["minecraft:powered_rail"] = 7,
    ["minecraft:detector_rail"] = 7,
    ["minecraft:rail"] = 3,

    -- Wool and Dyes
    ["minecraft:white_wool"] = 2,
    ["minecraft:red_wool"] = 2,
    ["minecraft:blue_wool"] = 2,
    ["minecraft:yellow_wool"] = 2,
    ["minecraft:light_blue_wool"] = 2,
    ["minecraft:black_dye"] = 1,
    ["minecraft:blue_dye"] = 1,
    ["minecraft:red_dye"] = 1,
    ["minecraft:green_dye"] = 1,
    ["minecraft:yellow_dye"] = 1,

    -- Other Items
    ["minecraft:compass"] = 10,
    ["minecraft:clock"] = 8,
    ["minecraft:shears"] = 4,
    ["minecraft:bucket"] = 3,
    ["minecraft:flint_and_steel"] = 5,
    ["minecraft:water_bucket"] = 5,
    ["minecraft:lava_bucket"] = 8,
    ["minecraft:milk_bucket"] = 5
}

availableItems = {}
local testMode = false
local screenWidth, screenHeight = topMonitor.getSize()
local Y1 = screenHeight
local X1 = screenWidth
term.redirect(topMonitor)

-- Clear and setup the monitors
function setupMonitors()
    leftMonitor.clear()
    leftMonitor.setTextScale(1)
    topMonitor.clear()
    topMonitor.setTextScale(1)
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
end

-- Draw the on-screen keyboard on the top monitor
function drawKeyboard()
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    displayWatermark()
    -- Draw letters (3 rows of letters)
    local letters = {
        "qwertyuiop",
        "asdfghjkl",
        "zxcvbnm"
    }
    
    -- Draw the letters on the top monitor (adjust x, y positions for rows)
    for row = 1, #letters do
        local y = row + 4  -- Start the keyboard lower on the screen (row 5)
        for i = 1, #letters[row] do
            local letter = letters[row]:sub(i, i)
            local x = (i * 3) - 2  -- Space out letters and adjust for alignment
            topMonitor.setCursorPos(x, y)
            topMonitor.write("[" .. letter .. "]")
        end
    end

    -- Draw numbers
    local numbers = "1234567890"
    topMonitor.setCursorPos(1, 3)  -- Numbers row above letters
    for i = 1, #numbers do
        local x = (i * 3) - 2  -- Space out numbers properly
        topMonitor.setCursorPos(x, 3)
        topMonitor.write("[" .. numbers:sub(i, i) .. "]")
    end

    -- Draw special controls (Backspace and Submit)
    topMonitor.setCursorPos(1, 9)
    topMonitor.write("[Backspace] [Submit]")

    -- Draw the spacebar (new addition)
    topMonitor.setCursorPos(1, 8)  -- Place it one row above Backspace/Submit
    topMonitor.write("[           Space           ]")  -- Large button for space
end

-- Function to reset the program when the disk is removed
function resetOnDiskRemove()
    while true do
        -- Wait for the "disk" or "disk_eject" event
        local event, side = os.pullEvent()
        
        -- If the event is related to the disk and it has been removed
        if event == "disk_eject" or event == "disk" then
            if not diskDrive.isDiskPresent() then
                -- Clear any stored global variables related to user info
                username = nil
                password = nil
                hint = nil
                credits = 0
                -- Clear monitors
                topMonitor.clear()
                leftMonitor.clear()
                topMonitor.setCursorPos(1, 1)
                topMonitor.write("Disk removed! Returning to main menu...")
                sleep(2)
                os.reboot()  -- Reset to main menu or startup script
            end
        end
    end
end

-- Handle touch events for the on-screen keyboard with password hint and debugging
function handleKeyboardInput(hint)
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    local password = ""  -- The entered password (masked)

    while true do
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.setTextColor(colors.white)
        -- Redraw the "Password:" label before every key press update
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("Password: ")  -- Keep the label on the screen

        -- Display the password hint below the keyboard if available
        if hint and hint ~= "" then
            topMonitor.setCursorPos(1, 11)
            topMonitor.write("Password Hint: " .. hint)
        end

        -- Wait for a touch event on the monitor
        local event, side, x, y = os.pullEvent("monitor_touch")

        -- DEBUG: Print the touch event to the console for debugging
        --print("Touch event: x = " .. x .. ", y = " .. y)

        -- Handle letter inputs
        if y >= 5 and y <= 7 then
            local row = y - 4
            local letters = {
                "qwertyuiop",  -- First row of letters
                "asdfghjkl",   -- Second row of letters
                "zxcvbnm"      -- Third row of letters
            }
            local letterIndex = math.ceil(x / 3)  -- Correct letter position based on new spacing
            local letter = letters[row]:sub(letterIndex, letterIndex)

            -- DEBUG: Print the selected letter
            --print("Selected letter: " .. letter)

            if letter and letter ~= "" then
                password = password .. letter
                updatePasswordDisplay(password)
            end

        -- Handle number inputs
        elseif y == 3 then
            local numbers = "1234567890"
            local numberIndex = math.ceil(x / 3)
            local number = numbers:sub(numberIndex, numberIndex)

            -- DEBUG: Print the selected number
            --print("Selected number: " .. number)

            if number and number ~= "" then
                password = password .. number
                updatePasswordDisplay(password)
            end

        -- Handle special buttons (Backspace and Submit)
        elseif y == 9 then
            if x >= 1 and x <= 11 then  -- Backspace button
                password = password:sub(1, -2)
                updatePasswordDisplay(password)

                -- DEBUG: Print Backspace press
                --print("Pressed: [Backspace]")

            elseif x >= 13 and x <= 20 then  -- Submit button
                -- DEBUG: Print Submit press and the entered password
                --print("Pressed: [Submit], Password: " .. password)
                return password  -- Return the entered password
            end
        end
    end
end

-- Handle clearing the search
function handleClearSearch()
    -- Clear any search filters
    displayShopItems(credits)
end

-- Update the password display (masked with *)
function updatePasswordDisplay(password)
    topMonitor.setCursorPos(11, 1)  -- Password display starts at column 11
    topMonitor.clearLine()
    topMonitor.write(string.rep("*", #password))
end

-- Main menu buttons
function drawMainMenu()
    leftMonitor.clear()
    leftMonitor.setCursorPos(1, 1)
    leftMonitor.write("[Item Shop]")  -- Button for Item Shop
    leftMonitor.setCursorPos(1, 2)
    leftMonitor.write("[Slot Machine]")  -- Button for Slot Machine
    leftMonitor.setCursorPos(1, 3)
    leftMonitor.write("[Exit]")  -- Button to exit to disk prompt
end

-- Handle Main Menu touch events
function handleMainMenuTouch(player)
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")
        if side == "left" then
            if y == 1 then
                runItemShop(player)  -- Launch Item Shop
            elseif y == 2 then
                runSlotMachine(player)  -- Launch Slot Machine
            elseif y == 3 then
                shell.run("startup")  -- Exit to disk prompt
            end
        end
    end
end

-- Display welcome message and credit info on top monitor
function displayMain(player, credits)

    -- Load credits from the floppy disk
    local credits = loadCreditsFromDisk()

    topMonitor.clear()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Welcome, " .. player)
    topMonitor.setCursorPos(1, 2)
    topMonitor.write("Credits: " .. credits)
    displayWatermark()
end

-- Save Player Data to Disk
function savePlayerData(player, credits)
    local diskPath = diskDrive.getMountPath()
    local file = fs.open(diskPath .. "/" .. player .. ".txt", "w")
    file.writeLine(tostring(credits))
    file.close()
end

-- Load Player Data from Disk
function loadPlayerData(player)
    local diskPath = diskDrive.getMountPath()
    if fs.exists(diskPath .. "/" .. player .. ".txt") then
        local file = fs.open(diskPath .. "/" .. player .. ".txt", "r")
        local credits = tonumber(file.readLine())
        file.close()
        return credits
    else
        return 0  -- Default credits if no file exists
    end
end

-- Save credentials (username, password, hint) to disk
function saveCredentials(username, password, hint)
    local diskPath = diskDrive.getMountPath()
    if diskPath then
        local file = fs.open(diskPath .. "/" .. username .. "_credentials.txt", "w")
        file.writeLine(password)  -- Ensure password is written as a string
        file.writeLine(hint)
        file.close()
        diskDrive.setDiskLabel(username)
    end
end

-- Load credentials from disk
function loadCredentials(username)
    local diskPath = diskDrive.getMountPath()
    if diskPath and fs.exists(diskPath .. "/" .. username .. "_credentials.txt") then
        local file = fs.open(diskPath .. "/" .. username .. "_credentials.txt", "r")
        local password = file.readLine()  -- Read password as string
        local hint = file.readLine()
        file.close()
        return password, hint
    else
        return nil, nil
    end
end

-- Function to draw prompts and keyboard for setting up new player (no clearing topMonitor every time)
function drawSetupScreen(prompt)
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    topMonitor.setCursorPos(1, 1)
    topMonitor.write(prompt)  -- Display the correct prompt (username, password, or hint)
    
    -- Draw the on-screen keyboard (keep the same for all inputs)
    drawKeyboard()
end

-- Function to handle input via on-screen keyboard
function handleKeyboardInputForSetup(prompt, isPassword, hint)
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    local input = ""  -- To store the input (masked if it's password)

    -- Initially display the prompt and input area
    updateSetupDisplay(input, prompt, isPassword)

    while true do
        -- Display the password hint below the keyboard if available (during password input)
        if hint and hint ~= "" then
            topMonitor.setCursorPos(1, 11)
            topMonitor.write("Password Hint: " .. hint)
        end

        -- Wait for a touch event on the monitor
        local event, side, x, y = os.pullEvent("monitor_touch")

        -- Handle letter inputs
        if y >= 5 and y <= 7 then
            local row = y - 4
            local letters = {
                "qwertyuiop",
                "asdfghjkl",
                "zxcvbnm"
            }
            local letterIndex = math.ceil(x / 3)  -- Correct letter position based on new spacing
            local letter = letters[row]:sub(letterIndex, letterIndex)
            if letter and letter ~= "" then
                input = input .. letter
                updateSetupDisplay(input, prompt, isPassword)  -- Refresh after adding input
            end
        -- Handle number inputs
        elseif y == 3 then
            local numbers = "1234567890"
            local numberIndex = math.ceil(x / 3)
            local number = numbers:sub(numberIndex, numberIndex)
            if number and number ~= "" then
                input = input .. number
                updateSetupDisplay(input, prompt, isPassword)  -- Refresh after adding input
            end
        -- Handle spacebar input
        elseif y == 8 then
            if x >= 2 and x <= 21 then  -- Spacebar spans this range
                input = input .. " "  -- Add a space character to the input
                updateSetupDisplay(input, prompt, isPassword)  -- Refresh after adding input
            end
        -- Handle special buttons (Backspace and Submit)
        elseif y == 9 then
            if x >= 1 and x <= 11 then  -- Backspace button
                input = input:sub(1, -2)
                updateSetupDisplay(input, prompt, isPassword)  -- Refresh after backspace
            elseif x >= 13 and x <= 20 then  -- Submit button
                return input  -- Return the entered input
            end
        end
    end
end

-- Update the display for setup input (Username, Password, or Hint)
function updateSetupDisplay(input, prompt, isPassword)
    -- Clear the input area (start after the prompt text)
    topMonitor.setCursorPos(1, 1)
    topMonitor.clearLine()  -- Clear the line before rewriting
    topMonitor.write(prompt)  -- Re-write the prompt every time

    -- Set the cursor position for input (right after the prompt)
    topMonitor.setCursorPos(#prompt + 1, 1)

    -- Mask the password if it's a password input, otherwise display normal input
    if isPassword then
        --topMonitor.write(string.rep("*", #input))  -- Mask the password with *
        topMonitor.write(input)
        print(input)
    else
        topMonitor.write(input)  -- Display the actual input for username or hint
    end

    -- Redraw the keyboard so it stays visible
    drawKeyboard()
end

-- Setup new user on a new disk using the monitor and keyboard
function setupNewPlayerDisk()
    -- Step 1: Clear the monitor first
    topMonitor.clear()
    displayWatermark()
    -- Clear any stored data from previous operations
    username = nil
    password = nil
    hint = nil
    credits = 0

    -- Step 2: Get the Username
    local usernamePrompt = "Enter your Username: "
    local username = handleKeyboardInputForSetup(usernamePrompt, false, nil)  -- No hint and not masked

    -- Step 3: Get the Password (masked input)
    local passwordPrompt = "Enter your Password: "
    local password = handleKeyboardInputForSetup(passwordPrompt, true, nil)  -- Masked input for password

    -- Step 4: Get the Password Hint (optional)
    local hintPrompt = "Enter a Password Hint (optional): "
    local hint = handleKeyboardInputForSetup(hintPrompt, false, nil)  -- No masking for the hint

    -- Step 5: Save the credentials and start with 0 credits
    saveCredentials(username, password, hint)
    savePlayerData(username, 0)

    return username
end

-- Convert a string to its hexadecimal representation safely
function toHex(str)
    -- Ensure the input is a string and not nil or a number
    if type(str) ~= "string" then
        return "(invalid input)"
    end
    return (str:gsub('.', function(c)
        return string.format('%02X', string.byte(c))
    end))
end

--print("Loaded password from disk: ", correctPassword)
--print("Entered password: ", result)

-- Validate user disk and password using on-screen keyboard
function validateUserDisk(username)
    local correctPassword, hint = loadCredentials(username)
    local attempts = 0

    --print("Loaded correct password from disk: [" .. tostring(correctPassword) .. "]")

    while attempts < 3 do
        -- Draw the password keyboard and prompt
        drawKeyboard()

        local enteredPassword = nil

        -- Parallel process to monitor disk removal while the user inputs the password
        local success = parallel.waitForAny(
            function() 
                enteredPassword = handleKeyboardInput(hint)
            end,
            resetOnDiskRemove  -- Monitor disk removal
        )

        if success == 1 then  -- This means the keyboard input was successful
            --print("Entered password: [" .. tostring(enteredPassword) .. "]")

            -- Compare entered and stored password after trimming extra characters
            enteredPassword = enteredPassword:match("^%s*(.-)%s*$")  -- Trim any extra spaces or newlines
            correctPassword = correctPassword and correctPassword:match("^%s*(.-)%s*$")

            --print("Comparing passwords: [" .. enteredPassword .. "] vs [" .. correctPassword .. "]")

            if enteredPassword == correctPassword then
                return true  -- Access granted
            else
                attempts = attempts + 1
                topMonitor.setCursorPos(1, 18)
                topMonitor.write("Wrong Password, Try Again.")
                sleep(2)  -- Brief pause
                if attempts == 3 then
                    topMonitor.setCursorPos(1, 19)
                    topMonitor.write("Too many failed attempts.")
                    sleep(2)
                    topMonitor.clear()
                    return false
                end
            end
        elseif success == 2 then
            -- Handle disk removal scenario
            return false
        end
    end
end

-- Wait for disk to be inserted
function waitForDisk()
    while not diskDrive.isDiskPresent() do
        topMonitor.clear()
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("Please insert your disk...")
        os.pullEvent("disk")
    end
    -- Disk has been inserted, clear any old data
    username = nil
    password = nil
    hint = nil
    credits = 0
end

-- Main Program
function main()
    setupMonitors()
    waitForDisk()

    -- Parallel process to monitor disk removal and user actions
    parallel.waitForAny(
        function()
            -- When a disk is inserted, get its label
            local diskLabel = diskDrive.getDiskLabel()

            -- If the disk is not labeled (i.e., it's a new disk)
            if not diskLabel or diskLabel == "" then
                -- Clear any lingering data
                username = nil
                password = nil
                hint = nil
                credits = 0

                -- New disk detected, setup a new player
                local username = setupNewPlayerDisk()  -- Prompt to enter username, password, and hint
                topMonitor.clear()
                topMonitor.setCursorPos(1, 1)
                topMonitor.write("Welcome, " .. username)
                drawMainMenu()
                handleMainMenuTouch(username)
            else
                -- Existing disk detected, validate the user with a password
                local username = diskLabel
                if validateUserDisk(username) then
                    local credits = loadPlayerData(username)  -- Load the user's credits
                    displayMain(username, credits)  -- Display the user's info on the screen
                    drawMainMenu()  -- Draw the main menu
                    handleMainMenuTouch(username)  -- Handle user input for the menu
                else
                    -- If validation fails, return to startup
                    os.reboot()
                end
            end
        end,
        resetOnDiskRemove  -- Monitor for disk ejection and handle accordingly
    )
end

-------------------------------
-- Item Shop Logic
-------------------------------

-- Variables to track the selected item and quantity
local scrollPosition = 1  -- Start at the top of the list
local maxVisibleItems = 5  -- Number of items to display at once
local availableItems = {}  -- Store available items
local selectedQuantity = 1  -- Default to buying 1 item

-- Function to draw scrolling buttons for the item shop on the top monitor
function drawScrollButtons()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("[Scroll Up]")
    topMonitor.setCursorPos(1, 8)
    topMonitor.write("[Scroll Down]")
end

-- Variable to track whether the search mode is active
local isSearching = false

-- Function to toggle between Search and Exit Search buttons
function drawShopButtons(isSearching)
    leftMonitor.clear()

    if isSearching then
        -- Show the Exit Search button when in search mode
        leftMonitor.clear()
        leftMonitor.setCursorPos(1, 1)
        leftMonitor.write("[Exit Search]")
    else
        -- Show the normal Search button when not searching
        leftMonitor.clear()
        leftMonitor.setCursorPos(1, 1)
        leftMonitor.write("[Search]")
    end

    -- Other buttons (Sell and Exit) are always present
    leftMonitor.setCursorPos(1, 2)
    leftMonitor.write("[Sell]")
    leftMonitor.setCursorPos(1, 3)
    leftMonitor.write("[Exit]")
end

-- Function to save credits directly to the floppy disk in the drive
function saveCreditsToDisk(credits)
    local diskPath = diskDrive.getMountPath()  -- Get the disk's path
    if diskPath then
        local file = fs.open(diskPath .. "/credits.txt", "w")  -- Open or create 'credits.txt'
        file.writeLine(tostring(credits))  -- Write the credits as a string
        file.close()
    else
        print("No disk found.")
    end
end

-- Calculate how many credits the player would get from selling items in the input chest
function calculatePotentialSellCredits()
    local items = inputChest.list()  -- Get the list of items in the deposit chest
    local totalCredits = 0

    -- Loop through each item in the chest and calculate how many credits they would earn
    for slot, item in pairs(items) do
        local itemName = item.name
        local itemCount = item.count

        -- Check if the item has a set value for selling in the itemPrices table
        if itemPrices[itemName] then  -- Since there's no separate buy/sell price, use the value directly
            local itemCreditValue = itemPrices[itemName]  -- Use the price directly
            totalCredits = totalCredits + (itemCreditValue * itemCount)
        else
            print("Item " .. itemName .. " does not have a price.")  -- Debugging message
        end
    end

    return totalCredits
end

-- Function to load credits directly from the floppy disk
function loadCreditsFromDisk()
    local diskPath = diskDrive.getMountPath()
    if diskPath and fs.exists(diskPath .. "/credits.txt") then
        local file = fs.open(diskPath .. "/credits.txt", "r")
        local credits = tonumber(file.readLine())  -- Read the credits and convert to a number
        file.close()
        return credits
    else
        return 0  -- Default to 0 credits if no file exists
    end
end

-- Function to load the username from the floppy disk label
function loadUsernameFromDisk()
    local diskPath = diskDrive.getMountPath()
    if diskPath then
        return diskDrive.getDiskLabel() or "Unknown User"
    else
        return "Unknown User"
    end
end

-- Global table to hold item data
local shopItems = {}

-- Function to load item data from a text file
function loadItemData()
    if fs.exists("items.txt") then
        local file = fs.open("items.txt", "r")
        local itemData = file.readAll()
        file.close()

        -- Load the item data as a Lua table
        shopItems = textutils.unserialize(itemData)
    else
        print("No item data file found!")
    end
end

-- Function to get the item data by name
function getItemData(itemName)
    for _, item in pairs(shopItems) do
        if item.name == itemName then
            return item
        end
    end
    return nil
end

-- Function to consolidate duplicate items in the storage controller
function consolidateItems(itemsAvailable)
    if itemsAvailable == nil then
        print("Error: No items to consolidate (itemsAvailable is nil)")
        return nil
    end

    local consolidatedItems = {}

    for slot, item in pairs(itemsAvailable) do
        if itemPrices[item.name] then
            local found = false
            for _, consolidatedItem in pairs(consolidatedItems) do
                if consolidatedItem.name == item.name then
                    consolidatedItem.count = consolidatedItem.count + item.count  -- Add to existing item count
                    found = true
                    break
                end
            end

            if not found then
                table.insert(consolidatedItems, {
                    name = item.name,
                    count = item.count,
                    value = itemPrices[item.name],
                    slot = slot
                })
            end
        else
            print("Warning: Item not found in itemPrices: ", item.name)
        end
    end

    -- Check if consolidation produced any items
    if #consolidatedItems == 0 then
        print("Warning: No items were consolidated!")
    end

    return consolidatedItems
end

-- Function to get items from the storage controller
function getItemsFromStorage()
    local itemsAvailable = storageController.list()
    
    if itemsAvailable == nil then
        --print("Error: storageController.list() returned nil!")
        return {}  -- Return an empty table to avoid crashing
    end

    --print("Items from storage controller:")
    --for slot, item in pairs(itemsAvailable) do
    --    print("Slot: ", slot, "Item Name: ", item.name, "Count: ", item.count)
    --end

    local consolidatedItems = consolidateItems(itemsAvailable)

    -- Ensure consolidateItems is not returning nil
    if consolidatedItems == nil then
    --    print("Error: consolidateItems returned nil!")
        return {}  -- Return an empty table to avoid crashing
    end

    ---- Debug: Print all consolidated items
    --for _, item in pairs(consolidatedItems) do
    --    print("Available Item: ", item.name)
    --end

    return consolidatedItems
end

-- Function to calculate the monitor's width dynamically
function getMonitorWidth()
    local width, height = topMonitor.getSize()
    return width
end

-- Function to format item names for display
function formatItemName(itemName)
    -- Split the item name by ":" and take the part after the colon
    local splitName = itemName:match(":(.*)")

    -- Replace underscores with spaces
    local formattedName = splitName:gsub("_", " ")

    -- Capitalize the first letter of each word
    formattedName = formattedName:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)

    return formattedName
end

-- Display items from the Storage Controller in the Item Shop with a [Buy] button next to each
function displayShopItems(credits)
    local credits = loadCreditsFromDisk()
    availableItems = getItemsFromStorage()
    topMonitor.clear()
    drawScrollButtons()

    -- Display credits
    topMonitor.setCursorPos(1, 2)
    topMonitor.write("Credits: " .. credits)

    local availableItems = getItemsFromStorage()
    --print("Items available to display:", #availableItems)

    -- Get the monitor width
    local monitorWidth = getMonitorWidth()
    local y = 3
    local endPosition = math.min(scrollPosition + maxVisibleItems - 1, #availableItems)

        for i = scrollPosition, endPosition do
            local item = availableItems[i]
            topMonitor.setCursorPos(1, y)

            -- Format the item name for display (generate it here instead of using displayName)
            local formattedName = formatItemName(item.name)

            -- Retrieve item price from itemPrices table
            local itemPrice = itemPrices[item.name] or 0  -- Default to 0 if the item is not found in itemPrices

            -- Create the item info string
            local itemInfo = formattedName .. " x" .. item.count .. " Cost: " .. itemPrice .. " Credits"

            -- Write the item info
            topMonitor.write(itemInfo)

            -- Calculate the position for the [Buy] button dynamically
            local buyButtonPos = monitorWidth - string.len("[Buy]") - 1
            topMonitor.setCursorPos(buyButtonPos, y)
            topMonitor.write("[Buy]")

            -- Debugging: Print the calculated positions
            --print("Item:", item.name, "Buy Button Position:", buyButtonPos, "Y:", y)

            y = y + 1
        end
    -- Calculate potential sell value for items in the deposit chest
    local potentialSellCredits = calculatePotentialSellCredits()

    -- Display the total credits you can earn from selling items in the deposit chest
    --topMonitor.setCursorPos(1, y + 4)  -- Position below the last item
    --topMonitor.write("Sell items in Deposit chest for: " .. potentialSellCredits .. " Credits")

    -- Display watermark
    displayWatermark()
end

-- Function to monitor the input chest for changes
function monitorDepositChestAndUpdateSellValue()
    local lastInventory = inputChest.list()  -- Store initial chest state
    local lastSellValue = calculatePotentialSellCredits()  -- Calculate initial sell value

    -- Initial update of sell credits on screen
    --topMonitor.setCursorPos(1, 20)  -- Position below the item list
    --topMonitor.write("Sell items in Deposit chest for: " .. lastSellValue .. " Credits")

    -- Continuous loop to monitor chest changes
    while true do
        sleep(1)  -- Poll every second

        -- Get current chest state
        local currentInventory = inputChest.list()

        -- Check if the chest contents have changed by comparing with last inventory
        local inventoryChanged = false

        -- Simple comparison by checking if the number of items or their quantities have changed
        if #lastInventory ~= #currentInventory then
            inventoryChanged = true
        else
            for slot, item in pairs(currentInventory) do
                if not lastInventory[slot] or lastInventory[slot].count ~= item.count then
                    inventoryChanged = true
                    break
                end
            end
        end

        -- If there is any change in inventory, update the sell value
        if inventoryChanged then
            -- Calculate the new potential sell credits
            local potentialSellCredits = calculatePotentialSellCredits()

            -- Only update the display if the sell value has changed
            if potentialSellCredits ~= lastSellValue then
                lastSellValue = potentialSellCredits

                -- Update the display with the new sell value
                --topMonitor.setCursorPos(1, 20)
                --topMonitor.clearLine()  -- Clear the line before writing
                --topMonitor.write("Sell items in Deposit chest for: " .. potentialSellCredits .. " Credits")
            end

            -- Update lastInventory to the current state
            lastInventory = currentInventory
        end
    end
end

-- Call monitorDepositChestAndUpdateSellValue explicitly if you need it to update
function updateShopManuallyAfterSleep()
    sleep(5)  -- Let the shop idle for 5 seconds
    monitorDepositChestAndUpdateSellValue()  -- Force update
end

-- Function to sell items from the input chest and convert them to credits
function sellItems()
    local items = inputChest.list()  -- List all items in the input chest
    local creditsEarned = 0

    -- Loop through each slot in the input chest
    for slot, item in pairs(items) do
        local itemName = item.name
        local itemCount = item.count

        -- Check if the item has a price in the itemPrices table
        if itemPrices[itemName] then
            -- Calculate how many credits the player earns for this item
            local itemCreditValue = itemPrices[itemName] * itemCount
            creditsEarned = creditsEarned + itemCreditValue

            -- Move the items from the input chest to the storage controller
            inputChest.pushItems(peripheral.getName(storageController), slot)
        else
            -- Item without a price, output a warning or log it
            print("Warning: Item without price in itemPrices: ", itemName)
        end
    end

    -- Load player's current credits, add the new credits, and save
    local currentCredits = loadCreditsFromDisk()
    local newCreditBalance = currentCredits + creditsEarned
    saveCreditsToDisk(newCreditBalance)

    -- Update the display with new credits
    topMonitor.clear()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Credits Earned: " .. creditsEarned)
    topMonitor.setCursorPos(1, 2)
    topMonitor.write("New Balance: " .. newCreditBalance)
    sleep(2)

    -- Refresh the shop display
    displayShopItems(newCreditBalance)
end

-- Function to display the purchase screen and allow the user to select a quantity
function displayPurchaseScreen(item, username, credits, maxPurchaseQuantity)
    local quantity = 0
    local totalPrice = 0
    local remainingBalance = credits

    while true do
        topMonitor.clear()
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("User: " .. username)
        topMonitor.setCursorPos(1, 2)
        topMonitor.write("Credits: " .. credits)
        topMonitor.setCursorPos(1, 3)
        topMonitor.write("Buying: " .. item.name)
        topMonitor.setCursorPos(1, 4)
        topMonitor.write("Stock: " .. item.count)
        topMonitor.setCursorPos(1, 5)
        topMonitor.write("Quantity: " .. quantity)

        -- Display buttons for adjusting quantity
        topMonitor.setCursorPos(1, 6)
        topMonitor.write("[+1]  [+10]  [+64]")
        topMonitor.setCursorPos(1, 7)
        topMonitor.write("[-1]  [-10]  [-64]")

        -- Calculate total price and remaining balance
        totalPrice = quantity * itemPrices[item.name]
        remainingBalance = credits - totalPrice

        -- Display total price and remaining balance
        topMonitor.setCursorPos(1, 8)
        topMonitor.write("Total Price: " .. totalPrice)
        topMonitor.setCursorPos(1, 9)
        topMonitor.write("Remaining Balance: " .. remainingBalance)
        displayWatermark()

        -- Display confirm and back buttons
        topMonitor.setCursorPos(1, 10)
        topMonitor.write("[Confirm Purchase] [Back]")

        -- Wait for the user to make a selection
        local event, side, x, y = os.pullEvent("monitor_touch")

        if y == 6 then  -- Handle increasing quantity
            if x >= 1 and x <= 4 then
                quantity = math.min(quantity + 1, maxPurchaseQuantity)  -- Ensure it doesn't exceed max
            elseif x >= 7 and x <= 11 then
                quantity = math.min(quantity + 10, maxPurchaseQuantity)
            elseif x >= 14 and x <= 17 then
                quantity = math.min(quantity + 64, maxPurchaseQuantity)
            end
        elseif y == 7 then  -- Handle decreasing quantity
            if x >= 1 and x <= 4 then
                quantity = math.max(quantity - 1, 0)  -- Ensure quantity doesn't go below 0
            elseif x >= 7 and x <= 11 then
                quantity = math.max(quantity - 10, 0)
            elseif x >= 14 and x <= 17 then
                quantity = math.max(quantity - 64, 0)
            end
        elseif y == 10 then  -- Handle confirm or back buttons
            if x >= 1 and x <= 17 then
                return quantity  -- Return the selected quantity
            elseif x >= 20 and x <= 25 then
                return nil  -- User pressed back, return nil
            end
        end
    end
end

-- Draw the on-screen keyboard specifically for search input
function drawSearchKeyboard()
    -- Clear the monitor first
    topMonitor.clear()
    displayWatermark()

    -- Show the prompt for search input at the top
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Enter Search Query:")

    -- Draw letters (3 rows of letters)
    local letters = {
        "qwertyuiop",
        "asdfghjkl",
        "zxcvbnm"
    }
    
    -- Draw the letters on the top monitor (adjust x, y positions for rows)
    for row = 1, #letters do
        local y = row + 4  -- Start the keyboard lower on the screen (row 5)
        for i = 1, #letters[row] do
            local letter = letters[row]:sub(i, i)
            local x = (i * 3) - 2  -- Space out letters and adjust for alignment
            topMonitor.setCursorPos(x, y)
            topMonitor.write("[" .. letter .. "]")
        end
    end

    -- Draw numbers for search input (if needed)
    local numbers = "1234567890"
    topMonitor.setCursorPos(1, 3)  -- Numbers row above letters
    for i = 1, #numbers do
        local x = (i * 3) - 2  -- Space out numbers properly
        topMonitor.setCursorPos(x, 3)
        topMonitor.write("[" .. numbers:sub(i, i) .. "]")
    end

    -- Draw special controls (Backspace, Spacebar, and Submit)
    topMonitor.setCursorPos(1, 8)
    topMonitor.write("[           Space           ]")  -- Spacebar button
    
    topMonitor.setCursorPos(1, 9)
    topMonitor.write("[Backspace] [Submit]")
end

-- Function to handle input via on-screen keyboard for search
function handleSearchInput()
    displayWatermark()
    local input = ""  -- Store the input

    -- Initially display the prompt and input area
    updateSearchDisplay(input, "Enter Search Query:")

    while true do
        -- Wait for a touch event on the monitor
        local event, side, x, y = os.pullEvent("monitor_touch")

        -- Handle letter inputs
        if y >= 5 and y <= 7 then
            local row = y - 4
            local letters = {
                "qwertyuiop",
                "asdfghjkl",
                "zxcvbnm"
            }
            local letterIndex = math.ceil(x / 3)
            local letter = letters[row]:sub(letterIndex, letterIndex)
            if letter and letter ~= "" then
                input = input .. letter
                updateSearchDisplay(input, "Enter Search Query:")  -- Refresh display
            end
        -- Handle number inputs
        elseif y == 3 then
            local numbers = "1234567890"
            local numberIndex = math.ceil(x / 3)
            local number = numbers:sub(numberIndex, numberIndex)
            if number and number ~= "" then
                input = input .. number
                updateSearchDisplay(input, "Enter Search Query:")  -- Refresh display
            end
        -- Handle spacebar input
        elseif y == 8 then
            if x >= 2 and x <= 21 then
                input = input .. " "
                updateSearchDisplay(input, "Enter Search Query:")  -- Refresh display
            end
        -- Handle special buttons (Backspace and Submit)
        elseif y == 9 then
            if x >= 1 and x <= 11 then  -- Backspace button
                input = input:sub(1, -2)
                updateSearchDisplay(input, "Enter Search Query:")  -- Refresh display
            elseif x >= 13 and x <= 20 then  -- Submit button
                return input  -- Return the entered input
            end
        end
    end
end

function displayWatermark()
    local monitorWidth, monitorHeight = topMonitor.getSize()
    
    -- Set cursor to the bottom of the monitor and display the watermark
    topMonitor.setCursorPos(1, monitorHeight)  -- Position at the bottom row
    topMonitor.clearLine()  -- Clear any previous content on this line
    topMonitor.write("Not Affiliated with Mystian Fields")
end

-- Function to update the search query display
function updateSearchDisplay(searchQuery)
    topMonitor.setCursorPos(1, 2)
    topMonitor.clearLine()
    topMonitor.write("Search: " .. searchQuery)
end

-- Run the search screen
function runSearchScreen(credits)
    local credits = loadCreditsFromDisk()
    topMonitor.clear()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Enter Item to Search:")

    topMonitor.setCursorPos(1, 19)
    topMonitor.write("Credits: " .. credits)

    -- Draw the keyboard and handle input
    drawKeyboard()
    local searchQuery = handleKeyboardInput(nil)

    -- Run the search and display matching items
    displaySearchResults(searchQuery, credits)
end

-- Display the matching search results
function displaySearchResults(searchQuery, credits)
    topMonitor.clear()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Search: " .. searchQuery)

    -- Filter items based on search query (partial match)
    local filteredItems = {}
    for _, item in pairs(availableItems) do
        if string.find(item.name, searchQuery) then
            table.insert(filteredItems, item)
        end
    end

    -- Display the filtered items
    local y = 3
    for _, item in pairs(filteredItems) do
        topMonitor.setCursorPos(1, y)
        topMonitor.write(item.name .. " x" .. item.count .. " - " .. item.value .. " credits")
        y = y + 1
    end
    -- Display message to exit search
    topMonitor.setCursorPos(1, y + 2)  -- Add some space before the message
    topMonitor.write("To exit the search, Select Search again")
    -- Display watermark
    displayWatermark()
end

-- Adjust the quantity, ensuring it doesn't exceed stock or go below 1
function adjustQuantity(item, adjustment)
    selectedQuantity = math.max(1, math.min(selectedQuantity + adjustment, item.count))
end

-- Function to handle the buying process
function handleBuyItem(itemIndex, credits)
    local item = availableItems[itemIndex]
    local username = loadUsernameFromDisk()

    -- Retrieve the price for the selected item from the itemPrices table
    local itemPrice = itemPrices[item.name] or 0

    local stockAvailable = item.count
    -- Determine the max quantity to buy (either 64 or whatever is left in stock)
    local maxPurchaseQuantity = math.min(64, stockAvailable)

    -- Display the purchase screen to select quantity
    local selectedQuantity = displayPurchaseScreen(item, username, credits, maxPurchaseQuantity)

    -- If selectedQuantity is nil, it means the user pressed "Back"
    if selectedQuantity == nil then
        return credits  -- Return to the shop screen without making a purchase
    end

    -- Calculate total price and check if the customer has enough credits
    local totalPrice = selectedQuantity * itemPrice
    if credits < totalPrice then
        -- Not enough credits
        topMonitor.clear()
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("Not enough credits!")
        sleep(2)
        return credits
    end

    -- Perform the item transfer (up to 64 items at a time)
    local transferredQuantity = 0
    while transferredQuantity < selectedQuantity do
        -- Determine how many items to transfer (max 64 per transfer)
        local remainingQuantity = selectedQuantity - transferredQuantity
        local transferAmount = math.min(64, remainingQuantity)

        -- Attempt to transfer the items
        local transferred = storageController.pushItems(peripheral.getName(outputChest), item.slot, transferAmount)

        -- If no items were transferred, break the loop
        if transferred == 0 then
            break
        end

        -- Update the transferred quantity
        transferredQuantity = transferredQuantity + transferred
    end

    -- Check if the full quantity was transferred
    if transferredQuantity < selectedQuantity then
        topMonitor.clear()
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("Transfer failed. Only moved " .. transferredQuantity .. " items.")
        sleep(2)
        return credits
    end

    -- Deduct the total price from the player's credits
    credits = credits - totalPrice

    -- Update the item's count in the availableItems table
    item.count = item.count - selectedQuantity

    -- If the item count reaches 0, remove the item from the list
    if item.count <= 0 then
        table.remove(availableItems, itemIndex)
    end

    -- Save the updated credits to the disk
    saveCreditsToDisk(credits)

    -- Display purchase confirmation
    topMonitor.clear()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Purchase successful!")
    topMonitor.setCursorPos(1, 2)
    topMonitor.write("Remaining Credits: " .. credits)
    displayWatermark()
    sleep(2)

    -- Refresh the shop display
    displayShopItems(credits)

    return credits
end
-- Handle touch events in the shop
function handleShopTouch(credits)
    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")

        -- Debug: Show touch coordinates
        --print("Touch event: side =", side, "x =", x, "y =", y)

        if side == "top" then
            -- Handle scrolling
            if y == 1 then
                if scrollPosition > 1 then
                    scrollPosition = scrollPosition - 1
                    displayShopItems(credits)
                end
            elseif y == 8 then
                if scrollPosition + maxVisibleItems - 1 < #availableItems then
                    scrollPosition = scrollPosition + 1
                    displayShopItems(credits)
                end
            -- Handle [Buy] button press
            elseif y >= 3 and y <= 6 then  -- We expect buttons in this range
                local itemIndex = scrollPosition + (y - 3)

                -- Debug: Print index and item info
                --print("Checking Buy Button at X:", 46, "Touch X:", x)
                --print("Item Index:", itemIndex, "Total Items Available:", #availableItems)

                -- Ensure the item index is valid before proceeding
                if availableItems[itemIndex] then
                    print("Buying item:", availableItems[itemIndex].name)
                    credits = handleBuyItem(itemIndex, credits)
                    displayShopItems(credits)  -- Refresh the screen after buying
                else
                    print("Error: Item at index", itemIndex, "does not exist in availableItems.")
                end
            end
        elseif side == "left" then
            -- Handle actions on the left monitor
            if y == 1 then
                if isSearching then
                    leftMonitor.clear()
                    leftMonitor.setCursorPos(1, 1)
                    leftMonitor.write("[Exit Search]")
                    isSearching = false
                    handleClearSearch()
                else
                    isSearching = true
                    handleSearchMode()
                end
                drawShopButtons()
            elseif y == 2 then
                displaySellScreen(credits)
                displayShopItems(credits)
            elseif y == 3 then
                shell.run("startup")
            end
        end
    end
end


-- Function to handle search mode
function handleSearchMode()
    drawSearchKeyboard()  -- Draw the search keyboard
    local searchQuery = handleSearchInput()  -- Get the search query

    -- Filter and display the shop items based on the search query
    filterShopItems(searchQuery)
end

-- Function to filter items based on search query with debug prints
function filterShopItems(query)
    local credits = loadCreditsFromDisk()  -- Load current credits

    print("Search query:", query)  -- Debug print for the query

    -- Filter available items based on the query (case-insensitive match)
    local filteredItems = {}
    for _, item in pairs(getItemsFromStorage()) do
        if item and item.name then  -- Ensure item and item.name are not nil
            --print("Item: ", item.name)  -- Debug print to check each item's name
            if string.find(string.lower(item.name), string.lower(query)) then
                --print("Matched Item: ", item.name)  -- Debug print for matched items
                table.insert(filteredItems, item)
            end
        else
            print("Invalid item or missing name")  -- Debug print for invalid items
        end
    end

    -- Display filtered items
    displayFilteredShopItems(filteredItems, credits)
end

-- Function to display filtered items in the shop
function displayFilteredShopItems(filteredItems, credits)
    topMonitor.clear()
    drawScrollButtons()

    -- Display credits
    topMonitor.setCursorPos(1, 2)
    topMonitor.write("Credits: " .. credits)

    -- Get the monitor width
    local monitorWidth = getMonitorWidth()
    local y = 3

    -- Display filtered items
    if #filteredItems > 0 then
        for i, item in ipairs(filteredItems) do
            topMonitor.setCursorPos(1, y)

            -- Format the item name for display
            local formattedName = formatItemName(item.name)

            -- Retrieve item price from itemPrices table
            local itemPrice = itemPrices[item.name] or 0  -- Default to 0 if the item is not found in itemPrices

            -- Create the item info string
            local itemInfo = formattedName .. " x" .. item.count .. " Cost: " .. itemPrice .. " Credits"

            -- Calculate the position for the [Buy] button based on the monitor's width
            local buyButtonPos = monitorWidth - 5  -- Adjusted to fit [Buy] on the screen

            -- Write the item info and place the [Buy] button at the calculated position
            topMonitor.write(itemInfo)
            topMonitor.setCursorPos(buyButtonPos, y)
            topMonitor.write("[Buy]")

            y = y + 1
        end
    else
        -- If no items match the query
        topMonitor.setCursorPos(1, y)
        topMonitor.write("No items match your search.")
    end
end

function handleClearSearch()
    local credits = loadCreditsFromDisk()  -- Reload credits
    displayShopItems(credits)  -- Redisplay all items
    drawShopButtons(false)  -- Show normal buttons (not in search mode)
end

-- Run the Item Shop
function runItemShop()
    local credits = loadCreditsFromDisk()

    -- Load the item data from the text file
    loadItemData()

    -- Get the latest items from storage and display them
    getItemsFromStorage()
    displayShopItems(credits)

    -- Display Sell and Exit buttons on the left monitor
    drawShopButtons()

    -- Run both the shop interaction and deposit chest monitoring in parallel
    handleShopTouch(credits)  -- Handle touch events for buying/selling
end

-- Function to display the items in the deposit chest and the sell price
function displaySellScreen(credits)
    local credits = loadCreditsFromDisk()
    topMonitor.clear()  -- Clear the monitor for a new screen
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Items in Deposit Chest:")

    local items = inputChest.list()  -- Get the list of items in the deposit chest
    local y = 2  -- Start displaying items below the header
    local totalSellValue = 0  -- Track the total value of all items

    -- Loop through each item in the deposit chest
    for slot, item in pairs(items) do
        local itemName = formatItemName(item.name)
        local itemCount = item.count
        local itemPrice = itemPrices[item.name] and itemPrices[item.name] * itemCount or 0

        -- Add the item's sell value to the total
        totalSellValue = totalSellValue + itemPrice

        -- Display each item and its total value (price per item * count)
        topMonitor.setCursorPos(1, y)
        topMonitor.write(itemName .. " x" .. itemCount .. " Worth: " .. itemPrice .. " Credits")
        y = y + 1
    end

    -- Show current credits and projected credits after the sale
    topMonitor.setCursorPos(1, y + 1)
    topMonitor.write("Current Credits: " .. credits)

    -- Display projected credits after selling
    local creditsAfterSale = credits + totalSellValue
    topMonitor.setCursorPos(1, y + 2)
    topMonitor.write("Credits if Sold: " .. creditsAfterSale)
    displayWatermark()

    -- Draw Sell and Back buttons
    topMonitor.setCursorPos(1, y + 4)
    topMonitor.write("[Sell]")

    topMonitor.setCursorPos(10, y + 4)
    topMonitor.write("[Back]")

    -- Wait for a button press
    handleSellScreenTouch(credits)
end

-- Handle touch events for the sell screen
function handleSellScreenTouch(credits)
    -- Get the y position for the buttons (ensure it matches where buttons are drawn)
    local y = 3
    local buttonY = y + 6  -- This should match the y position of the buttons on the screen

    while true do
        local event, side, x, y = os.pullEvent("monitor_touch")

        -- Debugging: Print touch coordinates to ensure correct alignment
        --print("Touch event: x =", x, "y =", y)

        -- Check if [Sell] button is pressed
        if y == buttonY and x >= 1 and x <= 6 then
            -- Perform the sale (sell all items in the deposit chest)
            performSale(credits)
            return  -- Exit back to the main screen after selling
        end

        -- Check if [Back] button is pressed
        if y == buttonY and x >= 10 and x <= 15 then
            -- Go back to the main shop screen
            displayShopItems(credits)
            return
        end
    end
end

-- Function to sell items in the deposit chest and update the credits
function performSale(credits)
    local items = inputChest.list()  -- Get the list of items in the deposit chest
    local totalSellValue = 0
    local soldItems = false  -- Track if any items are sold

    -- Loop through each item in the chest and calculate the sell value
    for slot, item in pairs(items) do
        local itemName = item.name
        local itemCount = item.count

        -- Check if the item has a sell price and calculate the total value for that item
        if itemPrices[itemName] then
            local itemSellValue = itemPrices[itemName] * itemCount
            totalSellValue = totalSellValue + itemSellValue

            -- Move the items to the storage controller (or discard them, as needed)
            local transferred = inputChest.pushItems(peripheral.getName(storageController), slot, itemCount)
            if transferred > 0 then
                soldItems = true  -- Indicate that at least some items were sold
                -- Check if all items were transferred, if not, try again
                while transferred < itemCount do
                    local remainingCount = itemCount - transferred
                    transferred = transferred + inputChest.pushItems(peripheral.getName(storageController), slot, remainingCount)
                end
            else
                print("Failed to transfer " .. itemCount .. " of " .. itemName)
            end
        else
            --print("Item " .. itemName .. " does not have a sell price.")
        end
    end

    -- If no items were sold, return with a message
    if not soldItems then
        topMonitor.clear()
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("No valid items to sell.")
        sleep(2)
        displayShopItems()  -- Re-read credits from disk
        return
    end

    -- Update player's credits and save to disk
    local newCredits = loadCreditsFromDisk() + totalSellValue  -- Reload credits from disk before adding
    saveCreditsToDisk(newCredits)

    -- Display confirmation message on the screen
    topMonitor.clear()
    topMonitor.setCursorPos(1, 1)
    topMonitor.write("Sale Complete!")
    topMonitor.setCursorPos(1, 2)
    topMonitor.write("Total Credits Earned: " .. totalSellValue)
    topMonitor.setCursorPos(1, 3)
    topMonitor.write("New Balance: " .. newCredits)
    displayWatermark()

    sleep(3)  -- Wait for a few seconds before returning to the shop

    -- Return to the shop after the sale, re-reading the latest credits from disk
    displayShopItems()
end


-- Function to create an image file if it doesn't exist
function createImageIfMissing(imageName, imageData)
    if not fs.exists(imageName) then
        local fileHandle = fs.open(imageName, "w")
        if fileHandle then
            fileHandle.write(imageData)
            fileHandle.close()
            print("Image for " .. imageName .. " created successfully.")
        else
            print("Failed to create image for " .. imageName)
        end
    end
end

------------------
-- Slot Machine --
------------------

local lastReels = {"", "", ""}

local symbolWeights = {
    {symbol = "cow", weight = 25},
    {symbol = "sheep", weight = 25},
    {symbol = "creeper", weight = 25},
    {symbol = "steve", weight = 20},
    {symbol = "pig", weight = 20},
    {symbol = "money", weight = 10}
}
function getRandomSymbol()
    local totalWeight = 0
    for _, item in ipairs(symbolWeights) do
        totalWeight = totalWeight + item.weight
    end

    local randomWeight = math.random(1, totalWeight)
    local runningWeight = 0

    for _, item in ipairs(symbolWeights) do
        runningWeight = runningWeight + item.weight
        if randomWeight <= runningWeight then
            return item.symbol
        end
    end
end
local image_files = {
    cow = "000000000000000\n000000000000000\n000000000000000\n0000ccccccc0000\nff00ccccccc00ff\n000000000000000\n000000000000000\n0000ff888ff0000\n000088888880000\n000088888880000",
    creeper = "000000000000000\n00dffd000dffd00\n00ffff000ffff00\n00ffff000ffff00\n000000fff000000\n0000fffffff0000\n0000fffffff0000\n0000fffffff0000\n0000ff00dff0000\n000000000000000",
    pig = "000000000000000\n000000000000000\n000000000000000\n000000000000000\nff0000000000ff\n000066666660000\n0000ff666ff0000\n000066666660000\n000000000000000\n000000000000000",
    sheep = "000000000000000\n000000000000000\n000000000000000\n00ff00ccc00ff00\n00ccccccccccc00\n0000cc666cc0000\n0000cc666cc0000\n000000000000000\n000000000000000\n000000000000000",
    steve = "000000000000000\n000000000000000\n001111111111100\n001111111111100\n111111111111111\n1100bb111bb0011\n111111777111111\n1111cc666cc1111\n1111ccccccc1111\n1111ccccccc1111",
    money = "000000000000000\n000500050005000\n005550055505500\n005000500050000\n005550055505500\n000050005000500\n005550055505500\n000500050005000\n000000000000000\n000000000000000",
    heads = "000000000000000\n000000000000000\n000000000000000\n0000hhhhhhh0000\nhh00hhhhhhh00hh\n000000000000000\n000000000000000\n0000hhhhh000000\n0000hhhhh000000\n000000000000000",
    tails = "000000000000000\n000000000000000\n000000000000000\n0000ttttttt0000\ntt00ttttttt00tt\n000000000000000\n000000000000000\n0000ttttt000000\n0000ttttt000000\n000000000000000"
}
function createImageIfMissing(imageName, imageData)
    if not fs.exists(imageName) then
        local fileHandle = fs.open(imageName, "w")
        if fileHandle then
            fileHandle.write(imageData)
            fileHandle.close()
        else
            print("Error: Failed to create image for " .. imageName)
        end
    end
end
local bet = 1
local freeSpins = 0
function displayBetAndFreeSpins()
   -- paintutils.drawLine(X1/2, Y1/1.75, X1/1.001, Y1/1.75, colors.gray)
    topMonitor.setCursorPos(X1/1.95, Y1/1.35)
    topMonitor.write("Current Bet: " .. bet .. " credits")
    displayWatermark()
end
function drawButtons()
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    local screenWidth, screenHeight = topMonitor.getSize()
    local spinButtonX = math.floor((screenWidth / 2) - 8)
    local backButtonX = math.floor((screenWidth / 2) + 2)
    topMonitor.setCursorPos(spinButtonX, 15)
    topMonitor.write("[ Spin ]")
    topMonitor.setCursorPos(backButtonX, 15)
    topMonitor.write("[ Back ]")
    topMonitor.setCursorPos(spinButtonX, 17)
    topMonitor.write("[ + Bet ]")
    topMonitor.setCursorPos(backButtonX, 17)
    topMonitor.write("[ - Bet ]")
end
function handleButtonClick(x, y)
    local screenWidth, screenHeight = topMonitor.getSize()
    local spinButtonX = math.floor((screenWidth / 2) - 8)
    local backButtonX = math.floor((screenWidth / 2) + 2)
    local buttonY = 15
    if x >= spinButtonX and x <= (spinButtonX + 7) and y == buttonY then
        return "spin"
    end
    if x >= backButtonX and x <= (backButtonX + 7) and y == buttonY then
        return "back"
    end
    if x >= spinButtonX and x <= (spinButtonX + 7) and y == 17 then
        return "increase_bet"
    end
    if x >= backButtonX and x <= (backButtonX + 7) and y == 17 then
        return "decrease_bet"
    end
    return nil
end
function animateSlotMachine()
    local options = {"pig", "sheep", "creeper", "steve", "cow"}
    local reels = {}
    for k, v in pairs(image_files) do
        createImageIfMissing(k, v)
    end
    term.redirect(topMonitor)
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    topMonitor.clear()
    for spin = 1, 10 do
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.clear()
        topMonitor.setCursorPos(1, 1)
        topMonitor.write("Spinning the reels...")
        displayWatermark()
        local slot1 = paintutils.loadImage(options[math.random(#options)])
        local slot2 = paintutils.loadImage(options[math.random(#options)])
        local slot3 = paintutils.loadImage(options[math.random(#options)])
        if slot1 and slot2 and slot3 then
            paintutils.drawImage(slot1, 2, 3)
            paintutils.drawImage(slot2, 22, 3)
            paintutils.drawImage(slot3, 42, 3)
        else
            topMonitor.setCursorPos(1, 5)
            topMonitor.write("Error: Could not load one or more images.")
        end

        sleep(0.2)
    end
    for i = 1, 3 do
        table.insert(reels, options[math.random(#options)])
    end
    local slot1 = paintutils.loadImage(reels[1])
    local slot2 = paintutils.loadImage(reels[2])
    local slot3 = paintutils.loadImage(reels[3])
    if slot1 and slot2 and slot3 then
        paintutils.drawImage(slot1, 2, 3)
        paintutils.drawImage(slot2, 22, 3)
        paintutils.drawImage(slot3, 42, 3)
    else
        topMonitor.setCursorPos(1, 5)
        topMonitor.write("Error: Could not load final images.")
    end
    lastReels = finalReels
    return reels
end

function displayFinalResult(reels, creditsAfter)
    lastReels = reels
    topMonitor.setBackgroundColor(colors.black)
    topMonitor.setTextColor(colors.white)
    topMonitor.clear()
    topMonitor.setCursorPos(1, 18)
    topMonitor.write("Results:")
    paintutils.drawFilledBox(2, 3, 16, 12, colors.black)
    paintutils.drawFilledBox(22, 3, 36, 12, colors.black)
    paintutils.drawFilledBox(42, 3, 56, 12, colors.black)
    local slot1 = paintutils.loadImage(reels[1])
    local slot2 = paintutils.loadImage(reels[2])
    local slot3 = paintutils.loadImage(reels[3])
    if slot1 and slot2 and slot3 then
        drawReelImage(slot1, 2, 3, 16, 12)
        drawReelImage(slot2, 22, 3, 36, 12)
        drawReelImage(slot3, 42, 3, 56, 12)
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.setTextColor(colors.white)
        topMonitor.setCursorPos(1, 19)
        topMonitor.write("Credits befor Results: " .. creditsAfter)
        displayWatermark()
    else
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.setTextColor(colors.white)
        topMonitor.setCursorPos(1, 21)
        topMonitor.write("Error: Could not load final images.")
        displayWatermark()
    end
end
-- Function to display the last spin result
function displayLastResult()
    if lastReels then
        -- Use the keys in lastReels to fetch the image data from image_files
        local slot1Data = image_files[lastReels[1]]  -- Get the image for the first reel
        local slot2Data = image_files[lastReels[2]]  -- Get the image for the second reel
        local slot3Data = image_files[lastReels[3]]  -- Get the image for the third reel

        -- Draw each reel image in its respective position on the screen
        if slot1Data then
            paintutils.drawImage(paintutils.parseImage(slot1Data), 2, 3)   -- Draw at first reel position
        end
        if slot2Data then
            paintutils.drawImage(paintutils.parseImage(slot2Data), 22, 3)  -- Draw at second reel position
        end
        if slot3Data then
            paintutils.drawImage(paintutils.parseImage(slot3Data), 42, 3)  -- Draw at third reel position
        end
    end
end

-- Function to handle spinning the slot machine
function handleSpin()
    -- Animate the slot machine and get the final result of the reels
    local finalReels = animateSlotMachine()
    lastReels = finalReels

    -- Determine win/loss based on the reels and bet
    local creditsAfter = determineOutcome(finalReels, credits, bet)

    -- Display the final result
    displayFinalResult(finalReels, creditsAfter)

    -- Update credits for the next loop
    credits = creditsAfter
end

function drawReelImage(image, x1, y1, x2, y2)
    for y, row in ipairs(image) do
        for x, pixel in ipairs(row) do
            local targetX = x1 + x - 1
            local targetY = y1 + y - 1
            if targetX >= x1 and targetX <= x2 and targetY >= y1 and targetY <= y2 then
                topMonitor.setCursorPos(targetX, targetY)
                topMonitor.setBackgroundColor(pixel)
                topMonitor.write(" ")
            end
        end
    end
end

function determineOutcome(reels, credits, bet)
    local n_one, n_two, n_three = reels[1], reels[2], reels[3]
    if n_one == n_two and n_two == n_three then
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.setTextColor(colors.white)
        topMonitor.setCursorPos(1, 17)
        topMonitor.write("Jackpot! You win " .. (7 * bet) .. " credits!")
        credits = credits + (7 * bet)
    elseif n_one == n_two or n_two == n_three or n_one == n_three then
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.setTextColor(colors.white)
        topMonitor.setCursorPos(1, 17)
        topMonitor.write("You win " .. (3 * bet) .. " credits!")
        credits = credits + (3 * bet)
    else
        local chance = math.random(1, 100)
        if chance <= 10 then
            topMonitor.setBackgroundColor(colors.black)
            topMonitor.setTextColor(colors.white)
            topMonitor.setCursorPos(1, 17)
            topMonitor.write("Near miss! You win " .. (1 * bet) .. " credits!")
            credits = credits + (1 * bet)
        else
            topMonitor.setBackgroundColor(colors.black)
            topMonitor.setTextColor(colors.white)
            topMonitor.setCursorPos(1, 17)
            topMonitor.write("You lose!")
        end
    end
    saveCreditsToDisk(credits)
    --paintutils.drawLine(X1/30, Y1/1.75, X1/2, Y1/1.75, colors.gray)
    topMonitor.setCursorPos(X1/30, Y1/1.35)
    topMonitor.write("Remaining Credits: " .. credits)
    return credits
end

function runSlotMachine(player)
    local credits = loadCreditsFromDisk()
    

    while true do
        topMonitor.setBackgroundColor(colors.black)
        topMonitor.setTextColor(colors.white)
        topMonitor.clear()
        --paintutils.drawFilledBox(X1/30, Y1/9, X1/1.001, Y1/2, colors.white)
        --paintutils.drawLine(X1/30, Y1/9, X1/30, Y1/2, colors.green)
        --paintutils.drawLine(X1/1.001, Y1/9, X1/1.001, Y1/2, colors.green)
        --paintutils.drawLine(X1/30, Y1/2, X1/1.001, Y1/2, colors.green)
        --paintutils.drawLine(X1/30, Y1/9, X1/1.001, Y1/9, colors.green)
        drawButtons()
        displayBetAndFreeSpins()
        --paintutils.drawLine(X1/30, Y1/1.75, X1/2, Y1/1.75, colors.gray)
        topMonitor.setCursorPos(X1/30, Y1/1.35)
        topMonitor.write("Remaining Credits: " .. credits)
        --displayLastResult()

        local event, side, x, y = os.pullEvent("monitor_touch")
        local action = handleButtonClick(x, y)
        if action == "spin" then
            if freeSpins > 0 then
                freeSpins = freeSpins - 1
            else
                if credits < bet then
                    topMonitor.clear()
                    topMonitor.setCursorPos(1, 2)
                    topMonitor.write("Not enough credits!")
                    sleep(2)
                    drawButtons()
                    displayBetAndFreeSpins()
                    goto continue
                else
                    credits = credits - bet
                    saveCreditsToDisk(credits)
                end
            end

            topMonitor.setBackgroundColor(colors.black)
            topMonitor.clear()
            topMonitor.setCursorPos(1, 2)
            topMonitor.write("Spinning...")

            local finalReels = animateSlotMachine()
            lastReels = finalReels 
            local creditsAfter = determineOutcome(finalReels, credits, bet)

            if finalReels[1] == "money" and finalReels[2] == "money" and finalReels[3] == "money" then
                local chance = math.random(1, 100)
                local threshold = 100 - bet
                if chance <= threshold then
                    freeSpins = freeSpins + math.floor(bet / 10)
                    topMonitor.setCursorPos(1, 4)
                    topMonitor.write("Free Spins Awarded: " .. freeSpins)
                else
                    topMonitor.setCursorPos(1, 4)
                    topMonitor.write("No Free Spins Awarded.")
                end
            end
            credits = creditsAfter
            sleep(2)
        elseif action == "increase_bet" then
            bet = bet + 10
            if bet > 100 then
                bet = 100
            end
        elseif action == "decrease_bet" then
            bet = bet - 10
            if bet < 1 then
                bet = 1
            end
        elseif action == "back" then
            shell.run("startup")
            return
        end
        --displayLastResult()
        displayWatermark()
        ::continue::
        displayWatermark()
        --displayLastResult()
    end
end

main()
