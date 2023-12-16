require "Options"

NoropiaHotkeys = NoropiaHotkeys or {}

--- Debug function to print the current notebook item types.
--- @return nil
NoropiaHotkeys.debugNotebookItemTypes = function()
    local mainNotebookName = NoropiaHotkeys.getMainNotebookName()
    local projectNotebookName = NoropiaHotkeys.getProjectNotebookName()
    local itemListNotebookName = NoropiaHotkeys.getItemListNotebookName()
    local journalNotebookName = NoropiaHotkeys.getJournalNotebookName()
    local notebookItemTypes = NoropiaHotkeys.getNotebookItemTypes()

    if (NoropiaHotkeys.settings.notebookItemTypes == nil) then
        print("[NoropiaHotkeys] notebookItemTypes is nil")
        return
    end

    print(string.format("[NoropiaHotkeys] mainNotebookName => [%s]", mainNotebookName))
    print(string.format("[NoropiaHotkeys] projectNotebookName => [%s]", projectNotebookName))
    print(string.format("[NoropiaHotkeys] itemListNotebookName => [%s]", itemListNotebookName))
    print(string.format("[NoropiaHotkeys] journalNotebookName => [%s]", journalNotebookName))
    print(string.format("[NoropiaHotkeys] notebookItemTypes => [%s]", tostring(notebookItemTypes)))

    for _, itemType in ipairs(notebookItemTypes) do
        print(string.format("[NoropiaHotkeys] itemType [%s] included", itemType))
    end
end

if (NoropiaHotkeys.settings.debug) then
    Events.OnGameStart.Add(NoropiaHotkeys.debugNotebookItemTypes)
end
