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

function FACTORESO.ProcessDamageDone(damage, type, abilityId)
end

function FACTORESO.ProcessDamageTaken(damage, type, abilityId)
end

function FACTORESO.OnCombat(eventCode, result, isError, abilityName, abilityGraphic, 
abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, 
powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
    local target = zo_strformat("<<1>>", targetName)
    local source = zo_strformat("<<1>>", sourceName)

    if result == ACTION_RESULT_DAMAGE then
        if target == FACTORESO.playerName then
            --d("i took dmg")
            FACTORESO.damages[damageType] = FACTORESO.damages[damageType] + hitValue
        elseif source == FACTORESO.playerName then
            --d("i did dmg")
        end
    elseif result == ACTION_RESULT_CRITICAL_DAMAGE then
        if target == FACTORESO.playerName then
            --d("i took crit dmg")
        elseif source == FACTORESO.playerName then
            --d("i did crit dmg")
        end
    elseif result == ACTION_RESULT_DOT_TICK then
        if target == FACTORESO.playerName then
            --d("i took dot dmg")
        elseif source == FACTORESO.playerName then
            --d("i did dot dmg")
        end
    elseif result == ACTION_RESULT_DOT_TICK_CRITICAL then
        if target == FACTORESO.playerName then
            --d("i took crit dot dmg")
        elseif source == FACTORESO.playerName then
            --d("i did crit dot dmg")
        end
    elseif result == ACTION_RESULT_HEAL then
        if target == FACTORESO.playerName then
            --d("i was healed")
        elseif source == FACTORESO.playerName then
            --d("i healed something")
        end
    elseif result == ACTION_RESULT_CRITICAL_HEAL then
        if target == FACTORESO.playerName then
            --d("i was crit healed")
        elseif source == FACTORESO.playerName then
            --d("i crit healed something")
        end
    elseif result == ACTION_RESULT_HOT_TICK then
        if target == FACTORESO.playerName then
            --d("i was heal ticked")
        elseif source == FACTORESO.playerName then
            --d("i heal ticked something")
        end
    elseif result == ACTION_RESULT_HOT_TICK_CRITICAL then
        if target == FACTORESO.playerName then
            --d("i was crit heal ticked")
        elseif source == FACTORESO.playerName then
            --d("i crit heal ticked something")
        end
    end
end

function FACTORESO.ShowMain()
    local totalDamage = 
    FACTORESO.damages[DAMAGE_TYPE_COLD] +
    FACTORESO.damages[DAMAGE_TYPE_DISEASE] +
    FACTORESO.damages[DAMAGE_TYPE_DROWN] +
    FACTORESO.damages[DAMAGE_TYPE_EARTH] +
    FACTORESO.damages[DAMAGE_TYPE_FIRE] +
    FACTORESO.damages[DAMAGE_TYPE_GENERIC] +
    FACTORESO.damages[DAMAGE_TYPE_MAGIC] +
    FACTORESO.damages[DAMAGE_TYPE_NONE] +
    FACTORESO.damages[DAMAGE_TYPE_OBLIVION] +
    FACTORESO.damages[DAMAGE_TYPE_PHYSICAL] +
    FACTORESO.damages[DAMAGE_TYPE_POISON] +
    FACTORESO.damages[DAMAGE_TYPE_SHOCK]

    local percentFire = (FACTORESO.damages[DAMAGE_TYPE_FIRE] / totalDamage) * 100

    FACTORESO_MainLabel:SetText(zo_strformat(
        "total damage taken: <<1>>\n % fire damage: <<2>>", totalDamage, percentFire
    ));
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