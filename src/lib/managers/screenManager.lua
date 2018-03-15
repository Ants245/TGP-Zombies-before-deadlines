manager = require('plugins/ScreenManager')

screenManager = {}

----------------------------------------
-- Initializtion method
----------------------------------------
function screenManager.Load()
    -- Table of all screens to load
    local screens = {
        main = require('screens/mainMenu'),
        level_1 = require('screens/level_1'),
        level_2 = require('screens/level_2'),
        level_3 = require('screens/level_3')
    }
    manager.init(screens, 'main')
end

function screenManager.KeyPressed(key)
    if(key == "1")then
        manager.switch('level_1')
    end
    if(key == "2")then
        manager.switch('level_1')
    end
    if(key == "3")then
        manager.switch('level_1')
    end
end

----------------------------------------
-- Update method
----------------------------------------
function screenManager.Update(dt)
    manager.update(dt)
end

----------------------------------------
-- Draw method
----------------------------------------
function screenManager.Draw()
    manager.draw()
end

return screenManager