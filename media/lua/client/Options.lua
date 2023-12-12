if ModOptions and ModOptions.getInstance then
    local function applyModOptions(updateData)
        local newValues = updateData.settings.options

        NoropiaHotkeys.Options.notebookName = newValues.notebookName
    end

    -- See ModOptions documentation thread here:
    -- https://steamcommunity.com/workshop/filedetails/discussion/2169435993/4260919351480715709/
    local SETTINGS = {
        options_data = {
            notebookName = {
                default = "Field Notes",
                name = "Notebook name",
                tooltip = "Notebook name to open, if using 'Open notebook by name' setting.",
                OnApplyMainMenu = applyModOptions,
                OnApplyInGame = applyModOptions,
            },
        },
        mod_id = "NoropiaHotkeys",
        mod_shortname = "Noropia Hotkeys",
        mod_fullname = "Noropia Hotkeys"
    }

    local optionsInstance = ModOptions:getInstance(SETTINGS)

    ModOptions:loadFile()

    Events.OnGameStart.Add(
        function()
            applyModOptions({ settings = SETTINGS })
        end
    )
end
