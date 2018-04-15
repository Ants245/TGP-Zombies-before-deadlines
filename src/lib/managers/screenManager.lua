manager = require('plugins/ScreenManager')

screenManager = {}

----------------------------------------
-- Screen Manager Initializtion
----------------------------------------
function screenManager.Load()
    -- If active screen is gameplay/level
    isGameplay = false
    isPaused = false

    -- Table of all screens to load
    local screens = {
        main = require('screens/mainMenu'),
        paused = require('screens/pauseMenu'),
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

    if(isGameplay == true)then
        if(key == "escape" and isPaused == false) then
            isPaused = true
            manager.push('paused')
        elseif(key == "escape" and isPaused == true) then
            isPaused = false
            manager.pop()
        end
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

function screenManager.SetIsPaused(setIsPaused)
    isPaused = setIsPaused
end

function screenManager.GetIsPaused()
    return isPaused
end

return screenManager