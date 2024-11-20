
# **Item Shop & Casino by Mr_Bubba**

This program for **ComputerCraft** in Minecraft combines an **item shop** and a **casino** system. It allows players to:
- Convert items into credits.
- Spend credits to play casino games.
- Purchase items with credits.

## **Features**
### **Shop**
- Players can trade items for credits (conversion rates customizable).
- Use credits to buy items from a predefined inventory.
- Fully automated: items are dispensed from a connected storage system.

### **Casino**
- Offers gambling options (e.g., slot machines).
- Players can win or lose credits.
- Built-in configuration for casino games.

### **Persistent Data**
- Stores player balances and statistics using a disk drive.
- Ensures progress is saved between server restarts.

---

## **Setup Instructions**
### **1. Peripheral Connections**
Attach the following peripherals to the computer:
- **Monitors**:
  - **Left Monitor**: 1x2 monitor for legacy displays (optional).
  - **Top Monitor**: 2x3 monitor as the primary interface.
- **Disk Drive**: Place on the **right** of the computer for data storage.
- **Input Chest**: (`minecraft:chest_2`) Used for item-to-credit conversion.
- **Output Chest**: (`minecraft:chest_3`) Dispenses purchased items.
- **Storage Controller**: (`sophisticatedstorage:controller_0`) Handles item storage for the shop.

### **2. Install the Script**
1. Copy the script to the computer.
2. Save it as `startup.lua`.
3. Reboot the computer to automatically launch the program.

### **3. Configure Item Prices**
Edit the `itemPrices` table in the script to define conversion rates:
```lua
itemPrices = {
    ["minecraft:dirt"] = 1,
    ["minecraft:stone"] = 2,
    ["minecraft:diamond"] = 50,
    -- Add more items here
}
```

### **4. Start the Program**
Once the computer is rebooted, the system will:
- Display the interface on the top monitor.
- Handle item-to-credit conversion, casino games, and item purchases.

---

## **Program Functions**
### **1. Player Account Management**
- **Balance Tracking**: Each player has a unique account stored on a disk.
- **Add/Remove Credits**: Credits are added for deposited items or casino wins and deducted for purchases or losses.

### **2. Item Shop**
- Items are priced in credits (see `itemPrices` table).
- Players purchase items through the output chest.
- Automatically pulls items from the **sophisticated storage controller**.

### **3. Casino Games**
#### Slot Machine
- Players gamble credits for a chance to win more.
- Outcomes are randomized:
  - **Jackpot**: Earns a large payout.
  - **Loss**: Deducts credits.
  - **Bonus**: Awards a small prize or free spin.

### **4. File Persistence**
- **Player Data**: Balances and statistics are saved to the disk drive.
- **Logs**: Tracks transactions and game outcomes for troubleshooting.

---

## **Detailed Code Breakdown**
### **Peripheral Setup**
This ensures all peripherals are correctly connected:
```lua
leftMonitor = peripheral.wrap("left")
topMonitor = peripheral.wrap("top")
diskDrive = peripheral.wrap("right")
inputChest = peripheral.wrap("minecraft:chest_2")
outputChest = peripheral.wrap("minecraft:chest_3")
storageController = peripheral.wrap("sophisticatedstorage:controller_0")
```

### **Key Functions**
#### Item-to-Credit Conversion
Handles converting deposited items into credits:
```lua
function convertItemsToCredits()
    local items = inputChest.list()
    for slot, item in pairs(items) do
        local price = itemPrices[item.name]
        if price then
            local credits = price * item.count
            addCreditsToPlayer(credits)
            inputChest.remove(slot, item.count)
        end
    end
end
```

#### Adding Credits
Adds credits to the player’s balance:
```lua
function addCreditsToPlayer(amount)
    local playerData = readPlayerData()
    playerData.balance = playerData.balance + amount
    writePlayerData(playerData)
end
```

#### Purchasing Items
Handles item purchases:
```lua
function purchaseItem(itemName, quantity)
    local cost = itemPrices[itemName] * quantity
    local playerData = readPlayerData()
    if playerData.balance >= cost then
        if storageController.pullItems("outputChest", itemName, quantity) then
            playerData.balance = playerData.balance - cost
            writePlayerData(playerData)
        else
            print("Not enough items in stock.")
        end
    else
        print("Insufficient credits.")
    end
end
```

#### Casino Slot Machine
Simulates the slot machine game:
```lua
function playSlotMachine()
    local result = math.random(1, 100)
    if result <= 5 then
        awardJackpot()
    elseif result <= 20 then
        awardSmallPrize()
    else
        deductCredits(10)
    end
end
```

#### File I/O for Persistence
Reads and writes player data to the disk:
```lua
function readPlayerData()
    local file = fs.open("disk/playerData", "r")
    local data = textutils.unserialize(file.readAll())
    file.close()
    return data or { balance = 0 }
end

function writePlayerData(data)
    local file = fs.open("disk/playerData", "w")
    file.write(textutils.serialize(data))
    file.close()
end
```

---

## **Customizations**
- Add or modify items in the `itemPrices` table.
- Adjust slot machine probabilities for more balanced gameplay.
- Customize monitor messages and visuals for a unique experience.

---

## **Final Notes**
This script is designed for **ComputerCraft enthusiasts** looking to add a functional and interactive system to their Minecraft worlds. It provides an excellent combination of commerce and entertainment for servers.
