FACTORESO = {}
FACTORESO.name = "FACTORESO"

function FACTORESO:Initialize()
end

function FACTORESO.OnAddOnLoaded(event, addonName)
    if addonName == FACTORESO.name then
        FACTORESO:Initialize()
    end
end

EVENT_MANAGER:RegisterForEvent(FACTORESO.name, EVENT_ADD_ON_LOADED, FACTORESO.OnAddOnLoaded)