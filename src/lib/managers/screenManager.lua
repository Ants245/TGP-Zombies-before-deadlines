manager = require('plugins/ScreenManager')

screenManager = {}

----------------------------------------
-- Screen Manager Initializtion
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

----------------------------------------
-- Screen Manager Key press check
----------------------------------------
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
-- Screen Manager Update
----------------------------------------
function screenManager.Update(dt)
    manager.update(dt)
end

----------------------------------------
-- Screen Manager Draw
----------------------------------------
function screenManager.Draw()
    manager.draw()
end

return screenManager