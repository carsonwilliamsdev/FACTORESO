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
    -- menu
    local mainpos = FACTORESO.savedVariables[FACTORESO_Main:GetName()]
    FACTORESO_Main:ClearAnchors()
    local mainleft = 0
    local maintop = 0
    if mainpos ~= nil then
        mainleft = mainpos[1]
        maintop = mainpos[2]
    end
    FACTORESO_Main:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, mainleft, maintop)

    -- button
    local buttonpos = FACTORESO.savedVariables[FACTORESO_ButtonBg:GetName()]
    FACTORESO_ButtonBg:ClearAnchors()
    local buttonleft = 0
    local buttontop = 0
    if buttonpos ~= nil then
        buttonleft = buttonpos[1]
        buttontop = buttonpos[2]
    end
    FACTORESO_ButtonBg:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, buttonleft, buttontop)
end

EVENT_MANAGER:RegisterForEvent(FACTORESO.name, EVENT_ADD_ON_LOADED, FACTORESO.OnAddOnLoaded)