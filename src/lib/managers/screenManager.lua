stateSwitcher = require('plugins/StateSwitcher')

screenManager = {}

----------------------------------------
-- Initializtion method
----------------------------------------
function screenManager.Load()
    stateSwitcher.clear()
end

----------------------------------------
-- Utility methods
----------------------------------------
function screenManager.GetState()
    return stateSwitcher
end

function screenManager.SwitchState(screenNameString)
    stateSwitcher.switch(screenNameString)
end

return screenManager