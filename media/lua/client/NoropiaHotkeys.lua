require "Options"

NoropiaHotkeys = NoropiaHotkeys or {}

-- Add function for plugin behavior
NoropiaHotkeys.openNotebook = function()
    local player = getPlayer()
    local inventory = player:getInventory()
    local itemsFromFullType = inventory:getItemsFromFullType('Base.Notebook')

    for i = 0, itemsFromFullType:size() - 1 do
        local current_item = itemsFromFullType:get(i)
        local current_name = current_item:getName()

        if current_name == NoropiaHotkeys.Options.notebookName then
            ISInventoryPaneContextMenu.onWriteSomething(current_item, true, player:getPlayerNum())
        end
    end
end

-- Build keybind configuration for plugin
local keyConfigs = {
    openNotebook = {
        isHotAction = false,
        isFlexKey = true,
        action = NoropiaHotkeys.openNotebook,
        displayName = "Open notebook",
        keyCode = 0
    }
}

-- Register keybinds as a plugin with EHK
if EHK_Plugin then
    EHK_Plugin:AddConfigs(keyConfigs)
end
