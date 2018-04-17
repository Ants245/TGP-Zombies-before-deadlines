audioManager = require('lib/managers/audioManager')
screenManager = require('lib/managers/screenManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

pauseMenu = {}

----------------------------------------
-- Create new screen
----------------------------------------
function pauseMenu.new()
    local self = screen.new()

    log.info("[INIT]: Loading pause menu...")

    screenManager.SetIsGameplay(true)

    function self:update(dt)
        pauseMenu.Update(dt)
    end

    function self:draw()
        pauseMenu.Draw()
    end

    return self
end

----------------------------------------
-- Update method
----------------------------------------
function pauseMenu.Update(dt)
    -- Toggle mouse cursor if game is paused
    if(screenManager.GetIsPaused() == true) then
        love.mouse.setVisible(true)
        audioManager.sounds.music.gameplay_music:setVolume(0.025)
    else 
        love.mouse.setVisible(false)
        audioManager.sounds.music.gameplay_music:setVolume(0.15)
    end
end

----------------------------------------
-- Draw method
----------------------------------------
function pauseMenu.Draw()
    -- Draw "Paused" text on center of screen
    love.graphics.print("PAUSED!", (love.graphics.getWidth() / 2) - 50, (love.graphics.getHeight() / 2) - 50)
    love.graphics.print("Press escape to continue", (love.graphics.getWidth() / 2) - 150, (love.graphics.getHeight() / 2) + 50)

    -- Transparent background overlay
    love.graphics.setColor(0, 0, 0, 50)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255, 255, 255, 255)
end

return pauseMenu