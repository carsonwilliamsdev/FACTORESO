FACTORESO = {}
FACTORESO.name = "FACTORESO"

function FACTORESO:Initialize()
    self.savedVariables = ZO_SavedVars:New("FACTORESOSavedVariables", 1, nil, {})
    SCENE_MANAGER:RegisterTopLevel(FACTORESO_Main, false)
end

function FACTORESO.OnAddOnLoaded(event, addonName)
    if addonName == FACTORESO.name then
        FACTORESO:Initialize()
    end
end

function FACTORESO.ShowMain()
    SCENE_MANAGER:ToggleTopLevel(FACTORESO_Main)
end

EVENT_MANAGER:RegisterForEvent(FACTORESO.name, EVENT_ADD_ON_LOADED, FACTORESO.OnAddOnLoaded)