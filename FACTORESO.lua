FACTORESO = {}
FACTORESO.name = "FACTORESO"

function FACTORESO:Initialize()
    self.savedVariables = ZO_SavedVars:New("FACTORESOSavedVariables", 1, nil, {})
    self:RestorePosition()
end

function FACTORESO.OnAddOnLoaded(event, addonName)
    if addonName == FACTORESO.name then
        FACTORESO:Initialize()
    end
end

function FACTORESO.OnIndicatorMoveStop()
    FACTORESO.savedVariables.left = FACTORESOIndicator:GetLeft()
    FACTORESO.savedVariables.top = FACTORESOIndicator:GetTop()
end

function FACTORESO:RestorePosition()
    local left = self.savedVariables.left
    local top = self.savedVariables.top
   
    FACTORESOIndicator:ClearAnchors()
    FACTORESOIndicator:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
  end

EVENT_MANAGER:RegisterForEvent(FACTORESO.name, EVENT_ADD_ON_LOADED, FACTORESO.OnAddOnLoaded)