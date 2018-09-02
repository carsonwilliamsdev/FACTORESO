FACTORESO = {}
FooAddon.name = "FACTORESO"

function FooAddon:Initialize()
end

function FooAddon.OnAddOnLoaded(event, addonName)
    if addonName == FooAddon.name then
    FooAddon:Initialize()
    end
end

EVENT_MANAGER:RegisterForEvent(FooAddon.name, EVENT_ADD_ON_LOADED, FooAddon.OnAddOnLoaded)