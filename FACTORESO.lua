FACTORESO = {}
FACTORESO.name = "FACTORESO"

function FACTORESO:Initialize()
    self.savedVariables = ZO_SavedVars:New("FACTORESOSavedVariables", 1, nil, {})
    SCENE_MANAGER:RegisterTopLevel(FACTORESO_Main, false)
    FACTORESO.InitPositions()
    EVENT_MANAGER:RegisterForEvent(self.name, EVENT_COMBAT_EVENT, self.OnCombat)

    FACTORESO.playerName = GetUnitName("player")

    FACTORESO.damages = {}
    FACTORESO.damages[DAMAGE_TYPE_COLD] = 0
    FACTORESO.damages[DAMAGE_TYPE_DISEASE] = 0
    FACTORESO.damages[DAMAGE_TYPE_DROWN] = 0
    FACTORESO.damages[DAMAGE_TYPE_EARTH] = 0
    FACTORESO.damages[DAMAGE_TYPE_FIRE] = 0
    FACTORESO.damages[DAMAGE_TYPE_GENERIC] = 0
    FACTORESO.damages[DAMAGE_TYPE_MAGIC] = 0
    FACTORESO.damages[DAMAGE_TYPE_NONE] = 0
    FACTORESO.damages[DAMAGE_TYPE_OBLIVION] = 0
    FACTORESO.damages[DAMAGE_TYPE_PHYSICAL] = 0
    FACTORESO.damages[DAMAGE_TYPE_POISON] = 0
    FACTORESO.damages[DAMAGE_TYPE_SHOCK] = 0
end

function FACTORESO.OnAddOnLoaded(event, addonName)
    if addonName == FACTORESO.name then
        FACTORESO:Initialize()
    end
end


function FACTORESO.OnCombat(eventCode, result, isError, abilityName, abilityGraphic, 
abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, 
powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)

    if targetName ~= nil and zo_strformat("<<1>>", targetName) == FACTORESO.playerName 
    and result == ACTION_RESULT_DAMAGE and damageType ~= nil and hitValue ~= nil then
        FACTORESO.damages[damageType] = FACTORESO.damages[damageType] + hitValue
        --d(zo_strformat("i took <<1>> damage of damagetype=<<2>>. total=<<3>>", 
        --  hitValue, damageType, FACTORESO.damages[damageType]))
    end
end

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