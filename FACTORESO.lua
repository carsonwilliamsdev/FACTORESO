FACTORESO = {}
FACTORESO.name = "FACTORESO"

function FACTORESO:Initialize()
    self.savedVariables = ZO_SavedVars:New("FACTORESOSavedVariables", 1, nil, {})
    SCENE_MANAGER:RegisterTopLevel(FACTORESO_Main, false)
    FACTORESO.InitPositions()
end

function FACTORESO.OnAddOnLoaded(event, addonName)
    if addonName == FACTORESO.name then
        FACTORESO:Initialize()
    end
end

--[[
//pseudo code for damage type tracker
function FACTORESO. EVENT COMBAT EVENT
    if (target is me) then
        damagetypearray[damagetype] = damagedone
    end
end
]]--

function FACTORESO.ShowMain()
    SCENE_MANAGER:ToggleTopLevel(FACTORESO_Main)
end

function FACTORESO.StorePosition(control)
	local name = control:GetName()
	FACTORESO.savedVariables[name] = {control:GetLeft(), control:GetTop()}
end


function FACTORESO.InitPositions()
    local mainpos = FACTORESO.savedVariables[FACTORESO_Main:GetName()]
    FACTORESO_Main:ClearAnchors()
    FACTORESO_Main:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, mainpos[1], mainpos[2])

    local buttonpos = FACTORESO.savedVariables[FACTORESO_ButtonBg:GetName()]
    FACTORESO_ButtonBg:ClearAnchors()
    FACTORESO_ButtonBg:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, buttonpos[1], buttonpos[2])
end

EVENT_MANAGER:RegisterForEvent(FACTORESO.name, EVENT_ADD_ON_LOADED, FACTORESO.OnAddOnLoaded)