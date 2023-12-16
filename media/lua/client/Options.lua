NoropiaHotkeys = NoropiaHotkeys or {}
NoropiaHotkeys.settings = NoropiaHotkeys.settings or {}

-- Enable debug mode (prints extra info to console)
NoropiaHotkeys.settings.debug = false

-- Search for notebook by name, instead of first notebook found.
NoropiaHotkeys.settings.openNotebookByName = true

-- Full type to use when searching inventory for notebook (Main.Notebook, Main.Journal, Main.Paper, etc.)
NoropiaHotkeys.settings.notebookItemTypes = 1

-- Name of the main notebook to open
-- 1 = "My Notes", 2 = "My Notebook", 3 = "Survivor Notes"
NoropiaHotkeys.settings.mainNotebookName = 1

-- Name of the shopping list notebook to open
-- 1 = "Shopping List", 2 = "Materials Needed", 3 = "Wishlist"
NoropiaHotkeys.settings.itemListNotebookName = 1

-- Name of the project notebook to open
-- 1 = "Projects", 2 = "My Projects", 3 = "Tasks"
NoropiaHotkeys.settings.projectNotebookName = 1

-- Name of the journal notebook to open
-- 1 = "My Journal", 2 = "Journal", 3 = "Diary", 4 = "My Diary"
NoropiaHotkeys.settings.journalNotebookName = 1

-- Append time to new lines in journal
NoropiaHotkeys.settings.addTimestampToNewLines = true

-- Configure ModOptions
-- Default values are set above, even if ModOptions isn't installed
if ModOptions and ModOptions.getInstance then
    local function onModOptionsApply(optionValues)
        NoropiaHotkeys.settings.debug = optionValues.settings.options.debug
        NoropiaHotkeys.settings.openNotebookByName = optionValues.settings.options.openNotebookByName
        NoropiaHotkeys.settings.notebookItemTypes = optionValues.settings.options.notebookItemTypes
        NoropiaHotkeys.settings.mainNotebookName = optionValues.settings.options.mainNotebookName
        NoropiaHotkeys.settings.itemListNotebookName = optionValues.settings.options.itemListNotebookName
        NoropiaHotkeys.settings.projectNotebookName = optionValues.settings.options.projectNotebookName
        NoropiaHotkeys.settings.journalNotebookName = optionValues.settings.options.journalNotebookName
        NoropiaHotkeys.settings.addTimestampToNewLines = optionValues.settings.options.addTimestampToNewLines

        print(string.format("[NoropiaHotkeys] ModOptions settings applied. New settings:\n"))

        for _, option in ipairs(optionValues.settings.options) do
            print(string.format("[NoropiaHotkeys] %s => [%s]", option.name, tostring(option.value)))
        end
    end

    local SETTINGS = {
        options_data = {
            -- TODO: Add function (and option) to toggle between notebooks
            -- TODO: Add function (and option) to toggle notebook UI instead of opening multiples
            openNotebookByName = {
                name = "Open Notebook By Name",
                tooltip = "Search for notebooks by name instead of the first notebook found.",
                default = true,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
            -- TODO: Add conditional to openNotebookByName based on NoropiaHotkeys.settings.notebookItemTypes
            -- TODO: Get actual FullType names from the game
            -- Full type to use when searching inventory for notebook (Main.Notebook, Main.Journal, Main.Paper, etc.)
            notebookItemTypes = {
                "Main.Notebook",
                "Main.Journal",
                "Main.Notebook,Main.Journal", -- Base.SheetPaper2
                name = "Included Item Types",
                tooltip = "What items are included when searching player inventory for writeable items.",
                default = 1,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
            -- 1 = "My Notes", 2 = "My Notebook", 3 = "Survivor Notes"
            mainNotebookName = {
                "My Notes",
                "My Notebook",
                "Survivor Notes",
                name = "Main Notebook Name",
                tooltip = "Name of the main notebook to open.",
                default = 1,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
            -- 1 = "Shopping List", 2 = "Materials Needed", 3 = "Wishlist"
            itemListNotebookName = {
                "Items List",
                "Shopping List",
                "Materials List",
                "Loot Tracker",
                "Wishlist",
                name = "Item List Notebook Name",
                tooltip = "Name of the shopping list notebook to open.",
                default = 1,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
            -- 1 = "Projects", 2 = "My Projects", 3 = "Tasks"
            projectNotebookName = {
                "My Projects",
                "Projects",
                "Tasks",
                name = "Project Notebook Name",
                tooltip = "Name of the project notebook to open.",
                default = 1,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
            -- 1 = "My Journal", 2 = "Journal", 3 = "Diary", 4 = "My Diary"
            journalNotebookName = {
                "My Journal",
                "Journal",
                "Diary",
                name = "Daily Journal Notebook Name",
                tooltip = "Name of the journal notebook to open.",
                default = 1,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
            -- Not yet implemented
            addTimestampToNewLines = {
                name = "Add Timestamp to New Entries",
                tooltip = "Prefix new entries with the current (game) time.",
                default = true,
                OnApplyMainMenu = onModOptionsApply,
                OnApplyInGame = onModOptionsApply
            },
        },
        mod_id = 'NoropiaHotkeys',
        mod_shortname = 'Noropia Hotkeys',
        mod_fullname = 'Noropia Hotkeys',
    }

    ModOptions:getInstance(SETTINGS)
    ModOptions:loadFile()

    Events.OnGameStart.Add(function()
        onModOptionsApply({ settings = SETTINGS })
    end)
end
