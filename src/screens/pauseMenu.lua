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

    function self:keypressed(key)
        pauseMenu.KeyPressed(key)
    end

    function self:update(dt)
        pauseMenu.Update(dt)
    end

    function self:draw()
        pauseMenu.Draw()
    end

    return self
end

----------------------------------------
-- Key pressed method
----------------------------------------
function pauseMenu.KeyPressed(key)
    if(key == "escape" and screenManager.GetIsGameplay() == true) then
        if(screenManager.GetIsPaused() == false) then
            screenManager.SetIsPaused(true)
            screenManager.GetScreenObj().push('paused')
        elseif(screenManager.GetIsPaused() == true) then
            screenManager.SetIsPaused(false)
            screenManager.GetScreenObj().pop()
        end
    end
end

----------------------------------------
-- Update method
----------------------------------------
function pauseMenu.Update(dt)

end

----------------------------------------
-- Draw method
----------------------------------------
function pauseMenu.Draw()
    love.graphics.setColor(0, 0, 0, 50)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255, 255, 255, 255)
end

return pauseMenu