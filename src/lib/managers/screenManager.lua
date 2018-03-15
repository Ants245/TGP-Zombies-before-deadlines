manager = require('plugins/ScreenManager')

screenManager = {}

-- If active screen is gameplay/level
isGameplay = false

----------------------------------------
-- Screen Manager Initializtion
----------------------------------------
function screenManager.Load()
    isGameplay = false

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

----------------------------------------
-- Screen Manager Utility methods
----------------------------------------
function screenManager.SetIsGameplay(setIsGameplay)
    isGameplay = setIsGameplay
end

function screenManager.GetIsGameplay()
    return isGameplay
end

return screenManager