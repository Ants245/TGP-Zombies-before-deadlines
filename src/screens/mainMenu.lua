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

    function self:update(dt)
        mainMenu.Update(dt)
    end

    function self:draw()
        mainMenu.Draw()
    end

    return self
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