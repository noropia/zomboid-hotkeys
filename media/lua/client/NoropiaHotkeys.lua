require "Options"

NoropiaHotkeys = NoropiaHotkeys or {}

--- Get the name of the main notebook based on the selected option in the settings.
--- @return string Name of main notebook
NoropiaHotkeys.getMainNotebookName = function()
    local nameOptions = {
        "My Notes",
        "My Notebook",
        "Survivor Notes"
    }

    return nameOptions[NoropiaHotkeys.settings.mainNotebookName]
end

--- Get the types of notebook items based on the selected option in the settings.
--- @return table Table containing the full type name of each item, i.e, Main.Notebook, Main.Journal
NoropiaHotkeys.getNotebookItemTypes = function()
    local typeOptions = {
        "Main.Notebook",
        "Main.Journal",
        "Main.Notebook,Main.Journal"
    }

    local optionString = typeOptions[NoropiaHotkeys.settings.notebookItemTypes]
    local typeNames = {}

    -- Question: Where the fuck is string.split(',')
    -- https://stackoverflow.com/questions/19262761/lua-need-to-split-at-comma
    for typeName in string.gmatch(optionString, '([^,]+)') do
        typeName = string.gsub(typeName, "%s+", "")
        table.insert(typeNames, typeName)
    end

    return typeNames
end

--- Get the name of the project notebook based on the selected option in settings.
--- @return string Name of project notebook
NoropiaHotkeys.getProjectNotebookName = function()
    -- local value = NoropiaHotkeys.settings.projectNotebookName
    local nameOptions = {
        "My Projects",
        "Projects",
        "Tasks"
    }

    return nameOptions[NoropiaHotkeys.settings.projectNotebookName]
end

--- Get the name of the item list notebook based on selected option in settings.
--- @return string Name of item list notebook
NoropiaHotkeys.getItemListNotebookName = function()
    local nameOptions = {
        "Items List",
        "Shopping List",
        "Materials List",
        "Loot Tracker",
        "Wishlist"
    }

    return nameOptions[NoropiaHotkeys.settings.itemListNotebookName]
end

--- Get the name of the journal notebook based on selected option in settings.
--- @return string Name of journal notebook
NoropiaHotkeys.getJournalNotebookName = function()
    local nameOptions = {
        "My Journal",
        "Journal",
        "Survivor Journal"
    }

    return nameOptions[NoropiaHotkeys.settings.journalNotebookName]
end

--- Open a notebook by name.
--- @param notebookName string Name of notebook to open
--- @return nil
NoropiaHotkeys.openNotebookByName = function(notebookName)
    local player = getPlayer()
    local inventory = player:getInventory()
    local itemsFromFullType = inventory:getItemsFromFullType('Base.Notebook')
    local notebookFound = false

    -- Iterate through all notebooks in inventory to find the notebook by name
    for i = 0, itemsFromFullType:size() - 1 do
        local current_item = itemsFromFullType:get(i)
        local current_name = current_item:getName()

        if current_name == notebookName then
            notebookFound = true

            ISInventoryPaneContextMenu.onWriteSomething(current_item, true, player:getPlayerNum())
            -- HaloTextHelper.addTextWithArrow(player, string.format("Ah, here it is! %s", notebookName), true, HaloTextHelper.getColorGreen())
        end
    end

    -- Handle case where notebook is not found
    if not notebookFound then
        player:Say(string.format("I can't find that '%s' notebook anywhere.", notebookName))
    end
end

--- Open the main notebook.
--- @return nil
NoropiaHotkeys.openMainNotebook = function()
    NoropiaHotkeys.openNotebookByName(NoropiaHotkeys.getMainNotebookName())
end

--- Open the project notebook.
--- @return nil
NoropiaHotkeys.openProjectNotebook = function()
    NoropiaHotkeys.openNotebookByName(NoropiaHotkeys.getProjectNotebookName())
end

--- Open the item list notebook.
--- @return nil
NoropiaHotkeys.openItemListNotebook = function()
    NoropiaHotkeys.openNotebookByName(NoropiaHotkeys.getItemListNotebookName())
end

--- Open the journal notebook.
--- @return nil
NoropiaHotkeys.openJournalNotebook = function()
    NoropiaHotkeys.openNotebookByName(NoropiaHotkeys.getJournalNotebookName())
end

-- Build keybind configuration for plugin
NoropiaHotkeys.keyConfigs = {
    openMainNotebook = {
        isHotAction = false,
        isFlexKey = false,
        action = NoropiaHotkeys.openMainNotebook,
        displayName = "Open player notes.",
        keyCode = 0
    },
    openNotebook = {
        isHotAction = false,
        isFlexKey = false,
        action = NoropiaHotkeys.openProjectNotebook,
        displayName = "Open project notes.",
        keyCode = 0
    },
    openItemListNotebook = {
        isHotAction = false,
        isFlexKey = false,
        action = NoropiaHotkeys.openItemListNotebook,
        displayName = "Open item list notebook.",
        keyCode = 0
    },
    openJournalNotebook = {
        isHotAction = false,
        isFlexKey = false,
        action = NoropiaHotkeys.openJournalNotebook,
        displayName = "Open player journal",
        keyCode = 0
    },
}

-- Register keybinds as a plugin with EHK
if EHK_Plugin then
    EHK_Plugin:AddConfigs(NoropiaHotkeys.keyConfigs)
end
