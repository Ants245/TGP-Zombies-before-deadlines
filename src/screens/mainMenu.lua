screenManager = require('lib/managers/screenManager')
screen = require('plugins/Screen')
log = require('plugins/Log')

mainMenu = {}

local x, y, w, h = 20, 20, 40, 20

----------------------------------------
-- Create new screen
----------------------------------------
function mainMenu.new()
    local self = screen.new()

    log.info("[INIT]: Loading main menu...")

    screenManager.SetIsGameplay(false)

    function self:keypressed(key)
        mainMenu.KeyPressed(key)
    end

    function self:update(dt)
        mainMenu.Update(dt)
    end

    function self:draw()
        mainMenu.Draw()
    end

    return self
end

----------------------------------------
-- Key pressed method
----------------------------------------
function mainMenu.KeyPressed(key)
    if(key == "space")then
        screenManager.GetScreenObj().switch('survival')
    end
end

----------------------------------------
-- Update method
----------------------------------------
function mainMenu.Update(dt)
    w = w + 2
    h = h + 1
end

----------------------------------------
-- Draw method
----------------------------------------
function mainMenu.Draw()
    love.graphics.rectangle('fill', x, y, w, h)
end

return mainMenu