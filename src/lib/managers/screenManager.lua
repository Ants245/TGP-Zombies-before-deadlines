manager = require('plugins/ScreenManager')
playerManager = require('lib/managers/playerManager')

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
        gameOver = require('screens/gameOver'),
        survival = require('screens/survival')
    }
    manager.init(screens, 'main')
end

----------------------------------------
-- Screen Manager Key press check
----------------------------------------
function screenManager.KeyPressed(key)
    if(key == "space")then
        manager.switch('survival')
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

    if(playerManager.GetPlayerHealth() == 0) then
        manager.switch('gameOver')
    end
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